// Copyright 2016 Workiva Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

library over_react.transformer.impl_generation;

import 'package:analyzer/analyzer.dart';
import 'package:logging/logging.dart';
import 'package:over_react/src/component_declaration/annotations.dart' as annotations;
import 'package:over_react/src/builder/generation/declaration_parsing.dart';
import 'package:source_span/source_span.dart';
import 'package:transformer_utils/transformer_utils.dart';

/// A utility class that modifies a [TransformedSourceFile] by generating implementations for a set of [ParsedDeclarations].
///
/// Generates implementations for:
///
/// * A component comprised of a `@Factory()`, `@Component()`, `@Props()`, and optionally a `@State()`
///
///     * Generates:
///
///          * private subclasses for the component, props, and state classes, implementing stubbed methods.
///          * a private React component factory via a call to `registerComponent`.
///
///     * Wires up all the generated component pieces and exposes them via a function assigned to
///     the previously uninitialized factory function variable.
///
/// * Any number of abstract component pieces: `@AbstractProps()`, `@AbstractState()`
///
///     * Replaces fields with generated getters/setters.
///
/// * Any number of mixins: `@PropsMixin()`, `@StateMixin()`
///
///     * Replaces fields with generated getters/setters.
class ImplGenerator {
  ImplGenerator(this.logger, this.sourceFile);

  static const String generatedPrefix = r'_$';
  static const String publicGeneratedPrefix = r'$';

  Logger logger;
  StringBuffer outputContentsBuffer = new StringBuffer();
  bool shouldFixDdcAbstractAccessors = false;

  SourceFile sourceFile;

