/// An object containing the data under the `over_react` key in a analysis_options.yaml file.
class PluginAnalysisOptions {
  final Map<String, AnalysisOptionsSeverity> errors;
  final RegExp? exhaustiveDepsAdditionalHooksPattern;

  PluginAnalysisOptions({required this.errors, this.exhaustiveDepsAdditionalHooksPattern});
}

enum AnalysisOptionsSeverity { ignore, info, warning, error }
