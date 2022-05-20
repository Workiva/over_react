// Disable null-safety in the plugin entrypoint until all dependencies are null-safe,
// otherwise tests won't be able to run. See: https://github.com/dart-lang/test#compiler-flags
//@dart=2.9

import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:test/test.dart';

import '../test_bases/server_plugin_contributor_test_base.dart';

void main() {
  group('AnalysisOptionsConfiguration', () {
    AnalysisOptionsConfigurationTest testBase;

    Future<void> setUp({String yamlContents}) async {
      testBase = AnalysisOptionsConfigurationTest(yamlContents: yamlContents);
      await testBase.setUp();
      addTearDown(() {
        testBase.tearDown();
        testBase = null;
      });
    }

    Future<List<AnalysisError>> computeErrors() async {
      final source = testBase.newSource('test.dart', sourceCode);

      final result = await testBase.testPlugin.getResolvedUnitResult(testBase.sourcePath(source));
      final errors = await testBase.testPlugin.getAllErrors(result);
      return errors;
    }

    void expectSeverity(List<AnalysisError> errors, AnalysisErrorSeverity severity) {
      expect(errors, hasLength(1));
      expect(errors.first.severity, equals(severity));
    }

    test('configured to error', () async {
      await setUp(yamlContents: yamlError);
      final errors = await computeErrors();
      expectSeverity(errors, AnalysisErrorSeverity.ERROR);
    });

    test('configured to warning', () async {
      await setUp(yamlContents: yamlWarn);
      final errors = await computeErrors();
      expectSeverity(errors, AnalysisErrorSeverity.WARNING);
    });

    test('configured to info', () async {
      await setUp(yamlContents: yamlInfo);
      final errors = await computeErrors();
      expectSeverity(errors, AnalysisErrorSeverity.INFO);
    });

    test('configured to ignore', () async {
      await setUp(yamlContents: yamlIgnore);
      final errors = await computeErrors();
      expect(errors, isEmpty);
    });

    test('not configured', () async {
      await setUp(yamlContents: yamlNotConfigured);
      final errors = await computeErrors();
      expectSeverity(errors, AnalysisErrorSeverity.ERROR);
    });
  });
}

class AnalysisOptionsConfigurationTest extends ServerPluginContributorTestBase {
  final String _yamlContents;

  AnalysisOptionsConfigurationTest({String yamlContents}) : _yamlContents = yamlContents;

  @override
  String get analysisOptionsYamlContents => _yamlContents;
}

const sourceCode = /*language=dart*/ '''
part 'test.over_react.g.dart';
''';

const yamlError = /*language=yaml*/ '''analyzer:
  plugins:
    over_react

over_react:
  errors:
    over_react_boilerplate_error: error''';

const yamlWarn = /*language=yaml*/ '''analyzer:
  plugins:
    over_react

over_react:
  errors:
    over_react_boilerplate_error: warning''';

const yamlInfo = /*language=yaml*/ '''analyzer:
  plugins:
    over_react

over_react:
  errors:
    over_react_boilerplate_error: info''';

const yamlIgnore = /*language=yaml*/ '''analyzer:
  plugins:
    over_react

over_react:
  errors:
    over_react_boilerplate_error: ignore''';

const yamlNotConfigured = /*language=yaml*/ '''analyzer:
  plugins:
    over_react

over_react:
  errors:
''';
