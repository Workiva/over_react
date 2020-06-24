import 'dart:io';

import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/file_system/memory_file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer/src/context/context_root.dart';
import 'package:analyzer/src/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/src/dart/analysis/byte_store.dart';
import 'package:analyzer/src/dart/analysis/driver.dart'
    show AnalysisDriver, AnalysisDriverScheduler;
import 'package:analyzer/src/dart/analysis/driver.dart';
import 'package:analyzer/src/dart/analysis/file_state.dart';
import 'package:analyzer/src/dart/analysis/performance_logger.dart';
import 'package:analyzer/src/generated/engine.dart';
import 'package:analyzer/src/generated/source.dart';
import 'package:analyzer/src/generated/source_io.dart';
import 'package:analyzer/src/source/package_map_resolver.dart';
import 'package:analyzer/src/test_utilities/mock_sdk.dart';
import 'package:meta/meta.dart';
import 'package:package_config/package_config.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

abstract class AnalysisDriverTestBase {
  static const _realPackagesToCopyIntoResourceProvider = [
    'over_react',
  ];

  AnalysisDriver get analysisDriver => _analysisDriver;
  AnalysisDriver _analysisDriver;

  MemoryResourceProvider get resourceProvider => _resourceProvider;
  MemoryResourceProvider _resourceProvider;

  String get testPath => _testPath;
  String _testPath;

  Source newSource(String path, [String content]) {
    expect(p.isAbsolute(path), isFalse,
        reason: 'newSource() must be called with a relative path');
    final absolutePath = p.join(testPath, path);
    final file = resourceProvider.newFile(absolutePath, content ?? '');
    return file.createSource();
  }

  String sourcePath(Source source) =>
      resourceProvider.convertPath(source.uri.path);

  @mustCallSuper
  Future<void> setUp() async {
    _resourceProvider = MemoryResourceProvider();

    final sdk = MockSdk(resourceProvider: resourceProvider);
    final packageMap = {
      for (final packageName in _realPackagesToCopyIntoResourceProvider)
        packageName: [await _loadRealPackage(packageName, resourceProvider)],
    };

    // Setup a testing directory. All calls to [newSource] will create files
    // within this directory.
    _testPath = resourceProvider.newFolder('/test').path;

    final logger = PerformanceLog(StringBuffer());
    final analysisScheduler = AnalysisDriverScheduler(logger)..start();
    _analysisDriver = AnalysisDriver(
      analysisScheduler,
      logger,
      resourceProvider,
      MemoryByteStore(),
      FileContentOverlay(),
      ContextRoot(testPath, [], pathContext: null),
      SourceFactory([
        DartUriResolver(sdk),
        PackageMapUriResolver(resourceProvider, packageMap),
        ResourceUriResolver(resourceProvider),
      ]),
      AnalysisOptionsImpl(),
    );

    final contextCollection = AnalysisContextCollectionImpl(
        includedPaths: [testPath],
        resourceProvider: resourceProvider,
        sdkPath: resourceProvider.convertPath('/sdk'));
    _analysisDriver.analysisContext = contextCollection.contextFor(testPath);
  }

  @mustCallSuper
  void tearDown() {
    _analysisDriver?.dispose();
    _analysisDriver = null;
    _resourceProvider = null;
    _testPath = null;
  }

  static Future<PackageConfig> _getRootPackageConfig() async =>
      _realPackageConfig ??=
          await findPackageConfig(Directory.current, recurse: false);
  static PackageConfig _realPackageConfig;

  static Future<Folder> _loadRealPackage(
      String packageName, MemoryResourceProvider memory) async {
    final package = (await _getRootPackageConfig())
        .packages
        .firstWhere((pkg) => pkg.name == packageName, orElse: () => null);
    expect(package, isNotNull,
        reason:
            'Could not load "$packageName" into MemoryResourceProvider because it is not a dependency.');
    final physicalRoot = p.normalize(package.packageUriRoot.toFilePath());
    final memoryRoot = p.normalize('/packages/$packageName');
    PhysicalResourceProvider.INSTANCE
        .getFolder(physicalRoot)
        .copyTo(memory.getFolder(memoryRoot));
    return memory.getFolder(p.join(memoryRoot, 'lib'));
  }
}
