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

import 'package:analyzer/analyzer.dart';
import 'package:logging/logging.dart';
import 'package:over_react/src/component_declaration/annotations.dart' as annotations;
import 'package:over_react/src/builder/generation/declaration_parsing.dart';
import 'package:over_react/src/builder/util.dart';
import 'package:source_span/source_span.dart';
import 'package:transformer_utils/transformer_utils.dart';

/// A utility class that generates implementations for a set of [ParsedDeclarations] obtained from a [SourceFile].
///
/// Generates implementations for:
///
/// * A component comprised of a `@Factory()`, `@Component()`, `@Props()`, and optionally a `@State()`
///
///     * Generates:
///
///          * Private subclasses for the component, props, and state classes, implementing stubbed methods.
///          * A private React component factory via a call to `registerComponent`.
///          * Metadata containing fields and keys for all Props and State classes.
///
///     * Wires up all the generated component pieces and exposes them via a function assigned to
///     the initializer of factory function variable.
///
/// * Any number of abstract component pieces: `@AbstractProps()`, `@AbstractState()`.
///
///     * Generate private subclasses which implement stubbed methods.
///     * Metadata containing fields and keys for all Abstract Props and Abstract State classes.
///
/// * Any number of mixins: `@PropsMixin()`, `@StateMixin()`.
///
///     * Generates public subclasses which implement stubbed methods for any number of mixins in a library.
///     * Metadata containing fields and keys for all Props and State mixins.
class ImplGenerator {
  ImplGenerator(this.logger, this.sourceFile);

  Logger logger;
  StringBuffer outputContentsBuffer = new StringBuffer();

  SourceFile sourceFile;