  generate(ParsedDeclarations declarations) {
    if (declarations.declaresComponent) {
      final factoryName = declarations.factory.node.variables.variables.first.name.toString();

      final consumerPropsName = declarations.props.node.name.toString();
      final publicPropsName = _publicPropsClassNameFromConsumerClassName(consumerPropsName);
      final propsImplName = _propsImplClassNameFromConsumerClassName(consumerPropsName);
      final propsAccessorsMixinName = _accessorsMixinNameFromConsumerName(consumerPropsName);

      final componentClassName = declarations.component.node.name.toString();
      final componentClassImplMixinName = '$generatedPrefix$componentClassName';

      final generatedComponentFactoryName = _componentFactoryName(componentClassName);

      String typedPropsFactoryImpl = '';
      String typedStateFactoryImpl = '';

      // ----------------------------------------------------------------------
      //   Factory implementation
      // ----------------------------------------------------------------------

      if (declarations.factory.node.variables.variables.length != 1) {
        logger.severe('Factory declarations must a single variable.');
//            span: getSpan(sourceFile, declarations.factory.node.variables));
      }

      /// Factories are stubbed for the generated factories and may only be initialized with the generated factory.
      declarations.factory.node.variables.variables.forEach((variable) {
        if (variable.initializer?.toSource() != '\$$factoryName' && variable.initializer != null) {
          logger.severe(
              'Factories are stubbed for the generated factories and may only be initialized with the generated factory.',
//              span: getSpan(sourceFile, variable.initializer)
          );
        }
      });

      String parentTypeParam = 'null';
      String parentTypeParamComment = '';

      Identifier parentType = declarations.component.subtypeOfValue;
      if (parentType != null) {
        parentTypeParamComment = ' /* from `subtypeOf: ${getSpan(sourceFile, parentType).text}` */';

        if (parentType is PrefixedIdentifier) {
          var prefix = parentType.prefix.name;
          var parentClassName = parentType.identifier.name;

          parentTypeParam = prefix + '.' + _componentFactoryName(parentClassName);
        } else {
          var parentClassName = parentType.name;

          parentTypeParam = _componentFactoryName(parentClassName);
        }
      }

      if (parentTypeParam == generatedComponentFactoryName) {
        /// It doesn't make sense to have a component subtype itself, and also an error occurs
        /// if a component's factory variable tries to reference itself during its initialization.
        /// Therefore, this is not allowed.
        logger.severe('A component cannot be a subtype of itself.',
//            span: getSpan(sourceFile, declarations.component.metaNode)
        );
      }

      outputContentsBuffer
        ..writeln('// React component factory implementation.')
        ..writeln('//')
        ..writeln('// Registers component implementation and links type meta to builder factory.')
        // TODO: verify that the component class has a default constructor?
        ..writeln('final $generatedComponentFactoryName = registerComponent(() => new $componentClassImplMixinName(),')
        ..writeln('    builderFactory: $factoryName,')
        ..writeln('    componentClass: $componentClassName,')
        ..writeln('    isWrapper: ${declarations.component.meta.isWrapper},')
        ..writeln('    parentType: $parentTypeParam,$parentTypeParamComment')
        ..writeln('    displayName: ${stringLiteral(factoryName)}')
        ..writeln(');')
        ..writeln();

      // ----------------------------------------------------------------------
      //   Props implementation
      // ----------------------------------------------------------------------

      // Generate accessors mixin and props metaFor constant
      outputContentsBuffer.write(_generateAccessorsMixin(AccessorType.props, propsAccessorsMixinName, declarations.props, consumerPropsName));
      outputContentsBuffer.write(_generateMetaConstant(AccessorType.props, propsAccessorsMixinName, publicPropsName));

      /// FooProps $Foo([Map backingProps]) => new FooProps(backingProps);
      outputContentsBuffer.writeln('$propsImplName \$$factoryName([Map backingProps]) => new $propsImplName(backingProps);');

      final String propKeyNamespace = _getAccessorKeyNamespace(declarations.props);

      outputContentsBuffer.write(_generateConcretePropsOrStateImpl(
        AccessorType.props, consumerPropsName, propsImplName, generatedComponentFactoryName,
        propKeyNamespace, declarations.props, propsAccessorsMixinName, publicPropsName));

      typedPropsFactoryImpl =
          '  @override\n'
          // Don't type this so that it doesn't interfere with classes with generic parameter props type:
          //    class FooComponent<T extends FooProps> extends UiComponent<T> {...}
          // TODO use long-term solution of component impl class instantiated via factory constructor
          '  typedPropsFactory(Map backingMap) => new $propsImplName(backingMap) as dynamic;\n\n';

      // ----------------------------------------------------------------------
      //   State implementation
      // ----------------------------------------------------------------------
      if (declarations.state != null) {
        final stateName = _classNameFromNode(declarations.state);
        final publicStateName = _publicPropsClassNameFromConsumerClassName(stateName);
        final stateImplName = _propsImplClassNameFromConsumerClassName(stateName);
        final stateAccessorsMixinName = _accessorsMixinNameFromConsumerName(stateName);

        outputContentsBuffer.write(_generateAccessorsMixin(AccessorType.state, stateAccessorsMixinName, declarations.state, stateName));
        outputContentsBuffer.write(_generateMetaConstant(AccessorType.state, stateAccessorsMixinName, publicStateName));

        outputContentsBuffer
          ..writeln('// Concrete state implementation.')
          ..writeln('//')
          ..writeln('// Implements constructor and backing map.')
          ..writeln('class $stateImplName extends $stateName with $stateAccessorsMixinName implements $publicStateName{')
          ..writeln('  $stateImplName(Map backingMap) : this._state = ({}) {')
          ..writeln('    this._state = backingMap ?? ({});')
          ..writeln('  }')
          ..writeln()
          ..writeln('  /// The backing state map proxied by this class.')
          ..writeln('  @override')
          ..writeln('  Map get state => _state;')
          ..writeln('  Map _state;')
          ..writeln()
          // Wrap Map literal in parens to work around https://github.com/dart-lang/sdk/issues/24410
          ..writeln()
          ..writeln('  /// Let [UiState] internals know that this class has been generated.')
          ..writeln('  @override')
          ..writeln('  bool get \$isClassGenerated => true;')
          ..writeln('}')
          ..writeln();

        typedStateFactoryImpl =
          '  @override\n'
          // Don't type this so that it doesn't interfere with classes with generic parameter state type:
          //    class FooComponent<T extends FooProps, T extends FooState> extends UiStatefulComponent<T> {...}
          // TODO use long-term solution of component impl class instantiated via factory constructor
          // TODO: Check if this lack of typing will work with dart 2's strong typing req's.
          '  typedStateFactory(Map backingMap) => new $stateImplName(backingMap) as dynamic;\n\n';
      }

      // ----------------------------------------------------------------------
      //   Component implementation
      // ----------------------------------------------------------------------
      outputContentsBuffer
        ..writeln('// Concrete component implementation mixin.')
        ..writeln('//')
        ..writeln('// Implements typed props/state factories, defaults `consumedPropKeys` to the keys')
        ..writeln('// generated for the associated props class.')
        ..writeln('class $componentClassImplMixinName extends $componentClassName {')
        ..write(typedPropsFactoryImpl)
        ..write(typedStateFactoryImpl)
        ..writeln('  /// Let [UiComponent] internals know that this class has been generated.')
        ..writeln('  @override')
        ..writeln('  bool get \$isClassGenerated => true;')
        ..writeln()
        ..writeln('  /// The default consumed props, taken from $consumerPropsName.')
        ..writeln('  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.')
        ..writeln('  @override')
        ..writeln('  final List<ConsumedProps> \$defaultConsumedProps = '
                        'const [${_metaConstantName(publicPropsName)}];')
        ..writeln('}');

      var implementsTypedPropsStateFactory = declarations.component.node.members.any((member) =>
          member is MethodDeclaration &&
          !member.isStatic &&
          (member.name.name == 'typedPropsFactory' || member.name.name == 'typedStateFactory')
      );

      if (implementsTypedPropsStateFactory) {
        // Can't be an error, because consumers may be implementing typedPropsFactory or typedStateFactory in their components.
        logger.warning(
            'Components should not add their own implementions of typedPropsFactory or typedStateFactory.',
//            span: getSpan(sourceFile, declarations.component.node)
        );
      }
    }

    // ----------------------------------------------------------------------
    //   Props/State Mixins implementations
    // ----------------------------------------------------------------------

    declarations.propsMixins.forEach((propMixin) {
      _generateAccessorsAndMetaConstantForMixin(AccessorType.props, propMixin);
    });

    declarations.stateMixins.forEach((stateMixin) {
      _generateAccessorsAndMetaConstantForMixin(AccessorType.state, stateMixin);
    });

    // ----------------------------------------------------------------------
    //   Abstract Props/State implementations
    // ----------------------------------------------------------------------
    declarations.abstractProps.forEach((abstractPropsClass) {
      var className = _classNameFromNode(abstractPropsClass);
      outputContentsBuffer.write(_generateAccessorsMixin(
          AccessorType.props, _accessorsMixinNameFromConsumerName(className), abstractPropsClass,
          className));
      outputContentsBuffer.write(_generateMetaConstant(
          AccessorType.props, _accessorsMixinNameFromConsumerName(className),
          _publicPropsClassNameFromConsumerClassName(className)));
    });

    declarations.abstractState.forEach((abstractStateClass) {
      var className = _classNameFromNode(abstractStateClass);
      outputContentsBuffer.write(_generateAccessorsMixin(
          AccessorType.state, _accessorsMixinNameFromConsumerName(className), abstractStateClass,
          className));
      outputContentsBuffer.write(_generateMetaConstant(
          AccessorType.state, _accessorsMixinNameFromConsumerName(className),
          _publicPropsClassNameFromConsumerClassName(className)));
    });
  }

