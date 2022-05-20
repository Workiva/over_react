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

    Future<List<AnalysisError>> computeErrors({String sourceCode = boilerplateErrorSourceCode}) async {
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

    // This test ensures that when one of the error codes for a diagnostic contributor is disabled, it doesn't prevent
    // the other error codes from being computed.
    test('configured with partially disabled diagnostic contributor', () async {
      await setUp(yamlContents: yamlPartiallyDisabledContributor);
      final errors = await computeErrors(sourceCode: badKeysSourceCode);
      expect(errors, hasLength(1));
      expect(errors.first.code, equals('over_react_hash_code_as_key'));
    });

    test('configured with fully disabled diagnostic contributor', () async {
      await setUp(yamlContents: yamlFullyDisabledContributor);
      final errors = await computeErrors(sourceCode: badKeysSourceCode);
      expect(errors, isEmpty);
    });

    test('configured with fully enabled diagnostic contributor', () async {
      await setUp(yamlContents: yamlFullyEnabledContributor);
      final errors = await computeErrors(sourceCode: badKeysSourceCode);
      expect(errors, hasLength(2));
      expect(errors, contains(predicate<AnalysisError>((e) => e.code == 'over_react_hash_code_as_key')));
      expect(errors, contains(predicate<AnalysisError>((e) => e.code == 'over_react_low_quality_key')));
    });
  });
}

class AnalysisOptionsConfigurationTest extends ServerPluginContributorTestBase {
  final String _yamlContents;

  AnalysisOptionsConfigurationTest({String yamlContents}) : _yamlContents = yamlContents;

  @override
  String get analysisOptionsYamlContents => _yamlContents;
}

const boilerplateErrorSourceCode = /*language=dart*/ '''
part 'test.over_react.g.dart';
''';

/// Code containing two bad keys. The first is bad because it is a bool. The second is bad because it is a hashcode.
const badKeysSourceCode = /*language=dart*/ '''
import 'package:over_react/over_react.dart';

foo() {
  return [
      (Dom.div()..key = false)(),
      (Dom.div()..key = 'asdf'.hashCode)(),
    ];
}
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

// `over_react_hash_code_as_key` and `over_react_low_quality_key` come from the same [DiagnosticContributor]. Here, one
// is
const yamlPartiallyDisabledContributor = /*language=yaml*/ '''analyzer:
  plugins:
    over_react

over_react:
  errors:
    over_react_hash_code_as_key: error
    over_react_low_quality_key: ignore''';

const yamlFullyEnabledContributor = /*language=yaml*/ '''analyzer:
  plugins:
    over_react

over_react:
  errors:
    over_react_hash_code_as_key: error
    over_react_low_quality_key: error''';


const yamlFullyDisabledContributor = /*language=yaml*/ '''analyzer:
  plugins:
    over_react

over_react:
  errors:
    over_react_hash_code_as_key: ignore
    over_react_low_quality_key: ignore
    over_react_object_to_string_as_key: ignore
    over_react_unknown_key_type: ignore''';
