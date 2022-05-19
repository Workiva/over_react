import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';

abstract class ErrorSeverityProvider {
  bool isCodeConfigured(String errorCode);
  bool isCodeDisabled(String errorCode);
  AnalysisErrorSeverity? severityForCode(String errorCode);
}
