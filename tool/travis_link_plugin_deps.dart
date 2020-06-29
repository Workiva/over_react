import 'dart:io';

import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

import 'logging.dart';

final logger = Logger('add_over_react_override');

/// Script to add a standard over_react dependency override.
///
/// This is primarily used for CI to check against the most recent, unpublished changes to over_react.
void main(List<String> args) {
  initLogging(verbose: args.contains('--verbose'));

  final packageRoot = p.canonicalize(p.join(Platform.script.toFilePath(), '..', '..'));
  final pluginPubspec = File(p.join(packageRoot, 'pubspec.yaml'));
  final yamlDocument = getYamlFor(pluginPubspec);
  final yamlContents = yamlDocument.contents as YamlMap;

  if (yamlContents['dependency_overrides'] != null) {
    final dependencyOverrides = yamlContents['dependency_overrides'] as YamlMap;
    if (dependencyOverrides.containsKey('over_react') && dependencyOverrides.length == 1) {
      logger
          .info('Skipping writing dependency override for over_react as it is already overridden');
    } else {
      pluginPubspec.writeAsStringSync(pluginPubspec.readAsStringSync().replaceFirst(
            RegExp('^dependency_overrides:\n', multiLine: true),
            'dependency_overrides:\n  over_react:\n    path: ../../\n',
          ));
    }
  } else {
    pluginPubspec.openWrite(mode: FileMode.append)
      ..writeln('')
      ..writeln('dependency_overrides:')
      ..writeln('  over_react:')
      ..writeln('    path: ../..')
      ..close();
  }
}

YamlDocument getYamlFor(File pluginPubspec) {
  if (!pluginPubspec.existsSync()) {
    throw Exception('pubspec.yaml does not exist in package root');
  }

  String name;
  YamlDocument pubspecYaml;
  try {
    final pubspecContents = pluginPubspec.readAsStringSync();
    pubspecYaml = loadYamlDocument(pubspecContents);
    name = (pubspecYaml.contents as YamlMap)['name'] as String;
  } on FileSystemException catch (_) {
    logger.severe('Error reading plugin pubspec.');
    rethrow;
  } catch (_) {
    logger.severe('Error parsing plugin pubspec yaml.');
    rethrow;
  }

  const expectedName = 'over_react_analyzer_plugin';
  if (name != expectedName) {
    throw Exception('Package name was $name; expected $expectedName');
  }

  return pubspecYaml;
}
