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
import 'package:barback/barback.dart';
import 'package:over_react/src/component_declaration/annotations.dart' as annotations;
import 'package:over_react/src/transformer/declaration_parsing.dart';
import 'package:over_react/src/transformer/util.dart';
import 'package:source_span/source_span.dart';
import 'package:transformer_utils/src/text_util.dart' show stringLiteral;
import 'package:transformer_utils/src/transformed_source_file.dart' show getSpan;
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
  ImplGenerator(this.logger, this.transformedFile);

  static const String generatedPrefix = r'_$';
  static const String privatePrefix = r'_';
  static const String publicGeneratedPrefix = r'$';

  final TransformLogger logger;
  final TransformedSourceFile transformedFile;
  bool shouldFixDdcAbstractAccessors = false;

  SourceFile get sourceFile => transformedFile.sourceFile;

  static String getComponentFactoryName(String componentClassName) {
    if (componentClassName == null) {
      throw new ArgumentError.notNull(componentClassName);
    }

    return '$publicGeneratedPrefix${componentClassName}Factory';
  }

  void generate(ParsedDeclarations declarations) {
    StringBuffer implementations = new StringBuffer();

    if (declarations.declaresComponent) {
      final String factoryName = declarations.factory.node.variables.variables.first.name.toString();

      final String propsName = (declarations.props.companionNode ?? declarations.props.node).name.toString();
      final String propsImplName = '$generatedPrefix${propsName}Impl';

      final String componentClassName = declarations.component.node.name.toString();
      final String componentClassImplMixinName = '$generatedPrefix${componentClassName}ImplMixin';

      final String componentFactoryName = getComponentFactoryName(componentClassName);

      String typedPropsFactoryImpl = '';
      String typedStateFactoryImpl = '';

      // Work around https://github.com/dart-lang/sdk/issues/16030 by making
      // the original props class abstract and redeclaring `call` in the impl class.
      //
      // We can safely make this abstract, since we already have a runtime warning when it's
      // instantiated.
      if (!declarations.props.node.isAbstract) {
        transformedFile.insert(
            sourceFile.location(declarations.props.node.classKeyword.offset),
            'abstract '
        );
      }
      if (declarations.props.companionNode != null && !declarations.props.companionNode.isAbstract) {
        transformedFile.insert(
            sourceFile.location(declarations.props.companionNode.classKeyword.offset),
            'abstract '
        );
      }

      // ----------------------------------------------------------------------
      //   Factory implementation
      // ----------------------------------------------------------------------

      transformedFile.replace(
          sourceFile.span(
              declarations.factory.node.variables.variables.first.name.end,
              declarations.factory.node.semicolon.offset
          ),
          ' = ([Map backingProps]) => new $propsImplName(backingProps)'
      );

      String parentTypeParam = 'null';
      String parentTypeParamComment = '';

      Identifier parentType = declarations.component.subtypeOfValue;
      if (parentType != null) {
        parentTypeParamComment = ' /* from `subtypeOf: ${getSpan(sourceFile, parentType).text}` */';

        if (parentType is PrefixedIdentifier) {
          var prefix = parentType.prefix.name;
          var parentClassName = parentType.identifier.name;

          parentTypeParam = prefix + '.' + getComponentFactoryName(parentClassName);
        } else {
          var parentClassName = parentType.name;

          parentTypeParam = getComponentFactoryName(parentClassName);
        }
      }

      if (parentTypeParam == componentFactoryName) {
        /// It doesn't make sense to have a component subtype itself, and also an error occurs
        /// if a component's factory variable tries to reference itself during its initialization.
        /// Therefore, this is not allowed.
        logger.error('A component cannot be a subtype of itself.',
            span: getSpan(sourceFile, declarations.component.metaNode)
        );
      }

      implementations
        ..writeln('// React component factory implementation.')
        ..writeln('//')
        ..writeln('// Registers component implementation and links type meta to builder factory.')
        // TODO: verify that the component class has a default constructor?
        ..writeln('final $componentFactoryName = registerComponent(() => new $componentClassName(),')
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
      removeWithClauseFromCompanion(declarations.props.companionNode, sourceFile, transformedFile);

      final accessorOutput = generateAccessors(AccessorType.props, declarations.props);
      implementations.writeln(accessorOutput.implementations);

      final String propKeyNamespace = getAccessorKeyNamespace(declarations.props);

      implementations
        ..writeln('// Concrete props implementation.')
        ..writeln('//')
        ..writeln('// Implements constructor and backing map, and links up to generated component factory.')
        ..writeln('class $propsImplName extends $propsName {')
        ..writeln('  /// The backing props map proxied by this class.')
        ..writeln('  @override')
        ..writeln('  final Map props;')
        ..writeln()
        // Wrap Map literal in parens to work around https://github.com/dart-lang/sdk/issues/24410
        ..writeln('  $propsImplName(Map backingMap) : this.props = backingMap ?? ({});')
        ..writeln()
        ..writeln('  /// Let [UiProps] internals know that this class has been generated.')
        ..writeln('  @override')
        ..writeln('  bool get \$isClassGenerated => true;')
        ..writeln()
        ..writeln('  /// The [ReactComponentFactory] associated with the component built by this class.')
        ..writeln('  @override')
        ..writeln('  Function get componentFactory => $componentFactoryName;')
        ..writeln()
        ..writeln('  /// The default namespace for the prop getters/setters generated for this class.')
        ..writeln('  @override')
        ..writeln('  String get propKeyNamespace => ${stringLiteral(propKeyNamespace)};')
        ..writeln('}')
        ..writeln();

      typedPropsFactoryImpl =
          '@override '
          // Don't type this so that it doesn't interfere with classes with generic parameter props type:
          //    class FooComponent<T extends FooProps> extends UiComponent<T> {...}
          // TODO use long-term solution of component impl class instantiated via factory constructor
          'typedPropsFactory(Map backingMap) => new $propsImplName(backingMap) as dynamic;';

      // ----------------------------------------------------------------------
      //   State implementation
      // ----------------------------------------------------------------------
      if (declarations.state != null) {
        final String stateName = (declarations.state.companionNode ?? declarations.state.node).name.toString();
        final String stateImplName = '$generatedPrefix${stateName}Impl';

        removeWithClauseFromCompanion(declarations.state.companionNode, sourceFile, transformedFile);

        final accessorOutput = generateAccessors(AccessorType.state, declarations.state);
        implementations.writeln(accessorOutput.implementations);

        implementations
          ..writeln('// Concrete state implementation.')
          ..writeln('//')
          ..writeln('// Implements constructor and backing map.')
          ..writeln('class $stateImplName extends $stateName {')
          ..writeln('  /// The backing state map proxied by this class.')
          ..writeln('  @override')
          ..writeln('  final Map state;')
          ..writeln()
          // Wrap Map literal in parens to work around https://github.com/dart-lang/sdk/issues/24410
          ..writeln('  $stateImplName(Map backingMap) : this.state = backingMap ?? ({});')
          ..writeln()
          ..writeln('  /// Let [UiState] internals know that this class has been generated.')
          ..writeln('  @override')
          ..writeln('  bool get \$isClassGenerated => true;')
          ..writeln('}')
          ..writeln();

        typedStateFactoryImpl =
          '@override '
          // Don't type this so that it doesn't interfere with classes with generic parameter state type:
          //    class FooComponent<T extends FooProps, T extends FooState> extends UiStatefulComponent<T> {...}
          // TODO use long-term solution of component impl class instantiated via factory constructor
          'typedStateFactory(Map backingMap) => new $stateImplName(backingMap) as dynamic;';
      }

      // ----------------------------------------------------------------------
      //   Component implementation
      // ----------------------------------------------------------------------
      implementations
        ..writeln('// Concrete component implementation mixin.')
        ..writeln('//')
        ..writeln('// Implements typed props/state factories, defaults `consumedPropKeys` to the keys')
        ..writeln('// generated for the associated props class.')
        ..writeln('class $componentClassImplMixinName {')
        ..writeln('  /// Let [UiComponent] internals know that this class has been generated.')
        ..writeln('  @override')
        ..writeln('  bool get \$isClassGenerated => true;')
        ..writeln()
        ..writeln('  /// The default consumed props, taken from $propsName.')
        ..writeln('  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.')
        ..writeln('  @override')
        ..writeln('  final List<ConsumedProps> \$defaultConsumedProps = '
                        'const [$propsName.$staticConsumedPropsName];')
        ..writeln('}');

      if (declarations.component.node.withClause != null) {
        transformedFile.insert(
            sourceFile.location(declarations.component.node.withClause.mixinTypes.last.end),
            ', $componentClassImplMixinName'
        );
      } else if (declarations.component.node.extendsClause != null) {
        transformedFile.insert(
            sourceFile.location(declarations.component.node.extendsClause.end),
            ' with $componentClassImplMixinName'
        );
      } else {
        transformedFile.insert(
            sourceFile.location(declarations.component.node.name.end),
            ' extends Object with $componentClassImplMixinName'
        );
      }

      var implementsTypedPropsStateFactory = declarations.component.node.members.any((member) =>
          member is MethodDeclaration &&
          !member.isStatic &&
          (member.name.name == 'typedPropsFactory' || member.name.name == 'typedStateFactory')
      );

      if (implementsTypedPropsStateFactory) {
        // Can't be an error, because consumers may be implementing typedPropsFactory or typedStateFactory in their components.
        logger.warning(
            'Components should not add their own implementions of typedPropsFactory or typedStateFactory.',
            span: getSpan(sourceFile, declarations.component.node)
        );
      } else {
        // For some reason, strong mode is okay with these declarations being in the component,
        // but not in the mixin.
        // TODO use long-term solution of component impl class instantiated via factory constructor
        transformedFile.insert(
            sourceFile.location(declarations.component.node.leftBracket.end),
            '   /* GENERATED IMPLEMENTATIONS */ $typedPropsFactoryImpl $typedStateFactoryImpl'
        );
      }
    }


    // ----------------------------------------------------------------------
    //   Props/State Mixins implementations
    // ----------------------------------------------------------------------
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

    declarations.propsMixins.forEach((propMixin) {
      if (!hasAbstractGetter(propMixin.node, 'Map', 'props')) {
        logger.error(
            'Props mixin classes must declare an abstract props getter `Map get props;` '
            'so that they can be statically analyzed properly.',
            span: getSpan(sourceFile, propMixin.node)
        );
      }

      final accessorOutput = generateAccessors(AccessorType.props, propMixin);
      implementations.writeln(accessorOutput.implementations);
      
      /// Generates an empty $ prefixed mixin class for each prop mixin.
      ///
      /// This is because with the builder compatible boilerplate, Props
      /// and State mixin classes are renamed to include a $ prefix with the assumption that
      /// the actual class with concrete accessor implementations will be generated.
      transformedFile.insert(sourceFile.location(propMixin.node.end), ' abstract class \$${propMixin.node.name.name}${propMixin.node.typeParameters ?? ''} {}');
    });

    declarations.stateMixins.forEach((stateMixin) {
      if (!hasAbstractGetter(stateMixin.node, 'Map', 'state')) {
        logger.error(
            'State mixin classes must declare an abstract state getter `Map get state;` '
            'so that they can be statically analyzed properly.',
            span: getSpan(sourceFile, stateMixin.node)
        );
      }

      final accessorOutput = generateAccessors(AccessorType.state, stateMixin);
      implementations.writeln(accessorOutput.implementations);

      /// Generates an empty $ prefixed mixin class for each state mixin.
      ///
      /// This is because with the builder compatible boilerplate, Props
      /// and State mixin classes are renamed to include a $ prefix with the assumption that
      /// the actual class with concrete accessor implementations will be generated.
      transformedFile.insert(sourceFile.location(stateMixin.node.end), 'abstract class \$${stateMixin.node.name.name}${stateMixin.node.typeParameters ?? ''} {}');
    });

    // ----------------------------------------------------------------------
    //   Abstract Props/State implementations
    // ----------------------------------------------------------------------
    declarations.abstractProps.forEach((abstractPropsClass) {
      removeWithClauseFromCompanion(abstractPropsClass.companionNode, sourceFile, transformedFile);

      final accessorOutput = generateAccessors(AccessorType.props, abstractPropsClass);
      implementations.writeln(accessorOutput.implementations);
    });

    declarations.abstractState.forEach((abstractStateClass) {
      removeWithClauseFromCompanion(abstractStateClass.companionNode, sourceFile, transformedFile);

      final accessorOutput = generateAccessors(AccessorType.state, abstractStateClass);
      implementations.writeln(accessorOutput.implementations);
    });

    if (implementations.isNotEmpty) {
      transformedFile.insert(sourceFile.location(sourceFile.length),
          '\n\n' +
          commentBanner('GENERATED IMPLEMENTATIONS', bottomBorder: false) +
          implementations.toString() +
          commentBanner('END GENERATED IMPLEMENTATIONS', topBorder: false)
      );
    }
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

  static ClassDeclaration getCompanionNodeOrNull(NodeWithMeta<ClassDeclaration, annotations.TypedMap> typedMap) {
    if (typedMap is! NodeWithMetaAndCompanion) {
      return null;
    }
    final NodeWithMetaAndCompanion<ClassDeclaration, annotations.TypedMap> typedMapWithCompanion = typedMap;
    return typedMapWithCompanion.companionNode;
  }

  static String getAccessorKeyNamespace(NodeWithMeta<ClassDeclaration, annotations.TypedMap> typedMap) {
    // Default to the name of the class followed by a period.
    var defaultNamespace = typedMap.node.name.name + '.';
    final companionNode = getCompanionNodeOrNull(typedMap);
    if (companionNode != null) {
      defaultNamespace = companionNode.name.name + '.';
    }
    // Allow the consumer to specify a custom namespace that trumps the default.
    var specifiedKeyNamespace = typedMap.meta?.keyNamespace;

    return specifiedKeyNamespace ?? defaultNamespace;
  }

  AccessorOutput generateAccessors(
      AccessorType type,
      NodeWithMeta<ClassDeclaration, annotations.TypedMap> typedMap
  ) {
    if (shouldFixDdcAbstractAccessors) {
      fixDdcAbstractAccessors(type, typedMap);
    }

    String keyNamespace = getAccessorKeyNamespace(typedMap);

    final bool isProps = type == AccessorType.props;

    final String proxiedMapName = isProps ? proxiedPropsMapName : proxiedStateMapName;
    final String keyListName = isProps ? staticPropKeysName : staticStateKeysName;
    final String constantListName = isProps ? staticPropsName : staticStateName;
    final String constConstructorName = isProps ? 'PropDescriptor' : 'StateDescriptor';

    Map keyConstants = {};
    Map constants = {};

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
                span: getSpan(sourceFile, field)
            );

            return;
          }

          // Remove everything in the field except the comments/meta and the variable names, preserving newlines.
          // TODO add support for preserving comment nodes between variable declarations.

          // Remove content between end of comment/meta and first variable name
          transformedFile.remove(
              sourceFile.span(field.firstTokenAfterCommentAndMetadata.offset, field.fields.variables.first.beginToken.offset),
              preserveNewlines: true
          );
          // Remove content between variable names (including commas).
          var prevVariable = field.fields.variables.first;
          field.fields.variables.skip(1).forEach((variable) {
            transformedFile.remove(
                sourceFile.span(prevVariable.name.end, variable.name.offset),
                preserveNewlines: true
            );
            prevVariable = variable;
          });
          // Remove content between last variable name and the end of the field (including the semicolon).
          transformedFile.remove(
              sourceFile.span(field.fields.variables.last.end, field.end),
              preserveNewlines: true
          );

          field.fields.variables.forEach((VariableDeclaration variable) {
            if (variable.initializer != null) {
              logger.error(
                  'Fields are stubs for generated setters/getters and should not have initializers.',
                  span: getSpan(sourceFile, variable)
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
              logger.error(
                  '@requiredProp/@nullableProp/@Accessor cannot be used together.\n'
                  'You can use `@Accessor(required: true)` or `isNullable: true` instead of the shorthand versions.',
                  span: getSpan(sourceFile, field)
              );
            }

            constantValue += ')';

            keyConstants[keyConstantName] = keyValue;
            constants[constantName] = constantValue;

            TypeName type = field.fields.type;
            String typeString = type == null ? '' : '$type ';
            String setterTypeString = field.covariantKeyword == null
                ? typeString
                : '${field.covariantKeyword} $typeString';

            String generatedAccessor =
                '${typeString}get $accessorName => $proxiedMapName[$keyConstantName];  '
                'set $accessorName(${setterTypeString}value) => $proxiedMapName[$keyConstantName] = value;';

            transformedFile.replace(
                sourceFile.span(variable.firstTokenAfterCommentAndMetadata.offset, variable.name.end),
                generatedAccessor
            );

            logger.fine('Generated accessor `$accessorName` with key $keyValue.',
                span: getSpan(sourceFile, variable)
            );
          });

          if (field.fields.variables.length > 1 &&
              (field.documentationComment != null || field.metadata.isNotEmpty)) {
            logger.warning(
                'Note: accessors declared as comma-separated variables will not all be generated '
                'with the original doc comments and annotations; only the first variable will.',
                span: getSpan(sourceFile, field.fields)
            );
          }
        });

    var staticConstNamespace = typedMap.node.name.name;
    var keyConstantsImpl;
    var keyConstantsCompanionImpl;
    var constantsImpl;
    var constantsCompanionImpl;

    if (keyConstants.keys.isEmpty) {
      keyConstantsImpl = '';
      keyConstantsCompanionImpl = '';
    } else {
      keyConstantsImpl =
          'static const String ' +
          keyConstants.keys.map((keyName) => '$keyName = ${keyConstants[keyName]}').join(', ') +
          '; ';
      keyConstantsCompanionImpl =
          'static const String ' +
          keyConstants.keys.map((keyName) => '$keyName = $staticConstNamespace.$keyName').join(', ') +
          '; ';
    }

    if (constants.keys.isEmpty) {
      constantsImpl = '';
      constantsCompanionImpl = '';
    } else {
      constantsImpl =
          'static const $constConstructorName ' +
          constants.keys.map((constantName) => '$constantName = ${constants[constantName]}').join(', ') +
          '; ';
      constantsCompanionImpl =
          'static const $constConstructorName ' +
          constants.keys.map((constantName) => '$constantName = $staticConstNamespace.$constantName').join(', ') +
          '; ';
    }

    final keyListImpl =
        'static const List<String> $keyListName = const [' +
        keyConstants.keys.join(', ') +
        ']; ';
    final keyListCompanionImpl =
        'static const List<String> $keyListName = $staticConstNamespace.$keyListName; ';

    final listImpl =
        'static const List<$constConstructorName> $constantListName = const [' +
        constants.keys.join(', ') +
        ']; ';
    final listCompanionImpl =
        'static const List<$constConstructorName> $constantListName = $staticConstNamespace.$constantListName; ';

    var consumedImpl = '';
    var consumedCompanionImpl = '';

    if (isProps) {
      consumedImpl = 'static const ConsumedProps $staticConsumedPropsName = const ConsumedProps($constantListName, $keyListName); ';
      consumedCompanionImpl = 'static const ConsumedProps $staticConsumedPropsName = $staticConstNamespace.$staticConsumedPropsName; ';
    }

    final staticVariablesImpl = '    /* GENERATED CONSTANTS */ $consumedImpl$constantsImpl$listImpl$keyConstantsImpl$keyListImpl';
    final staticGettersCompanionImpl = '    /* GENERATED CONSTANTS */ $consumedCompanionImpl$constantsCompanionImpl$listCompanionImpl$keyConstantsCompanionImpl$keyListCompanionImpl';

    transformedFile.insert(
        sourceFile.location(typedMap.node.leftBracket.end),
        staticVariablesImpl
    );

    final companionNode = getCompanionNodeOrNull(typedMap);
    if (companionNode != null) {
      transformedFile.insert(
          sourceFile.location(companionNode.leftBracket.end),
          staticGettersCompanionImpl
      );
    }

    final classDeclaration = (companionNode ?? typedMap.node);
    final metaField = getMetaField(classDeclaration);
    final output = new StringBuffer();
    // if metaField is null, we are on Dart 1 code which has not transitioned
    // to the transitional Dart 2 compatible boilerplate, and thus the $metaFor
    // constant is not needed
    if (metaField != null) {
      final name = classDeclaration.name.name;
      final metaClassName = '$generatedPrefix${name}Meta';
      final metaInstanceName = metaField.fields.variables.single.initializer.toSource();
      final metaStructName = type == AccessorType.props
          ? 'PropsMeta'
          : 'StateMeta';
      output.writeln('/// A class that allows us to reuse generated code from the accessors class.');
      output.writeln('/// This is only used by other generated code, and can be simplified if needed.');
      output.writeln('class $metaClassName {');
      output.writeln(staticVariablesImpl);
      output.writeln('}');
      output.writeln('const $metaStructName $metaInstanceName = const $metaStructName(');
      output.writeln('  fields: $metaClassName.$constantListName,');
      output.writeln('  keys: $metaClassName.$keyListName,');
      output.writeln(');');
    }
    return new AccessorOutput(output.toString());
  }

  /// Apply a workaround for an issue where, in the DDC, abstract getter or setter overrides declared in a class clobber
  /// the inherited concrete implementations. <https://github.com/dart-lang/sdk/issues/29914>
  ///
  /// Fixes the issue by generating corresponding abstract getters/setters to complete the pair
  /// for accessors with the `@override` annotation.
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

        transformedFile.insert(sourceFile.location(accessor.end),
            // use `covariant` here to be extra safe in this typing
            '${generatedComment}set $name(covariant ${typeString}value);');
      } else {
        var parameter = accessor.parameters.parameters.single;
        var type = parameter is SimpleFormalParameter
            ? parameter.type?.toSource()
            // This `null` case is mainly for [FunctionTypedFormalParameter].
            : null;
        var typeString = type == null ? '' : '$type ';

        transformedFile.insert(sourceFile.location(accessor.end),
            '$generatedComment${typeString}get $name;');
      }
    }
  }
}

enum AccessorType {props, state}

class AccessorOutput {
  final String implementations;
   AccessorOutput(this.implementations);
}

/// Check if the passed in class declaration is null, if not, remove its with clause.
///
/// The public Props|State|AbstractProps|AbstractState class signatures includes a with
/// <Class>AccessorsMixin clause for dart 2 builder compatibility. But in Dart 1,
/// the transformer is able to generate the concrete accessors inline without a separate
/// mixin. For this reason, the transformer removes the with clause from the public class
/// signatures.
///
/// Builder-compatible dual class props setup example:
///
///     class FooProps extends _$FooProps with _$FooPropsAccessorsMixin {
///       // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
///       static const PropsMeta meta = $metaForFooProps;
///     }
///
///     @Props()
///     class _$FooProps extends UiProps {}
///
/// The builder is responsible for generating the _$FooPropsAccessorsMixin found in FooProps
/// with clause, but since the transformer can inline concrete accessors _$FooPropsAccessorsMixin
/// is not required and needs to be removed.
void removeWithClauseFromCompanion(ClassDeclaration declaration, SourceFile sourceFile, TransformedSourceFile transformedFile) {
  if (declaration == null) return;
  transformedFile.remove(getSpan(sourceFile, declaration.withClause));
}
