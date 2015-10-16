library web_skin_dart.transformer;

import 'dart:async';

import 'package:analyzer/analyzer.dart';
import 'package:barback/barback.dart';
import 'package:path/path.dart' as p;
import 'package:source_span/source_span.dart';
import 'package:web_skin_dart/src/transformer/declaration_parsing.dart';
import 'package:web_skin_dart/src/transformer/impl_generation.dart';


class WebSkinDartTransformer extends Transformer implements LazyTransformer {
  WebSkinDartTransformer.asPlugin();

  /// Declare the assets this transformer uses. Only html assets will be transformed.
  String get allowedExtensions => ".dart";


  @override
  void declareOutputs(DeclaringTransform transform) {
    transform.declareOutput(transform.primaryId);
    transform.consumePrimary();
  }

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

  Future apply(Transform transform) async {
    void outputUntransformedAsset() {
      transform.addOutput(transform.primaryInput);
    }

    var primaryInputContents = await transform.primaryInput.readAsString();
    if (!primaryInputContents.contains(ComponentDeclarations.ANNOTATION_ANY)) {
      // Do a regex on the source to short-circuit inputs so that files that
      // won't generate anything don't get parsed unnecessarily.
      outputUntransformedAsset();
      return;
    }

    SourceFile sourceFile = new SourceFile(primaryInputContents, url: idToPackageUri(transform.primaryInput.id));

    void logError(String message, SourceSpan span) {
      String spanString = '';
      if (span != null) {
        // Format the span in a way that Jetbrains IDEs understand so that links
        // in the output take you to the right place in the file.
        var point = span.start;
        spanString = '[${point.sourceUrl} ${point.line + 1}:${point.column + 1}]: ';
      }

      transform.logger.error(spanString + message, asset: transform.primaryInput.id);
    }

    // Parse the source file on its own and use the resultant AST to...
    var unit = parseCompilationUnit(primaryInputContents,
      suppressErrors: true,
      name: transform.primaryInput.id.path,
      parseFunctionBodies: false
    );

    bool hasDeclarationErrors = false;
    ComponentDeclarations declarations = new ComponentDeclarations(unit, sourceFile, onError: (String message, SourceSpan span) {
      hasDeclarationErrors = true;
      logError(message, span);
    });

    if (hasDeclarationErrors) {
      outputUntransformedAsset();
      return;
    }

    ComponentGeneratedSourceFile newSource = generateComponent(declarations, sourceFile);

    transform.addOutput(new Asset.fromString(transform.primaryInput.id, newSource.getTransformedText()));
  }
}



