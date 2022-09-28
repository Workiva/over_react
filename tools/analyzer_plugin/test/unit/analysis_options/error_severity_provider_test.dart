import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:over_react_analyzer_plugin/src/analysis_options/error_severity_provider.dart';
import 'package:over_react_analyzer_plugin/src/analysis_options/plugin_analysis_options.dart';
import 'package:test/test.dart';

void main() {
  group('AnalysisOptionsErrorSeverityProvider', () {
    const code1 = 'over_react_boilerplate_error';
    const code2 = 'over_react_incorrect_doc_comment_location';
    const code3 = 'over_react_unnecessary_key';
    const code4 = 'over_react_pseudo_static_lifecycle';
    const code5 = 'over_react_consumed_props_return_value';

    final options = PluginAnalysisOptions(errors: {
      code1: AnalysisOptionsSeverity.error,
      code2: AnalysisOptionsSeverity.warning,
      code3: AnalysisOptionsSeverity.info,
      code4: AnalysisOptionsSeverity.ignore,
    });

    final severityProvider = AnalysisOptionsErrorSeverityProvider(options);

    test('with error codes with severity assigned', () {
      expect(severityProvider.isCodeConfigured(code1), isTrue);
      expect(severityProvider.isCodeConfigured(code2), isTrue);
      expect(severityProvider.isCodeConfigured(code3), isTrue);

      expect(severityProvider.isCodeDisabled(code1), isFalse);
      expect(severityProvider.isCodeDisabled(code2), isFalse);
      expect(severityProvider.isCodeDisabled(code3), isFalse);

      expect(severityProvider.severityForCode(code1), AnalysisErrorSeverity.ERROR);
      expect(severityProvider.severityForCode(code2), AnalysisErrorSeverity.WARNING);
      expect(severityProvider.severityForCode(code3), AnalysisErrorSeverity.INFO);
    });

    test('with ignored error code', () {
      expect(severityProvider.isCodeConfigured(code4), isTrue);
      expect(severityProvider.isCodeDisabled(code4), isTrue);
    });

    test('with unconfigured code', () {
      expect(severityProvider.isCodeConfigured(code5), isFalse);
      expect(severityProvider.isCodeDisabled(code5), isFalse);
    });
  });
}
