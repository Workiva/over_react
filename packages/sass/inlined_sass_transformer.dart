library sass.inlined_sass_transformer;

import 'dart:async';
import 'package:barback/barback.dart';
import 'package:sass/sass.dart';
import 'package:sass/transformer.dart';

class InlinedSassTransformer extends BaseSassTransformer {
  InlinedSassTransformer(BarbackSettings settings, Sass sass) :
    super(settings, sass);

  InlinedSassTransformer.asPlugin(BarbackSettings settings) :
    this(settings, new Sass());

  @override
  Future<String> processInput(Transform transform) {
    AssetId id = transform.primaryInput.id;
    return _inlineSassImports(id, transform, id.package)
        .then((sassFile) => sassFile.contents);
  }

  Future<InlinedSassFile> _inlineSassImports(AssetId sassAsset, Transform transform, String primaryPackage) {
    return transform.readInputAsString(sassAsset).then((contents) {
      var sassFile = new SassFile(contents);
      var filteredImports = filterImports(primaryPackage, sassFile.imports);
      var importedAssets = filteredImports.map((import) => resolveImportAssetId(transform, sassAsset, import));
      var inlinedImports = importedAssets.map((Future asset) => asset.then((id) => _inlineSassImports(id, transform, primaryPackage)));

      return Future
          .wait(inlinedImports)
          .then((sassFiles) {
            var imports = new Map.fromIterables(filteredImports, sassFiles);
            return new InlinedSassFile(contents, imports);
          });
    });
  }
}
