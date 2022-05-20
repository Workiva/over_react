import 'package:over_react_analyzer_plugin/src/analysis_options/parse.dart';
import 'package:over_react_analyzer_plugin/src/analysis_options/plugin_analysis_options.dart';
import 'package:test/test.dart';

void main() {
  group('PluginAnalysisOptions parse yaml', () {
    test('with base case', () {
      final options = processAnalysisOptionsFile(baseCaseYaml);
      expect(options, isNotNull);
      options!;
      expect(options.errors, hasLength(4));
      expect(options.errors['over_react_boilerplate_error'], equals(AnalysisOptionsSeverity.error));
      expect(options.errors['over_react_incorrect_doc_comment_location'], equals(AnalysisOptionsSeverity.warning));
      expect(options.errors['over_react_unnecessary_key'], equals(AnalysisOptionsSeverity.info));
      expect(options.errors['over_react_pseudo_static_lifecycle'], equals(AnalysisOptionsSeverity.ignore));
    });

    test('without not configured', () {
      final options = processAnalysisOptionsFile(pluginNotConfiguredYaml);
      expect(options, isNull);
    });

    test('with no error section', () {
      final options = processAnalysisOptionsFile(noErrorSectionYaml);
      expect(options, isNotNull);
      options!;
      expect(options.errors, hasLength(0));
    });

    test('with invalid severity level', () {
      final options = processAnalysisOptionsFile(invalidSeverityLevelYaml);
      expect(options, isNotNull);
      options!;
      expect(options.errors, hasLength(2));
      expect(options.errors['over_react_boilerplate_error'], equals(AnalysisOptionsSeverity.error));
      expect(options.errors['over_react_pseudo_static_lifecycle'], equals(AnalysisOptionsSeverity.ignore));
    });

    test('with empty error list', () {
      final options = processAnalysisOptionsFile(emptyErrorListYaml);
      expect(options, isNotNull);
      options!;
      expect(options.errors, hasLength(0));
    });
  });
}

const baseCaseYaml = '''include: package:workiva_analysis_options/v1.recommended.yaml

analyzer:
  plugins:
    over_react
  errors:
    missing_required_param: warning

over_react:
  errors:
    over_react_boilerplate_error: error
    over_react_incorrect_doc_comment_location: warning
    over_react_unnecessary_key: info
    over_react_pseudo_static_lifecycle: ignore''';

const pluginNotConfiguredYaml = '''include: package:workiva_analysis_options/v1.recommended.yaml

analyzer:
  plugins:
    over_react
  errors:
    missing_required_param: warning''';

const noErrorSectionYaml = '''include: package:workiva_analysis_options/v1.recommended.yaml

analyzer:
  plugins:
    over_react
  errors:
    missing_required_param: warning

over_react:
  not_errors:
    over_react_boilerplate_error: error
    over_react_pseudo_static_lifecycle: ignore''';

const invalidSeverityLevelYaml = '''include: package:workiva_analysis_options/v1.recommended.yaml

analyzer:
  plugins:
    over_react
  errors:
    missing_required_param: warning

over_react:
  errors:
    over_react_boilerplate_error: error
    over_react_incorrect_doc_comment_location: critical
    over_react_pseudo_static_lifecycle: ignore''';

const emptyErrorListYaml = '''include: package:workiva_analysis_options/v1.recommended.yaml

analyzer:
  plugins:
    over_react
  errors:
    missing_required_param: warning

over_react:
  errors:
''';