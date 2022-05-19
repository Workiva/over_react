import 'package:over_react_analyzer_plugin/src/async_plugin_apis/error_severity_provider.dart';
import 'package:over_react_analyzer_plugin/src/config/config.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';

class ConfigErrorSeverityProvider implements ErrorSeverityProvider {
  final Config? config;

  ConfigErrorSeverityProvider(this.config);

  @override
  bool isCodeConfigured(String errorCode) {
    final errors = config?.errors;
    if (errors == null) {
      return false;
    }

    return errors.containsKey(errorCode);
  }

  @override
  bool isCodeDisabled(String errorCode) {
    final errors = config?.errors;
    if (errors == null) {
      return false;
    }

    return errors[errorCode] == ConfigSeverity.ignore;
  }

  @override
  AnalysisErrorSeverity? severityForCode(String errorCode) {
    final errors = config?.errors;
    if (errors == null) {
      return null;
    }

    final severity = errors[errorCode];

    return _severityMap[severity];
  }

  static const _severityMap = {
    ConfigSeverity.ignore: null,
    ConfigSeverity.info: AnalysisErrorSeverity.INFO,
    ConfigSeverity.error: AnalysisErrorSeverity.ERROR,
    ConfigSeverity.warning: AnalysisErrorSeverity.WARNING,
  };
}
