part of sass.transformer;

abstract class BaseSassTransformer extends Transformer implements DeclaringTransformer {
  final BarbackSettings settings;
  final TransformerOptions options;
  final Sass _sass;

  BaseSassTransformer(BarbackSettings settings, this._sass) :
    settings = settings,
    options = new TransformerOptions.parse(settings.configuration);

  bool isPrimary(AssetId input) {
    // We consider all .scss and .sass files primary although in reality we process only
    // the ones that don't start with an underscore. This way we can call consumePrimary()
    // for all files and they don't end up in the build-directory.
    var extension = posix.extension(input.path);
    var primary = extension == '.sass' || extension == '.scss';

    return primary;
  }

  bool _isFromPackages(String filePath) => filePath.contains('packages');

  List<String> _splitPackagePath(String filePath) {
    var paths = posix.split(filePath);
    paths = paths.sublist(paths.indexOf('packages'))..removeAt(0);
    return paths;
  }

  bool _isExternalPackageAsset(String package, _SassImport asset) =>
    _isFromPackages(asset.path) && (package != _splitPackagePath(asset.path).first);

  declareOutputs(DeclaringTransform transform) {
    AssetId primaryAssetId = transform.primaryId;
    if (_isPartial(primaryAssetId))
      return;

    transform.declareOutput(primaryAssetId.changeExtension('.css'));
  }

  Future apply(Transform transform) {
    AssetId primaryAssetId = transform.primaryInput.id;

    if (!options.copySources)
      transform.consumePrimary();

    if (_isPartial(primaryAssetId))
      return new Future.value();

    return processInput(transform).then((content) {
      _sass.executable = options.executable;
      _sass.style = options.style;
      _sass.compass = options.compass;
      _sass.lineNumbers = options.lineNumbers;

      if (primaryAssetId.extension == '.scss') {
        _sass.scss = true;
      }

      _sass.loadPath.add(posix.dirname(primaryAssetId.path));

      return _sass.transform(content).then((output) {
        var newId = transform.primaryInput.id.changeExtension('.css');
        transform.addOutput(new Asset.fromString(newId, output));
      });
    });
  }

  bool _isPartial(AssetId asset) => posix.basename(asset.path).startsWith('_');

  Future<String> processInput(Transform transform);

  Iterable<_SassImport> filterImports(String package, Iterable<_SassImport> imports) {
    if (options.compass) {
      return imports.where((import) => !import.path.startsWith("compass") && !_isExternalPackageAsset(package, import));
    } else {
      return imports.where((import) => !_isExternalPackageAsset(package, import));
    }
  }

  Future<AssetId> resolveImportAssetId(Transform transform, AssetId assetId, _SassImport import) {
    var assetIds = _candidateAssetIds(assetId, import);

    return _firstExisting(transform, assetIds).then((id) {
      if (id != null)
        return id;
      else
        return new Future.error(new SassException("could not resolve import '$import' (tried $assetIds)"));
    });
  }

  /// Returns the first existing assetId from assetIds, or null if none is found.
  Future<AssetId> _firstExisting(Transform transform, List<AssetId> assetIds) {
    loop(int index) {
      if (index >= assetIds.length)
        return new Future.value(null);

      var assetId = assetIds[index];
      return transform.hasInput(assetId).then((exists) {
        if (exists)
          return new Future.value(assetId);
        else
          return loop(index+1);
      });
    }

    return loop(0);
  }

  List<AssetId> _candidateAssetIds(AssetId assetId, _SassImport import) {
    var names = [];

    var dirname = posix.dirname(import.path);
    var basename = posix.basename(import.path);

    if (basename.contains('.')) {
      names.add(basename);
      names.add("_$basename");
    } else {
      names.add("$basename.scss");
      names.add("$basename.sass");
      names.add("_$basename.scss");
      names.add("_$basename.sass");
    }

    // If the imported file is from this package lib (for test purposes or something) we should search it's source file using lib path.
    // So instead of `AssetId('my_sass', 'test/packages/my_sass/_partial.scss')` we should use
    // `AssetId('my_sass', 'lib/_partial.scss')`
    // But for the local partials in test/_partial.scss we should use `AssetId('my_app', 'test/_partial.scss')`
    //
    // Another example. If we have some local partial in test/sass/_partial.scss, that want to use some pub
    // packaged partial, it could have something like this `@import "../packages/my_sass/partial";`, so
    // we need to skip all parts before 'packages' and use rest part to make same `AssetId('my_sass', 'lib/_partial.scss')`
    // as in the first case.
    var package = assetId.package;
    var assetDir = posix.dirname(assetId.path);
    if (_isFromPackages(dirname)) {
      var paths = _splitPackagePath(dirname);
      package = paths[0];
      paths[0] = 'lib';
      dirname = posix.joinAll(paths);
      assetDir = '';
    }

    return names.map((n) => new AssetId(package, posix.join(assetDir, dirname, n))).toList();
  }
}
