import 'package:over_react_analyzer_plugin/src/async_plugin_apis/error_severity_provider.dart';
import 'package:over_react_analyzer_plugin/src/analysis_options/plugin_analysis_options.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';

/// Provider of configuration options based on the given [PluginAnalysisOptions].
class AnalysisOptionsErrorSeverityProvider implements ErrorSeverityProvider {
  final PluginAnalysisOptions? _analysisOption;

  AnalysisOptionsErrorSeverityProvider(this._analysisOption);

  @override
  bool isCodeConfigured(String errorCode) {
    final errors = _analysisOption?.errors;
    if (errors == null) {
      return false;
    }

    return errors.containsKey(errorCode);
  }

  @override
  bool isCodeDisabled(String errorCode) {
    final errors = _analysisOption?.errors;
    if (errors == null) {
      return false;
    }

    return errors[errorCode] == AnalysisOptionsSeverity.ignore;
  }

  @override
  AnalysisErrorSeverity? severityForCode(String errorCode) {
    final errors = _analysisOption?.errors;
    if (errors == null) {
      return null;
    }

    final severity = errors[errorCode];

    return _severityMap[severity];
  }

  static const _severityMap = {
    AnalysisOptionsSeverity.ignore: null,
    AnalysisOptionsSeverity.info: AnalysisErrorSeverity.INFO,
    AnalysisOptionsSeverity.error: AnalysisErrorSeverity.ERROR,
    AnalysisOptionsSeverity.warning: AnalysisErrorSeverity.WARNING,
  };
}
