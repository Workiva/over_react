library web_skin_dart.transformer;

import 'dart:async';

import 'package:analyzer/analyzer.dart';
import 'package:barback/barback.dart';
import 'package:path/path.dart' as p;
import 'package:source_span/source_span.dart';
import 'package:web_skin_dart/src/transformer/declaration_parsing.dart' show ComponentDeclarations;
import 'package:web_skin_dart/src/transformer/impl_generation.dart' show generateComponent, staticPropKeysName;
import 'package:web_skin_dart/src/transformer/source_file_helpers.dart' show TransformedSourceFile;


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
    var primaryInputContents = await transform.primaryInput.readAsString();

    SourceFile sourceFile = new SourceFile(primaryInputContents, url: idToPackageUri(transform.primaryInput.id));
    TransformedSourceFile transformedFile = new TransformedSourceFile(sourceFile);

    // Short-circuit files that won't generate anything so they don't get parsed unnecessarily.
    if (ComponentDeclarations.mightContainDeclarations(primaryInputContents)) {
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

      // If there are no errors, generate the component.

      // Otherwise, just log the errors and do nothing.
      if (!hasDeclarationErrors) {
        generateComponent(transformedFile, declarations);
      }
    }

    if (new RegExp(r'\$PropKeys').hasMatch(primaryInputContents)) {
      // ----------------------------------------------------------------------
      //   Replace static $PropKeys instantiations with prop keys
      // ----------------------------------------------------------------------
      var propKeysPattern = new RegExp(r'(?:const|new)\s+\$PropKeys\s*\(\s*\#\s*([^\)]+)\s*\)');
      propKeysPattern.allMatches(sourceFile.getText(0)).forEach((match) {
        var symbolName = match.group(1);

        var replacement = '$symbolName.$staticPropKeysName /* GENERATED from \$PropKeys usage */';

        transformedFile.replace(sourceFile.span(match.start, match.end), replacement);
      });
    }

    if (transformedFile.isModified) {
      // Output the transformed source.
      transform.addOutput(new Asset.fromString(transform.primaryInput.id, transformedFile.getTransformedText()));
    } else {
      // Output the unmodified input.
      transform.addOutput(transform.primaryInput);
    }
  }
}



