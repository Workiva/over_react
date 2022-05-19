class PluginAnalysisOptions {
  final Map<String, AnalysisOptionsSeverity> errors;
  PluginAnalysisOptions(this.errors);
}

enum AnalysisOptionsSeverity {
  ignore,
  info,
  warning,
  error,
}
