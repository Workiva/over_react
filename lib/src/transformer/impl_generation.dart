library web_skin_dart.transformer.impl_generation;

import 'package:analyzer/analyzer.dart';
import 'package:source_span/source_span.dart';
import 'package:web_skin_dart/src/transformer/declaration_parsing.dart';
import 'package:web_skin_dart/src/transformer/source_file_helpers.dart';
import 'package:web_skin_dart/src/transformer/text_util.dart';

const String generatedPrefix = r'_$';

ComponentGeneratedSourceFile generateComponent(ComponentDeclarations declarations, SourceFile sourceFile) {
  ComponentGeneratedSourceFile transformedFile = new ComponentGeneratedSourceFile(sourceFile);

  StringBuffer implementations = new StringBuffer();

  implementations
    ..writeln()
    ..writeln()
    ..write(commentBanner('GENERATED IMPLEMENTATIONS', bottomBorder: false))
    ..writeln();

  if (declarations.factory != null) {
    final String factoryName = declarations.factory.variables.variables.single.name.toString();

    final String propsName = declarations.props.name.toString();
    final String propsImplName = '$generatedPrefix${propsName}Impl';

    final String componentClassName = declarations.componentClass.name.toString();
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
        getSpan(sourceFile, declarations.factory),
        sourceFile.getText(declarations.factory.offset, declarations.factory.semicolon.offset)
            + ' = ' + factoryImpl + ';'
    );

    implementations
      ..writeln('// React component factory implementation')
      ..writeln('//')
      ..writeln('// registers component impl and links type meta to builder factory')
      ..writeln('final $componentFactoryName = registerComponent(() => new $componentClassImplName(), builderFactory: $factoryName);')
      ..writeln();

    // ----------------------------------------------------------------------
    //   Props implementation
    // ----------------------------------------------------------------------
    transformedFile.generateAccessors(AccessorType.props, declarations.props);

    final String propKeyNamespace = ComponentGeneratedSourceFile.getAccessorKeyNamespace(declarations.props);

    implementations
      ..writeln('// Props implementation')
      ..writeln('//')
      ..writeln('// implements constructor and backing map, and links up to generated component factory')
      ..writeln('class $propsImplName extends $propsName with MapViewMixin {')
      ..writeln('  @override')
      ..writeln('  final Map props;')
      ..writeln()
      ..writeln('  $propsImplName(Map backingMap) : this.props = backingMap != null ? backingMap : {};')
      ..writeln()
      ..writeln('  @override')
      ..writeln('  Function get componentFactory => $componentFactoryName;')
      ..writeln()
      ..writeln('  @override')
      ..writeln('  String get friendlyTypeName => "$propsName";')
      ..writeln('  @override')
      ..writeln('  String get propKeyNamespace => "$propKeyNamespace";')
      ..writeln('}')
      ..writeln();

    typedPropsFactoryImpl =
        '  @override\n'
        '  $propsName typedPropsFactory(Map backingMap) => new $propsImplName(backingMap);';

    // ----------------------------------------------------------------------
    //   State implementation
    // ----------------------------------------------------------------------
    if (hasState) {
      final String stateName = declarations.state.name.toString();
      final String stateImplName = '$generatedPrefix${stateName}Impl';

      transformedFile.generateAccessors(AccessorType.state, declarations.state);

      implementations
        ..writeln('// State implementation')
        ..writeln('//')
        ..writeln('// implements constructor and backing map')
        ..writeln('class $stateImplName extends $stateName with MapViewMixin {')
        ..writeln('  @override')
        ..writeln('  final Map state;')
        ..writeln()
        ..writeln('  $stateImplName(Map backingMap) : this.state = backingMap != null ? backingMap : {};')
        ..writeln()
        ..writeln('  @override')
        ..writeln('  String get friendlyTypeName => "$stateName";')
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
      ..writeln('// Component implementation')
      ..writeln('//')
      ..writeln('// implements typed props and typed state factories')
      ..writeln('class $componentClassImplName extends $componentClassName {')
      ..writeln(typedPropsFactoryImpl)
      ..writeln(typedStateFactoryImpl)
      ..writeln('  @override')
      ..writeln('  String get friendlyTypeName => "$componentClassName";')
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
    transformedFile.insert(
        sourceFile.location(propMixinClass.leftBracket.end),
        '    /** GENERATED MIXIN INTERFACE **/ Map get props;'
    );

    transformedFile.generateAccessors(AccessorType.props, propMixinClass);
  });

  declarations.stateMixins.forEach((stateMixinClass) {
    transformedFile.insert(
        sourceFile.location(stateMixinClass.leftBracket.end),
        '    /** GENERATED MIXIN INTERFACE **/ Map get state;'
    );

    transformedFile.generateAccessors(AccessorType.state, stateMixinClass);
  });

  // ----------------------------------------------------------------------
  //   Abstract Props/State implementations
  // ----------------------------------------------------------------------
  if (declarations.abstractProps != null) {
    transformedFile.generateAccessors(AccessorType.props, declarations.abstractProps);
  }

  if (declarations.abstractState != null) {
    transformedFile.generateAccessors(AccessorType.state, declarations.abstractState);
  }

  // ----------------------------------------------------------------------
  //   Replace static $PropKeys instantiations with prop keys
  // ----------------------------------------------------------------------
  var propKeysPattern = new RegExp(r'(?:const|new)\s+\$PropKeys\s*\(\s*\#\s*([^\)]+)\s*\)');
  propKeysPattern.allMatches(sourceFile.getText(0)).forEach((match) {
    var symbolName = match.group(1);
    var staticPropKeysName = ComponentGeneratedSourceFile.staticPropKeysName;

    var replacement = '$symbolName.$staticPropKeysName /* GENERATED from \$PropKeys usage */';

    transformedFile.replace(sourceFile.span(match.start, match.end), replacement);
  });


  // Finally, return the transformed file.
  return transformedFile;
}


