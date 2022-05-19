class PluginAnalysisOptions {
  final Map<String, AnalysisOptionsSeverity> errors;
  PluginAnalysisOptions({required this.errors});
}

enum AnalysisOptionsSeverity {
  ignore,
  info,
  warning,
  error,
}