  bool hasAbstractGetter(ClassDeclaration classDeclaration, String type, String name) {
      return classDeclaration.members.any((member) {
        return (
            member is MethodDeclaration &&
            member.isGetter &&
            !member.isSynthetic &&
            member.isAbstract &&
            member.name.name == name &&
            member.returnType?.toSource() == type
        );
      });
    }

  // ----------------------------------------------------------------------
  //   Accessor generation
  // ----------------------------------------------------------------------

  static const String proxiedPropsMapName = 'props';
  static const String proxiedStateMapName = 'state';

  static const String staticPropKeysName = '${publicGeneratedPrefix}propKeys';
  static const String staticStateKeysName = '${publicGeneratedPrefix}stateKeys';

  static const String staticPropsName = '${publicGeneratedPrefix}props';
  static const String staticStateName = '${publicGeneratedPrefix}state';

  static const String staticConsumedPropsName = '${publicGeneratedPrefix}consumedProps';


  AccessorOutput generateAccessors(
      AccessorType type,
      NodeWithMeta<ClassDeclaration, annotations.TypedMap> typedMap,
      String consumerClassName
  ) {
//    if (shouldFixDdcAbstractAccessors) {
//      fixDdcAbstractAccessors(type, typedMap);
//    }

    String keyNamespace = _getAccessorKeyNamespace(typedMap);

    final bool isProps = type == AccessorType.props;

    final String proxiedMapName = isProps ? proxiedPropsMapName : proxiedStateMapName;
    final String keyListName = isProps ? staticPropKeysName : staticStateKeysName;
    final String constantListName = isProps ? staticPropsName : staticStateName;
    final String constConstructorName = isProps ? 'PropDescriptor' : 'StateDescriptor';

    Map keyConstants = {};
    Map constants = {};

    StringBuffer output = new StringBuffer();

    typedMap.node.members
        .where((member) => member is FieldDeclaration && !member.isStatic)
        .forEach((_field) {
          final field = _field as FieldDeclaration; // ignore: avoid_as

          T getConstantAnnotation<T>(AnnotatedNode member, String name, T value) {
            return member.metadata.any((annotation) => annotation.name?.name == name) ? value : null;
          }

          annotations.Accessor accessorMeta = instantiateAnnotation(field, annotations.Accessor);
          annotations.Accessor requiredProp = getConstantAnnotation(field, 'requiredProp', annotations.requiredProp);
          annotations.Accessor nullableRequiredProp = getConstantAnnotation(field, 'nullableRequiredProp', annotations.nullableRequiredProp);
          // ignore: deprecated_member_use
          annotations.Required requiredMeta = instantiateAnnotation(field, annotations.Required);


          if (accessorMeta?.doNotGenerate == true) {
            logger.fine('Skipping generation of field `$field`.',
//                span: getSpan(sourceFile, field)
            );

            return;
          }

          field.fields.variables.forEach((VariableDeclaration variable) {
            if (variable.initializer != null) {
              logger.severe(
                  'Fields are stubs for generated setters/getters and should not have initializers.',
//                  span: getSpan(sourceFile, variable)
              );
            }

            String accessorName = variable.name.name;

            String individualKeyNamespace = accessorMeta?.keyNamespace ?? keyNamespace;
            String individualKey = accessorMeta?.key ?? accessorName;

            /// Necessary to work around issue where private static declarations in different classes
            /// conflict with each other in strong mode: https://github.com/dart-lang/sdk/issues/29751
            /// TODO remove once that issue is resolved
            String staticConstNamespace = typedMap.node.name.name;

            String keyConstantName = '${generatedPrefix}key__${accessorName}__$staticConstNamespace';
            String keyValue = stringLiteral(individualKeyNamespace + individualKey);

            String constantName = '${generatedPrefix}prop__${accessorName}__$staticConstNamespace';
            String constantValue = 'const $constConstructorName($keyConstantName';

            var annotationCount = 0;

            if (accessorMeta != null) {
              annotationCount++;

              if (accessorMeta.isRequired) {
                constantValue += ', isRequired: true';

                if (accessorMeta.isNullable) constantValue += ', isNullable: true';

                if (accessorMeta.requiredErrorMessage != null && accessorMeta.requiredErrorMessage.isNotEmpty) {
                  constantValue += ', errorMessage: ${stringLiteral(accessorMeta.requiredErrorMessage)}';
                }
              }
            }

            if (requiredMeta != null) {
              constantValue += ', isRequired: true';

              if (requiredMeta.isNullable) constantValue += ', isNullable: true';

              if (requiredMeta.message != null && requiredMeta.message.isNotEmpty) {
                constantValue += ', errorMessage: ${stringLiteral(requiredMeta.message)}';
              }
            }

            if (requiredProp != null) {
              annotationCount++;
              constantValue += ', isRequired: true';
            }

            if (nullableRequiredProp != null) {
              annotationCount++;
              constantValue += ', isRequired: true, isNullable: true';
            }

            if (annotationCount > 1) {
              logger.severe(
                  '@requiredProp/@nullableProp/@Accessor cannot be used together.\n'
                  'You can use `@Accessor(required: true)` or `isNullable: true` instead of the shorthand versions.',
//                  span: getSpan(sourceFile, field)
              );
            }

            constantValue += ')';

            keyConstants[keyConstantName] = keyValue;
            constants[constantName] = constantValue;

            final type = field.fields.type?.toSource();
            String typeString = type == null ? '' : '$type ';
            String setterTypeString = field.covariantKeyword == null
                ? typeString
                : '${field.covariantKeyword} $typeString';

            String generatedAccessor =
                '  @override\n'
                '  /// Go to [$consumerClassName.$accessorName] to see the source code for this prop\n'
                '  ${typeString}get $accessorName => $proxiedMapName[$keyConstantName];\n'
                '  @override\n'
                '  /// Go to [$consumerClassName.$accessorName] to see the source code for this prop\n'
                '  set $accessorName(${setterTypeString}value) => $proxiedMapName[$keyConstantName] = value;\n';

            output.write(generatedAccessor);

            logger.fine('Generated accessor `$accessorName` with key $keyValue.');
//                span: getSpan(sourceFile, variable)
          });

          if (field.fields.variables.length > 1 &&
              (field.documentationComment != null || field.metadata.isNotEmpty)) {
            logger.warning(
                'Note: accessors declared as comma-separated variables will not all be generated '
                'with the original doc comments and annotations; only the first variable will.',
//                span: getSpan(sourceFile, field.fields)
            );
          }
        });

    var keyConstantsImpl;
    var constantsImpl;

    if (keyConstants.keys.isEmpty) {
      keyConstantsImpl = '';
    } else {
      keyConstantsImpl =
          keyConstants.keys.map((keyName) => '  static const String $keyName = ${keyConstants[keyName]}').join(';\n') +
          ';\n';
    }

    if (constants.keys.isEmpty) {
      constantsImpl = '';
    } else {
      constantsImpl =
          constants.keys.map((constantName) => '  static const $constConstructorName $constantName = ${constants[constantName]}').join(';\n') +
          ';\n';
    }

    String keyListImpl =
        '  static const List<String> $keyListName = const [' +
        keyConstants.keys.join(', ') +
        '];\n';

    String listImpl =
        '  static const List<$constConstructorName> $constantListName = const [' +
        constants.keys.join(', ') +
        '];\n';

    String staticVariablesImpl = '  /* GENERATED CONSTANTS */\n$constantsImpl$keyConstantsImpl\n$listImpl$keyListImpl';

    output.write(staticVariablesImpl);
    return new AccessorOutput(output.toString());
  }

