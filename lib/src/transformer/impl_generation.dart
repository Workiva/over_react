library web_skin_dart.transformer.impl_generation;

import 'package:analyzer/analyzer.dart';
import 'package:barback/barback.dart';
import 'package:source_span/source_span.dart';
import 'package:web_skin_dart/src/transformer/analyzer_helpers.dart';
import 'package:web_skin_dart/src/transformer/declaration_parsing.dart' show ComponentDeclarations;
import 'package:web_skin_dart/src/transformer/source_file_helpers.dart';
import 'package:web_skin_dart/src/transformer/text_util.dart';
import 'package:web_skin_dart/src/ui_core/component_declaration/annotations.dart' as annotations;

class ImplGenerator {
  static const String generatedPrefix = r'_$';
  static const String publicGeneratedPrefix = r'$';

  final TransformLogger logger;
  final TransformedSourceFile transformedFile;

  SourceFile get sourceFile => transformedFile.sourceFile;

  ImplGenerator(TransformLogger this.logger, TransformedSourceFile this.transformedFile);

  void generateComponent(ComponentDeclarations declarations) {
    StringBuffer implementations = new StringBuffer();

    if (declarations.declaresComponent) {
      final String factoryName = declarations.factory.node.variables.variables.first.name.toString();

      final String propsName = declarations.props.node.name.toString();
      final String propsImplName = '$generatedPrefix${propsName}Impl';

      final String componentClassName = declarations.component.node.name.toString();
      final String componentClassImplName = '$generatedPrefix${componentClassName}Impl';

      final String componentName = componentClassName;

      final String componentFactoryName = '$generatedPrefix${componentName}Factory';

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

      implementations
        ..writeln('// React component factory implementation')
        ..writeln('//')
        ..writeln('// registers component impl and links type meta to builder factory')
        ..writeln('final $componentFactoryName = registerComponent(() => new $componentClassImplName(),')
        ..writeln('    builderFactory: $factoryName,')
        ..writeln('    componentClass: $componentClassName,')
        ..writeln('    isWrapper: ${declarations.component.meta.isWrapper},')
        ..writeln('    displayName: ${stringLiteral(factoryName)}')
        ..writeln(');')
        ..writeln();

      // ----------------------------------------------------------------------
      //   Props implementation
      // ----------------------------------------------------------------------
      generateAccessors(AccessorType.props, declarations.props);

      final String propKeyNamespace = getAccessorKeyNamespace(declarations.props);

      implementations
        ..writeln('// Props implementation')
        ..writeln('//')
        ..writeln('// implements constructor and backing map, and links up to generated component factory')
        ..writeln('class $propsImplName extends $propsName {')
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
        ..writeln('  @override')
        ..writeln('  Function get componentFactory => $componentFactoryName;')
        ..writeln()
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
          ..writeln('// State implementation')
          ..writeln('//')
          ..writeln('// implements constructor and backing map')
          ..writeln('class $stateImplName extends $stateName {')
          ..writeln('  @override')
          ..writeln('  final Map state;')
          ..writeln()
          // Wrap Map literal in parens to work around https://github.com/dart-lang/sdk/issues/24410
          ..writeln('  $stateImplName(Map backingMap) : this.state = backingMap ?? ({});')
          ..writeln()
          ..writeln('  /// Let [UiComponent] internals know that this class has been generated.')
          ..writeln('  @override')
          ..writeln('  bool get \$isClassGenerated => true;')
          ..writeln('}')
          ..writeln();

        typedStateFactoryImpl =
          '  @override\n'
          '  $stateName typedStateFactory(Map backingMap) => new $stateImplName(backingMap);';
      }

      final String propsAnnotation = '`@${ComponentDeclarations.key_props}`';

      // ----------------------------------------------------------------------
      //   Component implementation
      // ----------------------------------------------------------------------
      implementations
        ..writeln('// Component implementation')
        ..writeln('//')
        ..writeln('// implements typed props and typed state factories')
        ..writeln('class $componentClassImplName extends $componentClassName {')
        ..writeln('  /// Let [UiComponent] internals know that this class has been generated.')
        ..writeln('  @override')
        ..writeln('  bool get \$isClassGenerated => true;')
        ..writeln()
        ..writeln('  /// The default consumed prop keys, taken from $propsAnnotation.')
        ..writeln('  static const List<List<String>> _\$defaultConsumedPropKeys = '
                        'const [$propsName.$staticPropKeysName];')
        ..writeln()
        ..writeln('  @override')
        ..writeln('  /// For convenience, default to the props generated in this component\'s $propsAnnotation')
        ..writeln('  /// if none are explicitly declared.')
        ..writeln('  Iterable<Iterable<String>> get consumedPropKeys => '
                        'super.consumedPropKeys ?? _\$defaultConsumedPropKeys;')
        ..writeln()
        ..writeln(typedPropsFactoryImpl)
        ..writeln(typedStateFactoryImpl)
        ..writeln('}');
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

    final String proxiedMapName = type == AccessorType.props ? proxiedPropsMapName : proxiedStateMapName;
    final String keyListName = type == AccessorType.props ? staticPropKeysName : staticStateKeysName;

    Map keyConstants = {};

    typedMap.node.members
        .where((member) => member is FieldDeclaration)
        .where((FieldDeclaration member) => !member.isStatic)
        .forEach((FieldDeclaration field) {
          // Remove everything in the field except the comments/meta and the variable names, preserving newlines.
          // TODO add support for preserving comments.

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

            String individualKeyNamespace = accessorMeta?.keyNamespace ?? keyNamespace;
            String individualKey = accessorMeta?.key ?? accessorName;

            String keyConstantName = '${generatedPrefix}key__$accessorName';
            String keyValue = stringLiteral(individualKeyNamespace + individualKey);

            keyConstants[keyConstantName] = keyValue;

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

    if (keyConstants.keys.isEmpty) {
      keyConstantsImpl = '';
    } else {
      keyConstantsImpl =
        'static const String ' +
        keyConstants.keys.map((keyName) => '$keyName = ${keyConstants[keyName]}').join(', ') +
        '; ';
    }

    String keyListImpl =
        'static const List<String> $keyListName = const [' +
        keyConstants.keys.join(', ') +
        '];';

    String staticVariablesImpl = '    /* GENERATED CONSTANTS */ $keyConstantsImpl$keyListImpl';

    transformedFile.insert(
        sourceFile.location(typedMap.node.leftBracket.end),
        staticVariablesImpl
    );
  }
}

enum AccessorType {props, state}
