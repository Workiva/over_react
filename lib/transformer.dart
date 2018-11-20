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
///
///
/// The following configuration options are available for the `over_react` transformer.
/// All values shown are the defaults.
///
///     transformers:
///     - over_react:
///         # Whether to apply a workaround in transformed props/state classes for a DDC bug
///         # in which abstract accessors clobber inherited concrete implementations:
///         # https://github.com/dart-lang/sdk/issues/29914.
///         #
///         # Fixes the issue by generating corresponding abstract getters/setters to
///         # complete the pair, limited to problematic accessors within transformed
///         # props/state classes that have the `@override` annotation.
///         fixDdcAbstractAccessors: false

class WebSkinDartTransformer extends Transformer implements LazyTransformer {
  final BarbackSettings _settings;
  final bool _shouldFixDdcAbstractAccessors;

  WebSkinDartTransformer.asPlugin(this._settings) :
      _shouldFixDdcAbstractAccessors = _loadBoolConfig(_settings, 'fixDdcAbstractAccessors');

  static bool _loadBoolConfig(BarbackSettings _settings, String configKey, {bool defaultValue: false}) {
    var value = _settings.configuration[configKey] ?? defaultValue;
    if (value is bool) return value;

    throw new ArgumentError.value(value, configKey, 'must be a bool');
  }

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

    SourceFile sourceFile = new SourceFile.fromString(primaryInputContents, url: idToPackageUri(transform.primaryInput.id));
    TransformedSourceFile transformedFile = new TransformedSourceFile(sourceFile);
    TransformLogger logger = new JetBrainsFriendlyLogger(transform.logger);

    var partPattern = new RegExp(r'''part\s+['"](.+.overReact.g.dart)['"];''');
    var partFilename = partPattern.firstMatch(sourceFile.getText(0));

    // For Dart 1 compatibility an empty generated part file will be created when a file contains
    // the part directive pointing to the generated file the new builder requires.
    if (partFilename != null) {
      partPattern.allMatches(sourceFile.getText(0)).forEach((match) {
        var sourceFileDirectory = p.dirname(sourceFile.url.toFilePath());
        var partFilePath = p.join(sourceFileDirectory, partFilename.group(1));
        var asset = new Asset.fromString(new AssetId(transform.primaryInput.id.package, partFilePath), '');

        transform.addOutput(asset);
      });
    }

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
            ..shouldFixDdcAbstractAccessors = _shouldFixDdcAbstractAccessors
            ..generate(declarations);
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