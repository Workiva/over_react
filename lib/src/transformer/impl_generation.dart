library web_skin_dart.transformer.impl_generation;

import 'package:analyzer/analyzer.dart';
import 'package:barback/barback.dart';
import 'package:source_span/source_span.dart';
import 'package:web_skin_dart/src/transformer/analyzer_helpers.dart';
import 'package:web_skin_dart/src/transformer/declaration_parsing.dart' show ComponentDeclarations;
import 'package:web_skin_dart/src/transformer/source_file_helpers.dart';
import 'package:web_skin_dart/src/transformer/text_util.dart';
import 'package:web_skin_dart/src/ui_core/transformer_generation/annotations.dart' as annotations;

class ImplGenerator {
  static const String generatedPrefix = r'_$';
  static const String publicGeneratedPrefix = r'$';

  final TransformLogger logger;
  final AssetId assetId;
  final TransformedSourceFile transformedFile;

  SourceFile get sourceFile => transformedFile.sourceFile;

  ImplGenerator(TransformLogger this.logger, AssetId this.assetId, TransformedSourceFile this.transformedFile);

  void generateComponent(ComponentDeclarations declarations) {
    StringBuffer implementations = new StringBuffer();

    implementations
      ..writeln()
      ..writeln()
      ..write(commentBanner('GENERATED IMPLEMENTATIONS', bottomBorder: false))
      ..writeln();

    if (declarations.factory != null) {
      final String factoryName = declarations.factory.node.variables.variables.single.name.toString();

      final String propsName = declarations.props.node.name.toString();
      final String propsImplName = '$generatedPrefix${propsName}Impl';

      final String componentClassName = declarations.component.node.name.toString();
      final String componentClassImplName = '$generatedPrefix${componentClassName}Impl';

      final String componentName = componentClassName;

      final String componentFactoryName = '$generatedPrefix${componentName}Factory';

      String typedPropsFactoryImpl = '';
      String typedStateFactoryImpl = '';

      final bool hasState = declarations.state != null;


      // ----------------------------------------------------------------------
      //   Factory implementation
      // ----------------------------------------------------------------------
      String factoryImpl =
        """([Map backingProps]) => new $propsImplName(backingProps)""";

      transformedFile.replace(
          getSpan(sourceFile, declarations.factory.node),
          sourceFile.getText(declarations.factory.node.offset, declarations.factory.node.semicolon.offset)
              + ' = ' + factoryImpl + ';'
      );

      implementations
        ..writeln('// React component factory implementation')
        ..writeln('//')
        ..writeln('// registers component impl and links type meta to builder factory')
        ..writeln('final $componentFactoryName = registerComponent(() => new $componentClassImplName(),')
        ..writeln('    builderFactory: $factoryName,')
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
        ..writeln('class $propsImplName extends $propsName with MapViewMixin {')
        ..writeln('  @override')
        ..writeln('  final Map props;')
        ..writeln()
        // Wrap Map literal in parens to work around https://github.com/dart-lang/sdk/issues/24410
        ..writeln('  $propsImplName(Map backingMap) : this.props = backingMap ?? ({});')
        ..writeln()
        ..writeln('  @override')
        ..writeln('  bool get \$generated => true;') // FIXME find better way to do this
        ..writeln()
        ..writeln('  @override')
        ..writeln('  Function get componentFactory => $componentFactoryName;')
        ..writeln()
        ..writeln('  @override')
        ..writeln('  String get friendlyTypeName => ${stringLiteral(propsName)};')
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
      if (hasState) {
        final String stateName = declarations.state.node.name.toString();
        final String stateImplName = '$generatedPrefix${stateName}Impl';

        generateAccessors(AccessorType.state, declarations.state);

        implementations
          ..writeln('// State implementation')
          ..writeln('//')
          ..writeln('// implements constructor and backing map')
          ..writeln('class $stateImplName extends $stateName with MapViewMixin {')
          ..writeln('  @override')
          ..writeln('  final Map state;')
          ..writeln()
          // Wrap Map literal in parens to work around https://github.com/dart-lang/sdk/issues/24410
          ..writeln('  $stateImplName(Map backingMap) : this.state = backingMap ?? ({});')
          ..writeln()
          ..writeln('  @override')
          ..writeln('  bool get \$generated => true;') // FIXME find better way to do this
          ..writeln()
          ..writeln('  @override')
          ..writeln('  String get friendlyTypeName => ${stringLiteral(stateName)};')
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
        ..writeln('  @override')
        ..writeln('  bool get \$generated => true;') // FIXME find better way to do this
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
        ..writeln('  @override')
        ..writeln('  String get friendlyTypeName => ${stringLiteral(componentClassName)};')
        ..writeln('}');
    }

    implementations
      ..writeln()
      ..write(commentBanner('END GENERATED IMPLEMENTATIONS', topBorder: false));

    transformedFile.insert(sourceFile.location(sourceFile.length), implementations.toString());


    // ----------------------------------------------------------------------
    //   Props/State Mixins implementations
    // ----------------------------------------------------------------------
    declarations.propsMixins.forEach((propMixinClass) {
      generateAccessors(AccessorType.props, propMixinClass);
    });

    declarations.stateMixins.forEach((stateMixinClass) {
      generateAccessors(AccessorType.state, stateMixinClass);
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
          StringBuffer generatedAccessorsForField = new StringBuffer();

          field.fields.variables.forEach((VariableDeclaration variable) {
            if (variable.initializer != null) {
              throw 'Fields are stubs for generated setters/getters and should not have initializers.';
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

            generatedAccessorsForField
              ..write('${typeString}get $accessorName => $proxiedMapName[$keyConstantName];')
              ..write('  ')
              ..write('set $accessorName(${typeString}value) => $proxiedMapName[$keyConstantName] = value;')
              ..write('    ');

            logger.fine('Generated accessor `$accessorName` with key $keyValue.',
                asset: assetId,
                span: getSpan(sourceFile, field)
            );
          });

          if (field.fields.variables.length > 1 &&
              (field.documentationComment != null || field.metadata.isNotEmpty)) {
            logger.warning(
                'Note: accessors declared as comma-separated variables will not all be generated '
                'with the original doc comments and annotations; only the first variable will.',
                asset: assetId,
                span: getSpan(sourceFile, field)
            );
          }

          transformedFile.replace(
              // Preserve docs comments and metadata on the field
              sourceFile.span(field.firstTokenAfterCommentAndMetadata.offset, field.end),
              generatedAccessorsForField.toString()
          );
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
