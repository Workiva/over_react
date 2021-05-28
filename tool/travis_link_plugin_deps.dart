import 'dart:io';

import 'package:io/ansi.dart' as ansi;
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

final logger = Logger('travis_link_plugin_deps');

/// Updates over_react dependencies in the analyzer plugin for CI:
///
/// - to allow resolution during release PRs
/// - to ensure the plugin pulls in the latest over_react changes it may be depending on,
///   allowing analysis and tests to run as expected
void main(List<String> args) {
  initLogging(verbose: args.contains('--verbose'));

  final pluginPubspec = File(p.join('tools/analyzer_plugin/pubspec.yaml'));
  final pluginPubspecYaml = getAndValidateAnalyzerPubspecYaml(pluginPubspec).contents as YamlMap;
  final pluginPubspecString = pluginPubspec.readAsStringSync();

  logger.info('Replacing over_react dependency with `any` in case'
      ' existing version is unreleased (which will be the case for release PRs).');
  pluginPubspec.writeAsStringSync(pluginPubspecString.replaceSingle(
    RegExp(r'^  over_react: .+$', multiLine: true),
    '  over_react: any',
  ));

  logger.info('Adding dependency_override to point to local version of over_react.');
  if (pluginPubspecYaml['dependency_overrides'] != null) {
    final dependencyOverrides = pluginPubspecYaml['dependency_overrides'] as YamlMap;
    if (dependencyOverrides.containsKey('over_react') && dependencyOverrides.length == 1) {
      logger
          .info('Skipping writing dependency override for over_react as it is already overridden');
    } else {
      pluginPubspec.writeAsStringSync(pluginPubspecString.replaceSingle(
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

extension on String {
  /// Like [String.replaceFirst], but throws unless there is exactly one match.
  ///
  /// Useful when you don't want your replacement to fail silently when there is no match,
  /// and when you want to ensure there are no unexpected matches that could cause unexpected
  /// behavior down the line.
  String replaceSingle(Pattern pattern, String replacement) {
    final matches = pattern.allMatches(this);
    if (matches.length != 1) {
      throw StateError('Expected a single match. Found: ${matches.length}');
    }
    return replaceFirst(pattern, replacement);
  }
}

YamlDocument getAndValidateAnalyzerPubspecYaml(File pluginPubspec) {
  if (!pluginPubspec.existsSync()) {
    throw Exception('pubspec.yaml does not exist in package root');
  }

  String? name;
  YamlDocument pubspecYaml;
  try {
    final pubspecContents = pluginPubspec.readAsStringSync();
    pubspecYaml = loadYamlDocument(pubspecContents);
    name = (pubspecYaml.contents as YamlMap)['name'] as String?;
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

void initLogging({bool verbose = true}) {
  Logger.root.level = verbose ? Level.ALL : Level.INFO;
  Logger.root.onRecord.listen((rec) {
    String Function(String) colorizer;
    IOSink output;

    if (rec.level >= Level.SEVERE) {
      colorizer = ansi.red.wrap;
      output = stderr;
    } else if (rec.level >= Level.WARNING) {
      colorizer = ansi.yellow.wrap;
      output = stderr;
    } else {
      colorizer = (string) => string;
      output = stdout;
    }

    if (rec.message != '') {
      output.writeln(colorizer(rec.message));
    }
    if (rec.error != null) {
      output.writeln(colorizer(rec.error.toString()));
    }
    if (verbose && rec.stackTrace != null) {
      output.writeln(colorizer(rec.stackTrace.toString()));
    }
  });
}
