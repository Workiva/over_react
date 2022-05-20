/// An object containing the data under the `over_react` key in a analysis_options.yaml file.
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
