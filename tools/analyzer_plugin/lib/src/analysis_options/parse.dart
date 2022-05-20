import 'package:over_react_analyzer_plugin/src/analysis_options/plugin_analysis_options.dart';
import 'package:yaml/yaml.dart';

/// Parses the given yaml and returns over react analyzer plugin configuration options.
PluginAnalysisOptions? processAnalysisOptionsFile(String fileContents) {
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
    final errors = _parseErrors(overReact);
    return PluginAnalysisOptions(errors: errors);
  }

  // If there is no `over_react` key in the yaml file, return null.
  return null;
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