  static String _getAccessorKeyNamespace(NodeWithMeta<ClassDeclaration, annotations.TypedMap> typedMap) {
    // Default to the name of the class followed by a period.
    var defaultNamespace = _publicPropsClassNameFromConsumerClassName(typedMap.node.name.name) + '.';
    // Allow the consumer to specify a custom namespace that trumps the default.
    var specifiedKeyNamespace = typedMap.meta?.keyNamespace;

    return specifiedKeyNamespace ?? defaultNamespace;
  }

  /// Convenience method to get the classname belonging to [classNode].
  static String _classNameFromNode(NodeWithMeta classNode) {
    if (classNode.node is ClassDeclaration) {
      return (classNode.node as ClassDeclaration)?.name.toString(); // ignore: avoid_as
    }
    return '';
  }

  /// Converts the consumer's written props classname to the concrete props
  /// implementation's classname by adding '$' to the [generatedPrefix].
  ///
  /// Example:
  ///   Input: '_$FooProps'
  ///   Output: '_$$FooProps'
  static String _propsImplClassNameFromConsumerClassName(String className) {
    if (className == null) {
      throw new ArgumentError.notNull(className);
    }

    return className.replaceFirst(generatedPrefix, '$generatedPrefix\$');
  }

  /// Converts the consumer's written props classname to a public classname by
  /// stripping [generatedPrefix] from the classname.
  ///
  /// Example:
  ///   Input: '_$FooProps'
  ///   Output: 'FooProps'
  static String _publicPropsClassNameFromConsumerClassName(String className) {
    if (className == null) {
      throw new ArgumentError.notNull(className);
    }

    return className.replaceFirst(generatedPrefix, '');
  }