  generate(ParsedDeclarations declarations) {
    if (declarations.declaresComponent) {
      final factoryName = declarations.factory.node.variables.variables.first.name.toString();

      final consumerPropsName = declarations.props.node.name.toString();
      final consumablePropsName = _publicPropsOrStateClassNameFromConsumerClassName(consumerPropsName);

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

      String parentTypeParam = 'null';
      String parentTypeParamComment = '';

      Identifier parentType = declarations.component.subtypeOfValue;
      if (parentType != null) {
        parentTypeParamComment = ' /* from `subtypeOf: ${getSpan(sourceFile, parentType).text}` */';

        if (parentType is PrefixedIdentifier) {
          final prefix = parentType.prefix.name;
          final parentClassName = parentType.identifier.name;

          parentTypeParam = prefix + '.' + _componentFactoryName(parentClassName);
        } else {
          final parentClassName = parentType.name;

          parentTypeParam = _componentFactoryName(parentClassName);
        }
      }

      if (parentTypeParam == generatedComponentFactoryName) {
        /// It doesn't make sense to have a component subtype itself, and also an error occurs
        /// if a component's factory variable tries to reference itself during its initialization.
        /// Therefore, this is not allowed.
        logger.severe(messageWithSpan('A component cannot be a subtype of itself.',
            span: getSpan(sourceFile, declarations.component.metaNode))
        );
      }

      outputContentsBuffer
        ..writeln('// React component factory implementation.')
        ..writeln('//')
        ..writeln('// Registers component implementation and links type meta to builder factory.')
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
      outputContentsBuffer.write(_generateAccessorsMixin(
          AccessorType.props, propsAccessorsMixinName, declarations.props,
          consumerPropsName,
          typeParameters: declarations.props.node.typeParameters));
      outputContentsBuffer.write(
          _generateMetaConstImpl(AccessorType.props, declarations.props));
      outputContentsBuffer.write(_generateConsumablePropsOrStateClass(AccessorType.props, declarations.props));

      /// _$$FooProps _$Foo([Map backingProps]) => new _$$FooProps(backingProps);
      outputContentsBuffer.writeln('$propsImplName $generatedPrefix$factoryName([Map backingProps]) => new $propsImplName(backingProps);');

      final String propKeyNamespace = _getAccessorKeyNamespace(declarations.props);

      outputContentsBuffer.write(_generateConcretePropsImpl(
        AccessorType.props, consumerPropsName, propsImplName, generatedComponentFactoryName,
        propKeyNamespace, declarations.props, propsAccessorsMixinName, consumablePropsName));

      typedPropsFactoryImpl =
          '  @override\n'
          '  typedPropsFactory(Map backingMap) => new $propsImplName(backingMap);\n\n';

      // ----------------------------------------------------------------------
      //   State implementation
      // ----------------------------------------------------------------------
      if (declarations.state != null) {
        final stateName = _classNameFromNode(declarations.state);
        final consumableStateName = _publicPropsOrStateClassNameFromConsumerClassName(stateName);
        final stateImplName = _propsImplClassNameFromConsumerClassName(stateName);
        final stateAccessorsMixinName = _accessorsMixinNameFromConsumerName(stateName);
        final typeParamsOnClass = declarations.state.node.typeParameters?.toSource() ?? '';
        final typeParamsOnSuper = removeBoundsFromTypeParameters(declarations.state.node.typeParameters);

        outputContentsBuffer.write(_generateAccessorsMixin(
            AccessorType.state, stateAccessorsMixinName, declarations.state,
            stateName, typeParameters: declarations.state.node.typeParameters));
        outputContentsBuffer.write(
            _generateMetaConstImpl(AccessorType.state, declarations.state));
        outputContentsBuffer.write(_generateConsumablePropsOrStateClass(AccessorType.state, declarations.state));

        outputContentsBuffer
          ..writeln('// Concrete state implementation.')
          ..writeln('//')
          ..writeln('// Implements constructor and backing map.')
          ..writeln('class $stateImplName$typeParamsOnClass extends $stateName$typeParamsOnSuper with $stateAccessorsMixinName$typeParamsOnSuper implements $consumableStateName$typeParamsOnSuper {')
          ..writeln('  $stateImplName(Map backingMap) : this._state = backingMap ?? {};')
          ..writeln()
          ..writeln('  /// The backing state map proxied by this class.')
          ..writeln('  @override')
          ..writeln('  Map get state => _state;')
          ..writeln('  final Map _state;')
          ..writeln()
          ..writeln('  /// Let [UiState] internals know that this class has been generated.')
          ..writeln('  @override')
          ..writeln('  bool get \$isClassGenerated => true;')
          ..writeln('}')
          ..writeln();

        typedStateFactoryImpl =
          '  @override\n'
          '  typedStateFactory(Map backingMap) => new $stateImplName(backingMap);\n\n';
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
                        'const [${_metaConstantName(consumablePropsName)}];')
        ..writeln('}');

      final implementsTypedPropsStateFactory = declarations.component.node.members.any((member) =>
          member is MethodDeclaration &&
          !member.isStatic &&
          (member.name.name == 'typedPropsFactory' || member.name.name == 'typedStateFactory')
      );

      if (implementsTypedPropsStateFactory) {
        // Can't be an error, because consumers may be implementing typedPropsFactory or typedStateFactory in their components.
        logger.warning(messageWithSpan(
            'Components should not add their own implementions of typedPropsFactory or typedStateFactory.',
            span: getSpan(sourceFile, declarations.component.node))
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
      final className = _classNameFromNode(abstractPropsClass);
      outputContentsBuffer.write(_generateAccessorsMixin(
          AccessorType.props, _accessorsMixinNameFromConsumerName(className), abstractPropsClass,
          className, typeParameters: abstractPropsClass.node.typeParameters));
      outputContentsBuffer.write(_generateMetaConstImpl(
          AccessorType.props, abstractPropsClass));
      outputContentsBuffer.write(_generateConsumablePropsOrStateClass(AccessorType.abstractProps, abstractPropsClass));
    });

    declarations.abstractState.forEach((abstractStateClass) {
      final className = _classNameFromNode(abstractStateClass);
      outputContentsBuffer.write(_generateAccessorsMixin(
          AccessorType.state, _accessorsMixinNameFromConsumerName(className), abstractStateClass,
          className, typeParameters: abstractStateClass.node.typeParameters));
      outputContentsBuffer.write(_generateMetaConstImpl(AccessorType.state, abstractStateClass));
      outputContentsBuffer.write(_generateConsumablePropsOrStateClass(AccessorType.abstractState, abstractStateClass));
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


  AccessorOutput _generateAccessors(
      AccessorType type,
      NodeWithMeta<ClassDeclaration, annotations.TypedMap> typedMap,
      String consumerClassName
  ) {
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
          final FieldDeclaration field = _field;

          T getConstantAnnotation<T>(AnnotatedNode member, String name, T value) {
            return member.metadata.any((annotation) => annotation.name?.name == name) ? value : null;
          }

          annotations.Accessor accessorMeta = instantiateAnnotation(field, annotations.Accessor);
          annotations.Accessor requiredProp = getConstantAnnotation(field, 'requiredProp', annotations.requiredProp);
          annotations.Accessor nullableRequiredProp = getConstantAnnotation(field, 'nullableRequiredProp', annotations.nullableRequiredProp);
          // ignore: deprecated_member_use
          annotations.Required requiredMeta = instantiateAnnotation(field, annotations.Required);


          if (accessorMeta?.doNotGenerate == true) {
            logger.fine(messageWithSpan('Skipping generation of field `$field`.',
                span: getSpan(sourceFile, field))
            );
            return;
          }

          field.fields.variables.forEach((VariableDeclaration variable) {
            if (variable.initializer != null) {
              logger.severe(messageWithSpan(
                  'Fields are stubs for generated setters/getters and should not have initializers.',
                  span: getSpan(sourceFile, variable))
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
              logger.severe(messageWithSpan(
                  '@requiredProp/@nullableProp/@Accessor cannot be used together.\n'
                  'You can use `@Accessor(required: true)` or `isNullable: true` instead of the shorthand versions.',
                  span: getSpan(sourceFile, field))
              );
            }

            constantValue += ')';

            keyConstants[keyConstantName] = keyValue;
            constants[constantName] = constantValue;

            final type = field.fields.type?.toSource();
            final typeString = type == null ? '' : '$type ';
            final metadataSrc = new StringBuffer();
            for (final annotation in field.metadata) {
              metadataSrc.writeln('  ${annotation.toSource()}');
            }

            String setterTypeString = field.covariantKeyword == null
                ? typeString
                : '${field.covariantKeyword} $typeString';

            String generatedAccessor =
                '  /// Go to [$consumerClassName.$accessorName] to see the source code for this prop\n'
                '  @override\n'
                '${metadataSrc.toString()}'
                '  ${typeString}get $accessorName => $proxiedMapName[$keyConstantName];\n'
                '  /// Go to [$consumerClassName.$accessorName] to see the source code for this prop\n'
                '  @override\n'
                '${metadataSrc.toString()}'
                '  set $accessorName(${setterTypeString}value) => $proxiedMapName[$keyConstantName] = value;\n';

            output.write(generatedAccessor);

            logger.fine(messageWithSpan('Generated accessor `$accessorName` with key $keyValue.',
                span: getSpan(sourceFile, variable)));
          });

          if (field.fields.variables.length > 1 &&
              (field.documentationComment != null || field.metadata.isNotEmpty)) {
            logger.warning(messageWithSpan(
                'Note: accessors declared as comma-separated variables will not all be generated '
                'with the original doc comments and annotations; only the first variable will.',
                span: getSpan(sourceFile, field.fields))
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
    final defaultNamespace = _publicPropsOrStateClassNameFromConsumerClassName(typedMap.node.name.name) + '.';
    // Allow the consumer to specify a custom namespace that trumps the default.
    final specifiedKeyNamespace = typedMap.meta?.keyNamespace;

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
  ///   Input: '_$_FooProps'
  ///   Output: '_$$_FooProps'
  static String _propsImplClassNameFromConsumerClassName(String className) {
    if (className == null) {
      throw new ArgumentError.notNull(className);
    }

    return className.replaceFirst(generatedPrefix, '$generatedPrefix\$');
  }

  /// Converts the consumer's written props classname to the consumable props
  /// classname by stripping [generatedPrefix] from the classname.
  ///
  /// Example:
  ///   Input: '_$FooProps'
  ///   Output: 'FooProps'
  ///   Input: '_$_FooProps'
  ///   Output: '_FooProps'
  static String _publicPropsOrStateClassNameFromConsumerClassName(String className) {
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
  ///   Input: _$_FooProps
  ///   Output: _$_FooPropsAccessorsMixin
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
  static String _metaConstantName(String consumableClassName) {
    if (consumableClassName == null) {
      throw new ArgumentError.notNull(consumableClassName);
    }

    return '${generatedPrefix}metaFor$consumableClassName';
  }

  void _generateAccessorsAndMetaConstantForMixin(AccessorType type, NodeWithMeta node) {
    var isProps = type == AccessorType.props;
    if (!hasAbstractGetter(node.node, 'Map', isProps ? 'props' : 'state')) {
      final propsOrState = isProps ? 'props': 'state';
      logger.severe(messageWithSpan(
        '${isProps
            ? 'Props'
            : 'State'} mixin classes must declare an abstract $propsOrState getter `Map get $propsOrState;` '
            'so that they can be statically analyzed properly.',
            span: getSpan(sourceFile, node.node))
      );
    }

    final consumerClassName = _classNameFromNode(node);
    final accessorsMixinName = consumerClassName.startsWith(generatedPrefix) ?
        _publicPropsOrStateClassNameFromConsumerClassName(consumerClassName) :
        '\$$consumerClassName';
    final typeParameters = (node.node as ClassDeclaration).typeParameters; // ignore: avoid_as
    outputContentsBuffer.write(_generateAccessorsMixin(
        type, accessorsMixinName, node,
        consumerClassName, isPropsOrStateMixin: true, typeParameters: typeParameters));
    outputContentsBuffer.write(_generateMetaConstImpl(type, node, accessorsMixinNameOverride: accessorsMixinName));
  }

  String _generateMetaConstImpl(AccessorType type, NodeWithMeta node, {String accessorsMixinNameOverride}) {
    final className = _classNameFromNode(node);
    final accessorsMixinName = accessorsMixinNameOverride ?? _accessorsMixinNameFromConsumerName(className);
    final isProps = type == AccessorType.props;

    final metaStructName = isProps ? 'PropsMeta' : 'StateMeta';
    final String keyListName = isProps ? staticPropKeysName : staticStateKeysName;
    final String fieldListName = isProps ? staticPropsName : staticStateName;

    final String metaInstanceName = _metaConstantName(_publicPropsOrStateClassNameFromConsumerClassName(className));

    final output = new StringBuffer();
    output.writeln('const $metaStructName $metaInstanceName = const $metaStructName(');
    output.writeln('  fields: $accessorsMixinName.$fieldListName,');
    output.writeln('  keys: $accessorsMixinName.$keyListName,');
    output.writeln(');');
    output.writeln();
    return output.toString();
  }

  String _generateAccessorsMixin(AccessorType type, String accessorsMixinName,
      NodeWithMeta node, String consumerClassName, {bool isPropsOrStateMixin: false, TypeParameterList typeParameters}) {
    final typeParamsOnClass = typeParameters?.toSource() ?? '';
    final typeParamsOnSuper = removeBoundsFromTypeParameters(typeParameters);

    final isProps = type == AccessorType.props;
    StringBuffer generatedClass = new StringBuffer();
    final implementsClause = 'implements $consumerClassName$typeParamsOnSuper';
    generatedClass.writeln(
        'abstract class $accessorsMixinName$typeParamsOnClass $implementsClause {\n' +
        '  @override' +
        '  Map get ${isProps ? 'props': 'state'};\n'
    );
    if (isPropsOrStateMixin) {
      generatedClass.writeln(_generateStaticMetaDecl(_publicPropsOrStateClassNameFromConsumerClassName(consumerClassName), type == AccessorType.props));
    }

    generatedClass.write(_generateAccessors(type, node, consumerClassName).implementations);
    generatedClass.writeln('}');
    generatedClass.writeln();
    return generatedClass.toString();
  }

  String _generateConcretePropsImpl(AccessorType type, String consumerName, String implName,
      String componentFactoryName, String propKeyNamespace, NodeWithMeta<ClassDeclaration, annotations.Props> node, String accessorsMixinName, String consumableName) {
    final typeParamsOnClass = node.node.typeParameters?.toSource() ?? '';
    final typeParamsOnSuper = removeBoundsFromTypeParameters(node.node.typeParameters);
    final classDeclaration = new StringBuffer()
      ..write('class $implName$typeParamsOnClass extends $consumerName$typeParamsOnSuper with $accessorsMixinName$typeParamsOnSuper implements $consumableName$typeParamsOnSuper {\n');
    return (new StringBuffer()
        ..writeln('// Concrete props implementation.')
        ..writeln('//')
        ..writeln('// Implements constructor and backing map, and links up to generated component factory.')
        ..write(classDeclaration)
        ..writeln('  $implName(Map backingMap) : this._props = backingMap ?? {};')
        ..writeln()
        ..writeln('  /// The backing props map proxied by this class.')
        ..writeln('  @override')
        ..writeln('  Map get props => _props;')
        ..writeln('  final Map _props;')
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
        ..writeln('}')
        ..writeln())
        .toString();
  }

  String _generateConsumablePropsOrStateClass(AccessorType type, NodeWithMeta node) {
    if (!(node is PropsOrStateNode)) {
      return '';
    }

    if ((node as PropsOrStateNode).hasCompanionClass) {// ignore: avoid_as
      return '';
    }

    final className = _classNameFromNode(node);
    final typeParameters = (node.node as ClassDeclaration).typeParameters;
    final typeParamsOnClass = typeParameters?.toSource() ?? '';
    final typeParamsOnSuper = removeBoundsFromTypeParameters(typeParameters);
    final consumableClassName = _publicPropsOrStateClassNameFromConsumerClassName(className);

    final classKeywords = '${type == AccessorType.abstractProps || type == AccessorType.abstractState ? 'abstract ' : ''}class';
    final isProps = type == AccessorType.props || type == AccessorType.abstractProps;
    return (StringBuffer()
      ..writeln('$classKeywords $consumableClassName$typeParamsOnClass extends $className$typeParamsOnSuper with ${className}AccessorsMixin$typeParamsOnSuper {')
      ..writeln(_generateStaticMetaDecl(consumableClassName, isProps))
      ..writeln('}'))
        .toString();
  }

  String _generateStaticMetaDecl(String consumableClassName, bool isProps) {
    return '  static const ${isProps ? 'Props' : 'State'}Meta meta = ${_metaConstantName(consumableClassName)};';
  }
}

enum AccessorType {props, state, abstractProps, abstractState}

class AccessorOutput {
  final String implementations;

  AccessorOutput(this.implementations);
}
