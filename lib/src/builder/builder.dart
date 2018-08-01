import 'dart:async';

import 'package:build/build.dart';

import 'package:analyzer/analyzer.dart';
import 'package:logging/logging.dart';
import 'package:over_react/src/builder/transformer_copy/declaration_parsing.dart';
import 'package:over_react/src/builder/transformer_copy/impl_generation.dart';
import 'package:path/path.dart' as p;
import 'package:source_span/source_span.dart';

Builder overReactBuilder(BuilderOptions options) => new OverReactBuilder();

class OverReactBuilder implements Builder {
  OverReactBuilder();

  /// Converts [id] to a "package:" URI.
  ///
  /// This will return a schemeless URI if [id] doesn't represent a library in
  /// `lib/`.
  static Uri idToPackageUri(AssetId id) {
    if (!id.path.startsWith('lib/')) {
      return new Uri(path: id.path);
    }

    return new Uri(scheme: 'package',
        path: p.url.join(id.package, id.path.replaceFirst('lib/', '')));
  }

  @override
  Future build(BuildStep buildStep) async {
    // Verify that we have a valid library
    if (await buildStep.resolver.isLibrary(buildStep.inputId)) {
      var entryLib = await buildStep.inputLibrary;
      var inputId = await buildStep.inputId;

      var primaryInputContents = await buildStep.readAsString(inputId);

      var sourceFile = new SourceFile.fromString(
          primaryInputContents, url: idToPackageUri(inputId));

      var outputTarget = buildStep.inputId.changeExtension(
          '.overReactBuilder.g.dart');

      ImplGenerator generator;
      if (ParsedDeclarations.mightContainDeclarations(primaryInputContents)) {
        var unit = parseCompilationUnit(primaryInputContents,
            suppressErrors: true,
            name: inputId.path,
            parseFunctionBodies: false
        );

        var declarations = new ParsedDeclarations(unit, sourceFile, log);

        if (!declarations.hasErrors) {
          generator = new ImplGenerator(log, primaryInputContents, entryLib.source.shortName)
//            ..shouldFixDdcAbstractAccessors = _shouldFixDdcAbstractAccessors
            ..generate(declarations);
        }

        var astWrapper = new AstWrapper();
        astWrapper.visitCompilationUnit(
            entryLib.definingCompilationUnit.computeNode());

        await buildStep.writeAsString(
            outputTarget, generator.outputContentsBuffer.toString());
      }
    }
  }

  @override
  Map<String, List<String>> get buildExtensions =>
      {'.dart': const ['.overReactBuilder.g.dart']};
}

class AstWrapper extends RecursiveAstVisitor {
  List<String> _superTypes;

  List<String> get superTypes => _superTypes;

  @override
  visitClassDeclaration(ClassDeclaration node) {
    super.visitClassDeclaration(node);
    _superTypes = new List<String>();
    node?.element?.allSupertypes?.forEach((element) {
      _superTypes.add(element.toString());
    });
  }
}
