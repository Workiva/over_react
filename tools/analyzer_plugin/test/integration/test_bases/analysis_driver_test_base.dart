import 'dart:io';

import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer/src/generated/source.dart';
import 'package:meta/meta.dart';
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
  /// Provider of all resources created during and needed for tests.
  PhysicalResourceProvider get resourceProvider => _resourceProvider!;
  PhysicalResourceProvider? _resourceProvider;

  /// Absolute path to the in-memory folder within which all test sources are
  /// created.
  String get testPath => _testPath!;
  String? _testPath;

  /// Contents of analysis_options.yaml file.
  ///
  /// This is optional; if `null`, there will be no analysis_options.yaml file.
  String? get analysisOptionsYamlContents => null;

  /// Creates and returns a new source file at [path] with optional file
  /// [contents].
  ///
  /// [path] must be relative; the returned source will be created within
  /// [testPath].
  Source newSource(String path, [String contents = '']) {
    expect(p.isAbsolute(path), isFalse, reason: 'newSource() must be called with a relative path');
    final absolutePath = p.join(testPath, path);
    final file = resourceProvider.getFile(absolutePath);
    file.writeAsStringSync(contents);
    return file.createSource();
  }

  void modifyFile(String path, String contents) {
    resourceProvider.getFile(path).writeAsStringSync(contents);
  }

  /// Returns the absolute path for [source].
  String sourcePath(Source source) => source.uri.toFilePath();

  static const testPathBase = '/Users/greglittlefield/workspaces/over_react2/tools/analyzer_plugin/';

  @mustCallSuper
  Future<void> setUp() async {
    _resourceProvider = PhysicalResourceProvider();

    // Setup a testing directory. All calls to [newSource] will create files
    // within this directory.
    _testPath = Directory(testPathBase).createTempSync().path;

    // If analysis_options.yaml isn't set up here, `AnalysisContext.optionsFile` will be null even if the file is added later,
    // and also Dart will try to load analysis_options.yaml from an ancestor directory.
    resourceProvider
        .getFile(p.join(testPath, 'analysis_options.yaml'))
        .writeAsStringSync(analysisOptionsYamlContents ?? '');

    final testPackageName = 'test_package_' + p.basename(_testPath!).replaceAll(RegExp(r'[^a-zA-Z0-9_]'), '');
    const nullSafety = false;
    resourceProvider.getFile(p.join(testPath, 'pubspec.yaml')).writeAsStringSync('''
name: $testPackageName
environment:
  sdk: ${nullSafety ? '">=2.12.0 <3.0.0"' : '">=2.10.0 <3.0.0"'}
dependencies:
  over_react: 
    path: /Users/greglittlefield/workspaces/over_react2
''');

    // TODO optimize this: running `pub get` before each test is pretty slow.
    final pubGetResult =
        await Process.run('dart', ['pub', 'get', '--offline'], runInShell: true, workingDirectory: testPath);
    if (pubGetResult.exitCode != 0) {
      throw Exception('pub get failed with exit code ${pubGetResult.exitCode}.'
          '\n${pubGetResult.stdout}${pubGetResult.stderr}');
    }
  }

  @mustCallSuper
  void tearDown() {
    _resourceProvider = null;
    if (_testPath != null) {
      Directory(_testPath!).deleteSync(recursive: true);
    }
    _testPath = null;
  }
}
