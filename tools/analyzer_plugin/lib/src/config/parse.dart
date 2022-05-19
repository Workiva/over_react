import 'package:over_react_analyzer_plugin/src/config/config.dart';
import 'package:yaml/yaml.dart';

Config? processAnalysisOptionsFile(String fileContents) {
  final yaml = loadYamlNode(fileContents);
  if (yaml is YamlMap) {
    return _parseConfig(yaml);
  }

  return null;
}

Config? _parseConfig(YamlMap yaml) {
  final dynamic overReact = yaml['over_react'];
  if (overReact is YamlMap) {
    final errors = _parseErrors(overReact);
    return Config(errors);
  }

  return null;
}

Map<String, ConfigSeverity> _parseErrors(YamlMap overReact) {
  final dynamic errors = overReact['errors'];
  if (errors is YamlMap) {
    return _yamlMapToDartMap(errors);
  }
  return {};
}

Map<String, ConfigSeverity> _yamlMapToDartMap(YamlMap errors) {
  final map = <String, ConfigSeverity>{};

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
  'ignore': ConfigSeverity.ignore,
  'info': ConfigSeverity.info,
  'error': ConfigSeverity.error,
  'warning': ConfigSeverity.warning,
};
