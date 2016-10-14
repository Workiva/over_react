library over_react.transformer;

import 'dart:async';

import 'package:analyzer/analyzer.dart';
import 'package:barback/barback.dart';
import 'package:over_react/src/transformer/declaration_parsing.dart';
import 'package:over_react/src/transformer/impl_generation.dart';
import 'package:path/path.dart' as p;
import 'package:source_span/source_span.dart';
import 'package:transformer_utils/transformer_utils.dart';

/// A transformer that modifies `.dart` files, aiding the declaration of React components
/// using the `@Factory()`, `@Props()` `@Component()`, etc. annotations.
///
/// This transformer:
///
/// * Generates prop/state accessors.
/// * Generates implementations for stubbed props/state/component classes.
/// * Creates component factories, registers them with react-dart, and wires them up to
/// their associated props/component implementations.
class WebSkinDartTransformer extends Transformer implements LazyTransformer {
  final BarbackSettings _settings;

  WebSkinDartTransformer.asPlugin(this._settings);

  /// Declare the assets this transformer uses. Only dart assets will be transformed.
  @override
  String get allowedExtensions => ".dart";

  @override
  void declareOutputs(DeclaringTransform transform) {
    transform.declareOutput(transform.primaryId);
    transform.consumePrimary();

    if (_settings.mode == BarbackMode.DEBUG) {
      transform.declareOutput(transform.primaryId.addExtension('.diff.html'));
    }
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

  @override
  Future apply(Transform transform) async {
    var primaryInputContents = await transform.primaryInput.readAsString();

    SourceFile sourceFile = new SourceFile(primaryInputContents, url: idToPackageUri(transform.primaryInput.id));
    TransformedSourceFile transformedFile = new TransformedSourceFile(sourceFile);
    TransformLogger logger = new JetBrainsFriendlyLogger(transform.logger);

    // If the source file might contain annotations that necessitate generation,
    // parse the declarations and generate code.
    // If not, don't skip this step to avoid parsing files that definitely won't generate anything.
    if (ParsedDeclarations.mightContainDeclarations(primaryInputContents)) {
      // Parse the source file on its own and use the resultant AST to...
      var unit = parseCompilationUnit(primaryInputContents,
        suppressErrors: true,
        name: transform.primaryInput.id.path,
        parseFunctionBodies: false
      );

      ParsedDeclarations declarations = new ParsedDeclarations(unit, sourceFile, logger);

      // If there are no errors, generate the component.
      if (!declarations.hasErrors) {
        new ImplGenerator(logger, transformedFile)
            .generate(declarations);
      }
    }

    // Replace static $PropKeys instantiations with prop keys
    if (new RegExp(r'\$PropKeys').hasMatch(primaryInputContents)) {
      var propKeysPattern = new RegExp(r'(?:const|new)\s+\$PropKeys\s*\(\s*([\$A-Za-z0-9_\.]+)\s*\)');
      propKeysPattern.allMatches(sourceFile.getText(0)).forEach((match) {
        var symbolName = match.group(1);

        var replacement = '$symbolName.${ImplGenerator.staticPropKeysName} /* GENERATED from \$PropKeys usage */';

        transformedFile.replace(sourceFile.span(match.start, match.end), replacement);
      });
    }

    // Replace static $Props instantiations with props
    if (new RegExp(r'\$Props').hasMatch(primaryInputContents)) {
      var propKeysPattern = new RegExp(r'(?:const|new)\s+\$Props\s*\(\s*([\$A-Za-z0-9_\.]+)\s*\)');
      propKeysPattern.allMatches(sourceFile.getText(0)).forEach((match) {
        var symbolName = match.group(1);

        var replacement = '$symbolName.${ImplGenerator.staticConsumedPropsName} /* GENERATED from \$Props usage */';

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

    if (_settings.mode == BarbackMode.DEBUG) {
      transform.addOutput(new Asset.fromString(transform.primaryInput.id.addExtension('.diff.html'),
          transformedFile.getHtmlDiff()
      ));
    }
  }
}
