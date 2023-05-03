import 'package:over_react_analyzer_plugin/src/analysis_options/plugin_analysis_options.dart';
import 'package:yaml/yaml.dart';

/// Parses the given yaml and returns over react analyzer plugin configuration options.
PluginAnalysisOptions? processAnalysisOptionsFile(String fileContents) {
  // TODO catch parse errors, add test coverage
  final yaml = loadYamlNode(fileContents);
  if (yaml is YamlMap) {
    return _parseAnalysisOptions(yaml);
  }

  // If the file isn't a map, return null
  return null;
}

PluginAnalysisOptions? _parseAnalysisOptions(YamlMap yaml) {
  final dynamic overReact = yaml['over_react'];
  if (overReact is YamlMap) {
    return PluginAnalysisOptions(
      errors: _parseErrors(overReact),
      exhaustiveDepsAdditionalHooksPattern: _parseExhaustiveDepsAdditionalHooksPattern(overReact),
    );
  }

  // If there is no `over_react` key in the yaml file, return null.
  return null;
}

RegExp? _parseExhaustiveDepsAdditionalHooksPattern(YamlMap overReact) {
  final dynamic exhaustiveDeps = overReact['exhaustive_deps'];
  if (exhaustiveDeps is! YamlMap) return null;

  final dynamic additionalHooks = exhaustiveDeps['additional_hooks'];
  if (additionalHooks is! String) return null;

  try {
    // This will throw if the regex is invalid.
    return RegExp(additionalHooks);
  } catch (_) {
    return null;
  }
}

Map<String, AnalysisOptionsSeverity> _parseErrors(YamlMap overReact) {
  final dynamic errors = overReact['errors'];
  if (errors is YamlMap) {
    return _yamlMapToDartMap(errors);
  }

  // If there is no `errors` key under the `over_react` key, an empty error map.
  return {};
}

Map<String, AnalysisOptionsSeverity> _yamlMapToDartMap(YamlMap errors) {
  final map = <String, AnalysisOptionsSeverity>{};

  for (final key in errors.keys) {
    if (key is String) {
      final dynamic value = errors[key];
      if (value is String) {
        final enumValue = _severityMap[value];
        if (enumValue != null) {
          map[key] = enumValue;
        }
      }
    }
  }

  return map;
}

const _severityMap = {
  'ignore': AnalysisOptionsSeverity.ignore,
  'info': AnalysisOptionsSeverity.info,
  'error': AnalysisOptionsSeverity.error,
  'warning': AnalysisOptionsSeverity.warning,
};
