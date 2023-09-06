import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/src/generated/source.dart';
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
  /// [testPath].
  Source newSource(String? path, [String contents = '']) {
    if (path != null && p.isAbsolute(path)) {
      throw ArgumentError.value(path, 'path', 'must be a relative path');
    }
    final fileContext = sharedContext.fileContextForTest(contents, filename: path,
        // TODO could we enable this in some cases?
        includeTestDescription: false);
    return resourceProvider.getFile(fileContext.path).createSource();
  }

  void modifyFile(String path, String contents) {
    resourceProvider.getFile(path).writeAsStringSync(contents);
  }

  /// Returns the absolute path for [source].
  String sourcePath(Source source) => source.uri.toFilePath();

  static const testPathBase = '/Users/greglittlefield/workspaces/over_react2/tools/analyzer_plugin/';

  SharedAnalysisContext? _sharedContext;
  SharedAnalysisContext get sharedContext => _sharedContext!;

  @mustCallSuper
  Future<void> setUp() async {
    _sharedContext = SharedAnalysisContext.overReact;
    await sharedContext.warmUpAnalysis();
    _resourceProvider = sharedContext.collection.contexts.single.currentSession.resourceProvider;
  }

  @mustCallSuper
  void tearDown() {
    _resourceProvider = null;
  }
}