enum AccessorType {props, state}


class ComponentGeneratedSourceFile extends TransformedSourceFile {
  ComponentGeneratedSourceFile(SourceFile sourceFile) : super(sourceFile);

  static const String proxiedPropsMapName = 'props';
  static const String proxiedStateMapName = 'state';

  static const String staticPropKeysName = '${generatedPrefix}propKeys';
  static const String staticStateKeysName = '${generatedPrefix}stateKeys';

  static String getAccessorKeyNamespace(ClassDeclaration accessorTemplate) {
    return '${accessorTemplate.name}.';
  }

  void generateAccessors(AccessorType type, ClassDeclaration accessorTemplate, {String namespace}) {
    if (namespace == null) {
      namespace = getAccessorKeyNamespace(accessorTemplate);
    }

    final String proxiedMapName = type == AccessorType.props ? proxiedPropsMapName : proxiedStateMapName;
    final String keyListName = type == AccessorType.props ? staticPropKeysName : staticStateKeysName;

    var keys = {};

    accessorTemplate.members
        .where((member) => member is FieldDeclaration)
        .where((FieldDeclaration member) => !member.isStatic)
        .forEach((FieldDeclaration field) {
          print('field $field');

          StringBuffer buffer = new StringBuffer();

          var type = field.fields.type;
          String typePrefix = type == null ? '' : '$type ';

          field.fields.variables.forEach((VariableDeclaration variable) {
            // todo check that field.initializer is null

            var name = variable.name;
            String keyName = '${generatedPrefix}key__$name';

            /// todo real key generation
            String keyValue = '"$namespace$name"';

            buffer.write('${typePrefix}get $name => $proxiedMapName[$keyName];');
            buffer.write('  set $name(${typePrefix}value) => $proxiedMapName[$keyName] = value;    ');

            keys[keyName] = keyValue;
          });

          this.replace(
              // Preserve docs comments and metadata on the field
              // todo add doc comments to non-first variables.
              sourceFile.span(field.firstTokenAfterCommentAndMetadata.offset, field.end),
              buffer.toString()
          );
        });

    var keyConstantsImpl;

    if (keys.keys.isEmpty) {
      keyConstantsImpl = '';
    } else {
      keyConstantsImpl =
        'static const String ' +
        keys.keys.map((keyName) => '$keyName = ${keys[keyName]}').join(', ') +
        '; ';
    }

    var keyListImpl =
        'static const List<String> $keyListName = const [' +
        keys.keys.join(', ') +
        '];';

    var staticVariablesImpl = '    /* GENERATED CONSTANTS */ $keyConstantsImpl$keyListImpl';

    this.insert(
        sourceFile.location(accessorTemplate.leftBracket.end),
        staticVariablesImpl
    );
  }
}


