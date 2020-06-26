import 'dart:io';

import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/file_system/memory_file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer/src/context/context_root.dart';
import 'package:analyzer/src/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/src/dart/analysis/byte_store.dart';
import 'package:analyzer/src/dart/analysis/driver.dart' show AnalysisDriver, AnalysisDriverScheduler;
import 'package:analyzer/src/dart/analysis/file_state.dart';
import 'package:analyzer/src/dart/analysis/performance_logger.dart';
import 'package:analyzer/src/generated/engine.dart';
import 'package:analyzer/src/generated/source.dart';
import 'package:analyzer/src/source/package_map_resolver.dart';
import 'package:analyzer/src/test_utilities/mock_sdk.dart';
import 'package:meta/meta.dart';
import 'package:package_config/package_config.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import 'assist_test_base.dart';

/// Test base that handles constructing an analysis server plugin designed for
/// use in tests.
///
/// Also provides some utilities related to source files.
///
/// Tests should not use, extend, or implement this class directly. Instead,
/// extend a test base for the specific type of contributor, like
/// [AssistTestBase].
abstract class AnalysisDriverTestBase {
  /// The list of packages that are dependencies of this
  /// `over_react_analyzer_plugin` package and are required for contributor
  /// integration test sources.
  ///
  /// Any package in this list will be copied from the physical pub-cache into
  /// the [MemoryResourceProvider] and the [AnalysisDriver] will be configured
  /// with a [PackageMapUriResolver] that knows where these packages are so that
  /// test sources can import from them.
  static const _realPackagesToCopyIntoResourceProvider = [
    'over_react',
  ];

  /// The analysis driver that computes analysis results for the test sources
  /// created via [newSource] that are then used by the plugin contributors
  /// under test.
  AnalysisDriver get analysisDriver => _analysisDriver;
  AnalysisDriver _analysisDriver;

  /// Provider of all resources created during and needed for tests.
  MemoryResourceProvider get resourceProvider => _resourceProvider;
  MemoryResourceProvider _resourceProvider;

  /// Absolute path to the in-memory folder within which all test sources are
  /// created.
  String get testPath => _testPath;
  String _testPath;

  /// Creates and returns a new source file at [path] with optional file
  /// [contents].
  ///
  /// [path] must be relative; the returned source will be created within
  /// [testPath].
  Source newSource(String path, [String contents]) {
    expect(p.isAbsolute(path), isFalse, reason: 'newSource() must be called with a relative path');
    final absolutePath = p.join(testPath, path);
    final file = resourceProvider.newFile(absolutePath, contents ?? '');
    return file.createSource();
  }

  /// Returns the absolute path for [source].
  String sourcePath(Source source) => resourceProvider.convertPath(source.uri.path);

  @mustCallSuper
  Future<void> setUp() async {
    // Based on https://github.com/dart-lang/angular/blob/832c8df2c54415e8b6e68886cd3d8c293ef9874c/angular_analyzer_plugin/test/analyzer_base.dart#L62-L89

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
        includedPaths: [testPath], resourceProvider: resourceProvider, sdkPath: resourceProvider.convertPath('/sdk'));
    _analysisDriver.analysisContext = contextCollection.contextFor(testPath);
  }

  @mustCallSuper
  void tearDown() {
    _analysisDriver?.dispose();
    _analysisDriver = null;
    _resourceProvider = null;
    _testPath = null;
  }

  /// Returns the parsed package config from the
  /// `.dart_tool/package_config.json` file for the
  /// `over_react_analyzer_plugin` package.
  static Future<PackageConfig> _getRootPackageConfig() async =>
      _realPackageConfig ??= await findPackageConfig(Directory.current, recurse: false);
  static PackageConfig _realPackageConfig;

  /// Finds the source of [packageName] and copies the physical resources into
  /// the [memory] resoure provider at the `/packages/$packageName` location.
  static Future<Folder> _loadRealPackage(String packageName, MemoryResourceProvider memory) async {
    final package =
        (await _getRootPackageConfig()).packages.firstWhere((pkg) => pkg.name == packageName, orElse: () => null);
    expect(package, isNotNull,
        reason: 'Could not load "$packageName" into MemoryResourceProvider because it is not a dependency.');
    final physicalRoot = p.normalize(package.packageUriRoot.toFilePath());
    final memoryRoot = p.normalize('/packages/$packageName');
    PhysicalResourceProvider.INSTANCE.getFolder(physicalRoot).copyTo(memory.getFolder(memoryRoot));
    return memory.getFolder(p.join(memoryRoot, 'lib'));
  }
}
