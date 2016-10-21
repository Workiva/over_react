library sass.transformer;

import 'dart:async';
import 'package:barback/barback.dart';
import 'package:sass/sass.dart';
import 'package:path/path.dart';

part 'src/base_sass_transformer.dart';
part 'src/inlined_sass_file.dart';
part 'src/sass_file.dart';
part 'src/transformer_options.dart';

/// Transformer used by `pub build` and `pub serve` to convert Sass-files to CSS.
class SassTransformer extends BaseSassTransformer implements DeclaringTransformer {

  SassTransformer(BarbackSettings settings, Sass sass) :
    super(settings, sass);

  SassTransformer.asPlugin(BarbackSettings settings) :
    this(settings, new Sass());

  @override
  Future<String> processInput(Transform transform) {
    AssetId id = transform.primaryInput.id;
    return _readImportsRecursively(transform, id, id.package);
  }

  /// Reads all the imports of module so that Barback realizes that we depend on them.
  ///
  /// When Barback calls the transformer to process foo.scss, it will keep track of all
  /// read-calls so it knows which files foo.scss is dependent on. So if foo.scss
  /// imports bar.scss (and therefore we perform dummy read on bar.scss as well),
  /// Barback knows that if bar.scss changes, it will need to recompile foo.scss.
  /// This doesn't matter when executing a batch build with "pub build", but it's
  /// really important with "pub serve".
  Future _readImportsRecursively(Transform transform, AssetId assetId, String primaryPackage) =>
    transform.readInputAsString(assetId).then((source) {
      var sassFile = new SassFile(source);
      var imports = filterImports(primaryPackage, sassFile.imports);

      return Future.wait(imports.map((import) =>
        resolveImportAssetId(transform, assetId, import).then((importId) =>
          _readImportsRecursively(transform, importId, primaryPackage))
      )).then((_) => source);
    });
}
