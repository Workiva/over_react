import 'dart:io';

import 'package:analyzer/file_system/file_system.dart' show ResourceProvider;
// ignore: implementation_imports
import 'package:analyzer/src/generated/source.dart' show Source;
import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;

import '../../util/shared_analysis_context.dart';
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
  /// Provider of all resources created during and needed for tests.
  ResourceProvider get resourceProvider => _resourceProvider!;
  ResourceProvider? _resourceProvider;

  /// Contents of analysis_options.yaml file.
  ///
  /// This is optional; if `null`, there will be no analysis_options.yaml file.
  String? get analysisOptionsYamlContents => null;

  /// Creates and returns a new source file at [path] with optional file
  /// [contents].
  ///
  /// [path] must be relative; the returned source will be created within
  /// [sharedContext].
  Source newSource(String? path, [String contents = '']) {
    if (path != null && p.isAbsolute(path)) {
      throw ArgumentError.value(path, 'path', 'must be a relative path');
    }
    final testFilePath = sharedContext.createTestFile(contents, filename: path);
    return resourceProvider.getFile(testFilePath).createSource();
  }

  void modifyFile(String path, String contents) {
    resourceProvider.getFile(path).writeAsStringSync(contents);
  }

  /// Returns the absolute path for [source].
  String sourcePath(Source source) => source.uri.toFilePath();

  SharedAnalysisContext? _sharedContext;

  SharedAnalysisContext get sharedContext => _sharedContext!;

  @mustCallSuper
  Future<void> setUp() async {
    // TODO once we're running tests optionally on null-safe code? Or maybe language version comments in source files instead?
    // final defaultContext = isNullSafe ? SharedAnalysisContext.overReactNullSafe : SharedAnalysisContext.overReactNonNullSafe;
    final defaultContext = SharedAnalysisContext.overReact;
    if (analysisOptionsYamlContents == null) {
      _sharedContext = defaultContext;
    } else {
      // Create a copy since modifying the original context would interfere with other test.
      //
      // Make sure the copy is on the same level as the original so that we don't have to mess with relative paths
      // in the pubspec (e.g., to the over_react dependency).
      // Original: test/test_fixtures/over_react_project/
      // Copy: test/temporary_test_fixtures/<generated_name>/
      final parentDir = p.canonicalize(p.join(defaultContext.contextRootPath, '../../temporary_test_fixtures'));
      _sharedContext = SharedAnalysisContext.createTemporaryCopy(defaultContext, parentDir);
      File(p.join(sharedContext.contextRootPath, 'analysis_options.yaml'))
          .writeAsStringSync(analysisOptionsYamlContents!);
    }

    await sharedContext.warmUpAnalysis();
    _resourceProvider = sharedContext.collection.contexts.single.currentSession.resourceProvider;
  }

  @mustCallSuper
  void tearDown() {
    _resourceProvider = null;
    if (_sharedContext != null && sharedContext.isTemporaryCopy) {
      Directory(sharedContext.contextRootPath).deleteSync(recursive: true);
    }
    _sharedContext = null;
  }
}