  /// Gets the generated component factory name from the component classname.
  ///
  /// Example:
  ///   Input: FooComponent
  ///   Output: $FooComponentFactory
  static String _componentFactoryName(String componentClassName) {
    if (componentClassName == null) {
      throw new ArgumentError.notNull(componentClassName);
    }

    return '$publicGeneratedPrefix${componentClassName}Factory';
  }

  /// Gets the accessors mixin class from the consumer className.
  ///
  /// Example:
  ///   Input: _$FooProps
  ///   Output: _$FooPropsAccessorsMixin
  static String _accessorsMixinNameFromConsumerName(String className) {
    if (className == null) {
      throw new ArgumentError.notNull(className);
    }

    return '${className}AccessorsMixin';
  }

  /// Gets the meta variable name from the public pros class name.
  ///
  /// Example:
  ///   Input: FooProps
  ///   Output: $metaForFooProps
  static String _metaConstantName(String publicPropsClassname) {
    if (publicPropsClassname == null) {
      throw new ArgumentError.notNull(publicPropsClassname);
    }

    return '${publicGeneratedPrefix}metaFor$publicPropsClassname';
  }

  void _generateAccessorsAndMetaConstantForMixin(AccessorType type, NodeWithMeta node) {
    var isProps = type == AccessorType.props;
    if (!hasAbstractGetter(node.node, 'Map', isProps ? 'props' : 'state')) {
      logger.severe(
        '${isProps
            ? 'Props'
            : 'State'} mixin classes must declare an abstract state getter `Map get ${isProps ? 'props': 'state'};` '
            'so that they can be statically analyzed properly.',
//            span: getSpan(sourceFile, stateMixin.node)
      );
      logger.severe(getSpan(sourceFile, node.node));
    }

