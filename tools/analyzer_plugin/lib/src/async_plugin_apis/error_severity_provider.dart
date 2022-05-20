import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';

/// Provider of configuration options to the plugin.
///
/// This allows diagnostics to be optionally disabled, or their severity to be adjusted.
abstract class ErrorSeverityProvider {
  bool isCodeConfigured(String errorCode);
  bool isCodeDisabled(String errorCode);
  AnalysisErrorSeverity? severityForCode(String errorCode);
}
