library over_react.transformer.impl_generation;

import 'package:analyzer/analyzer.dart';
import 'package:barback/barback.dart';
import 'package:over_react/src/component_declaration/annotations.dart' as annotations;
import 'package:over_react/src/transformer/declaration_parsing.dart';
import 'package:over_react/src/transformer/text_util.dart';
import 'package:source_span/source_span.dart';
import 'package:transformer_utils/src/text_util.dart' show stringLiteral;
import 'package:transformer_utils/src/transformed_source_file.dart' show getSpan;
import 'package:transformer_utils/transformer_utils.dart';

/// A utility class that modifies a [TransformedSourceFile] by generating implementations for a set of [ParsedDeclarations].
///
/// Generates implementations for:
///
/// * A component commprised of a `@Factory()`, `@Component()`, `@Props()`, and optionally a `@State()`
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
  static const String publicGeneratedPrefix = r'$';

  final TransformLogger logger;
  final TransformedSourceFile transformedFile;

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

      final String propsName = declarations.props.node.name.toString();
      final String propsImplName = '$generatedPrefix${propsName}Impl';

      final String componentClassName = declarations.component.node.name.toString();
      final String componentClassImplMixinName = '$generatedPrefix${componentClassName}ImplMixin';

      final String componentFactoryName = getComponentFactoryName(componentClassName);

      String typedPropsFactoryImpl = '';
      String typedStateFactoryImpl = '';


      // ----------------------------------------------------------------------
      //   Factory implementation
      // ----------------------------------------------------------------------

      if (declarations.factory.node.variables.variables.length != 1) {
        logger.error('Factory declarations must a single variable.',
            span: getSpan(sourceFile, declarations.factory.node.variables));
      }

      declarations.factory.node.variables.variables.forEach((variable) {
        if (variable.initializer != null) {
          logger.error(
              'Factory variables are stubs for the generated factories, and should not have initializers.',
              span: getSpan(sourceFile, variable.initializer)
          );
        }
      });

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
      generateAccessors(AccessorType.props, declarations.props);

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
          '  @override\n'
          '  $propsName typedPropsFactory(Map backingMap) => new $propsImplName(backingMap);';

      // ----------------------------------------------------------------------
      //   State implementation
      // ----------------------------------------------------------------------
      if (declarations.state != null) {
        final String stateName = declarations.state.node.name.toString();
        final String stateImplName = '$generatedPrefix${stateName}Impl';

        generateAccessors(AccessorType.state, declarations.state);

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
          '  @override\n'
          '  $stateName typedStateFactory(Map backingMap) => new $stateImplName(backingMap);';
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
        ..writeln(typedPropsFactoryImpl)
        ..writeln(typedStateFactoryImpl)
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
    }

    if (implementations.isNotEmpty) {
      transformedFile.insert(sourceFile.location(sourceFile.length),
          '\n\n' +
          commentBanner('GENERATED IMPLEMENTATIONS', bottomBorder: false) +
          implementations.toString() +
          commentBanner('END GENERATED IMPLEMENTATIONS', topBorder: false)
      );
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
            member.returnType?.name?.name == type
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

      generateAccessors(AccessorType.props, propMixin);
    });

    declarations.stateMixins.forEach((stateMixin) {
      if (!hasAbstractGetter(stateMixin.node, 'Map', 'state')) {
        logger.error(
            'State mixin classes must declare an abstract state getter `Map get state;` '
            'so that they can be statically analyzed properly.',
            span: getSpan(sourceFile, stateMixin.node)
        );
      }

      generateAccessors(AccessorType.state, stateMixin);
    });

    // ----------------------------------------------------------------------
    //   Abstract Props/State implementations
    // ----------------------------------------------------------------------
    declarations.abstractProps.forEach((abstractPropsClass) {
      generateAccessors(AccessorType.props, abstractPropsClass);
    });

    declarations.abstractState.forEach((abstractStateClass) {
      generateAccessors(AccessorType.state, abstractStateClass);
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

  static String getAccessorKeyNamespace(NodeWithMeta<ClassDeclaration, annotations.TypedMap> typedMap) {
    // Default to the name of the class followed by a period.
    var defaultNamespace = typedMap.node.name.name + '.';
    // Allow the consumer to specify a custom namespace that trumps the default.
    var specifiedKeyNamespace = typedMap.meta?.keyNamespace;

    return specifiedKeyNamespace ?? defaultNamespace;
  }

  void generateAccessors(
      AccessorType type,
      NodeWithMeta<ClassDeclaration, annotations.TypedMap> typedMap
  ) {
    String keyNamespace = getAccessorKeyNamespace(typedMap);

    final bool isProps = type == AccessorType.props;

    final String proxiedMapName = isProps ? proxiedPropsMapName : proxiedStateMapName;
    final String keyListName = isProps ? staticPropKeysName : staticStateKeysName;
    final String constantListName = isProps ? staticPropsName : staticStateName;
    final String constConstructorName = isProps ? 'PropDescriptor' : 'StateDescriptor';

    Map keyConstants = {};
    Map constants = {};

    typedMap.node.members
        .where((member) => member is FieldDeclaration)
        .where((FieldDeclaration member) => !member.isStatic)
        .forEach((FieldDeclaration field) {
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

            annotations.Accessor accessorMeta = instantiateAnnotation(field, annotations.Accessor);
            annotations.Required requiredMeta = instantiateAnnotation(field, annotations.Required);

            bool isRequired = requiredMeta != null;
            bool isNullable = isRequired && requiredMeta.isNullable;
            bool hasErrorMessage = isRequired && requiredMeta.message != null && requiredMeta.message.isNotEmpty;

            String individualKeyNamespace = accessorMeta?.keyNamespace ?? keyNamespace;
            String individualKey = accessorMeta?.key ?? accessorName;

            String keyConstantName = '${generatedPrefix}key__$accessorName';
            String keyValue = stringLiteral(individualKeyNamespace + individualKey);

            String constantName = '${generatedPrefix}prop__$accessorName';
            String constantValue = 'const $constConstructorName($keyConstantName';

            if (isRequired) {
              constantValue += ', isRequired: true';

              if (isNullable) constantValue += ', isNullable: true';
              if (hasErrorMessage) constantValue += ', errorMessage: ${stringLiteral(requiredMeta.message)}';
            }

            constantValue += ')';

            keyConstants[keyConstantName] = keyValue;
            constants[constantName] = constantValue;

            TypeName type = field.fields.type;
            String typeString = type == null ? '' : '$type ';

            String generatedAccessor =
                '${typeString}get $accessorName => $proxiedMapName[$keyConstantName];  '
                'set $accessorName(${typeString}value) => $proxiedMapName[$keyConstantName] = value;';

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

    var keyConstantsImpl;
    var constantsImpl;

    if (keyConstants.keys.isEmpty) {
      keyConstantsImpl = '';
    } else {
      keyConstantsImpl =
          'static const String ' +
          keyConstants.keys.map((keyName) => '$keyName = ${keyConstants[keyName]}').join(', ') +
          '; ';
    }

    if (constants.keys.isEmpty) {
      constantsImpl = '';
    } else {
      constantsImpl =
          'static const $constConstructorName ' +
          constants.keys.map((constantName) => '$constantName = ${constants[constantName]}').join(', ') +
          '; ';
    }

    String keyListImpl =
        'static const List<String> $keyListName = const [' +
        keyConstants.keys.join(', ') +
        ']; ';

    String listImpl =
        'static const List<$constConstructorName> $constantListName = const [' +
        constants.keys.join(', ') +
        ']; ';

    String consumedImpl = '';

    if (isProps) {
      consumedImpl = 'static const ConsumedProps $staticConsumedPropsName = const ConsumedProps($constantListName, $keyListName); ';
    }

    String staticVariablesImpl = '    /* GENERATED CONSTANTS */ $consumedImpl$constantsImpl$listImpl$keyConstantsImpl$keyListImpl';

    transformedFile.insert(
        sourceFile.location(typedMap.node.leftBracket.end),
        staticVariablesImpl
    );
  }
}

enum AccessorType {props, state}