    var consumerClassName = _classNameFromNode(node);
    var generatedPropsMixinName = '\$$consumerClassName';
    outputContentsBuffer.write(_generateAccessorsMixin(
        type, generatedPropsMixinName, node,
        consumerClassName, isMixin: true));
    outputContentsBuffer.write(_generateMetaConstant(
        type, generatedPropsMixinName,
        _publicPropsClassNameFromConsumerClassName(consumerClassName)));
  }

  String _generateMetaConstant(AccessorType type, String accessorsMixinName, String publicName) {
    var isProps = type == AccessorType.props;
    final metaStructName = isProps ? 'PropsMeta' : 'StateMeta';
    final String keyListName = isProps ? staticPropKeysName : staticStateKeysName;
    final String constantListName = isProps ? staticPropsName : staticStateName;
    final String metaObjectName = _metaConstantName(publicName);

    var output = new StringBuffer();
    output.writeln('const $metaStructName $metaObjectName = const $metaStructName(');
    output.writeln('  fields: $accessorsMixinName.$constantListName,');
    output.writeln('  keys: $accessorsMixinName.$keyListName,');
    output.writeln(');');
    output.writeln();
    return output.toString();
  }

  String _generateAccessorsMixin(AccessorType type, String accessorsMixinName,
      NodeWithMeta node, String consumerClassName, {isMixin: true}) {
    var isProps = type == AccessorType.props;
    StringBuffer generatedClass = new StringBuffer();
    var implementsClause = isMixin ? 'implements $consumerClassName ' : '';
//    implementsClause = '';
    generatedClass.writeln(
        'abstract class $accessorsMixinName $implementsClause{\n' +
        '  @override' +
        '  Map get ${isProps ? 'props': 'state'};\n'
    );

    generatedClass.write(generateAccessors(type, node, consumerClassName).implementations);
    generatedClass.writeln('}');
    generatedClass.writeln();
    return generatedClass.toString();
  }

  String _generateConcretePropsOrStateImpl(AccessorType type, String consumerName, String implName,
      String componentFactoryName, String propKeyNamespace, NodeWithMeta node, String accessorsMixinName, String publicName) {
    var classDeclaration = new StringBuffer()
      ..write('class $implName extends $consumerName with $accessorsMixinName implements $publicName {\n');
    return (new StringBuffer()
        ..writeln('// Concrete props implementation.')
        ..writeln('//')
        ..writeln('// Implements constructor and backing map, and links up to generated component factory.')
        ..write(classDeclaration)
        ..writeln('  $implName(Map backingMap) : this._props = {} {')
        ..writeln('    this._props = backingMap ?? ({});')
        ..writeln('  }')
        ..writeln()
        // Wrap Map literal in parens to work around https://github.com/dart-lang/sdk/issues/24410
        ..writeln('  /// The backing props map proxied by this class.')
        ..writeln('  @override')
        ..writeln('  Map get props => _props;')
        ..writeln('  Map _props;')
        ..writeln()
        ..writeln('  /// Let [UiProps] internals know that this class has been generated.')
        ..writeln('  @override')
        ..writeln('  bool get \$isClassGenerated => true;')
        ..writeln()
        ..writeln('  /// The [ReactComponentFactory] associated with the component built by this class.')
        ..writeln('  @override')
        ..writeln('  ReactComponentFactoryProxy get componentFactory => $componentFactoryName;')
        ..writeln()
        ..writeln('  /// The default namespace for the prop getters/setters generated for this class.')
        ..writeln('  @override')
        ..writeln('  String get propKeyNamespace => ${stringLiteral(propKeyNamespace)};')
        ..writeln()
        ..writeln('  // Work around https://github.com/dart-lang/sdk/issues/16030 by making')
        ..writeln('  // the original props class abstract and redeclaring `call` in the impl class.')
        ..writeln('  @override')
        ..writeln('  call([c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, c17, c18, c19, c20, c21, c22, c23, c24, c25, c26, c27, c28, c29, c30, c31, c32, c33, c34, c35, c36, c37, c38, c39, c40]);')
//        ..write(generateAccessors(type, node).implementations)
        ..writeln('}')
        ..writeln())
        .toString();
  }

  /// Apply a workaround for an issue where, in the DDC, abstract getter or setter overrides declared in a class clobber
  /// the inherited concrete implementations. <https://github.com/dart-lang/sdk/issues/29914>
  ///
  /// Fixes the issue by generating corresponding abstract getters/setters to complete the pair
  /// for accessors with the `@override` annotation.
  /// NOTE: This is fixed as of dart 2.1.0
  void fixDdcAbstractAccessors(
    AccessorType accessorType,
    NodeWithMeta<ClassDeclaration, annotations.TypedMap> typedMap,
  ) {
    var candidateAccessors = new List<MethodDeclaration>.from(
        typedMap.node.members.where((member) =>
            member is MethodDeclaration &&
            (member.isGetter || member.isSetter) &&
            !member.isSynthetic &&
            !member.isStatic &&
            member.metadata.any((meta) => meta.name.name == 'override')
        )
    );

    for (var accessor in candidateAccessors) {
      // Non-abstract accessors don't exhibit this issue.
      if (!accessor.isAbstract) return;

      var name = accessor.name.name;

      // Don't generate for `Map get props;`/`Map get state;` in mixins
      if (accessorType == AccessorType.props && name == 'props') continue;
      if (accessorType == AccessorType.state && name == 'state') continue;

      if (candidateAccessors.any((other) => other != accessor && other.name.name == name)) {
        // Don't generate when both the getter and the setter are declared.
        continue;
      }

      /// Warning: tests rely on this comment as a means of determining whether this fix was applied.
      ///
      /// DO NOT modify or remove without updating tests
      const String generatedComment = ' /* fixDdcAbstractAccessors workaround: */ ';

      if (accessor.isGetter) {
        var type = accessor.returnType?.toSource();
        var typeString = type == null ? '' : '$type ';

//        transformedFile?.insert(sourceFile?.location(accessor.end),
//            // use `covariant` here to be extra safe in this typing
//            '${generatedComment}set $name(covariant ${typeString}value);');
      } else {
        var parameter = accessor.parameters.parameters.single;
        var type = parameter is SimpleFormalParameter
            ? parameter.type?.toSource()
            // This `null` case is mainly for [FunctionTypedFormalParameter].
            : null;
        var typeString = type == null ? '' : '$type ';

//        transformedFile?.insert(sourceFile?.location(accessor.end),
//            '$generatedComment${typeString}get $name;');
      }
    }
  }
}

enum AccessorType {props, state}

class AccessorOutput {
  final String implementations;

  AccessorOutput(this.implementations);
}
