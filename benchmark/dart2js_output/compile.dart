import 'dart:convert';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;

final overReactPackageRoot = Directory.current;

Future<BuildResult> compileOverReactProgram({
  required Map<String, String> webFilesByName,
  dynamic overReactDep,
  bool minify = true,
}) async {
  overReactDep ??= {
    'path': overReactPackageRoot.path,
  };

  final logger = Logger('compileOverReactProgram');

  final tempPath = Directory.systemTemp.createTempSync().path;
  final packagePath = p.join(tempPath, 'package');
  final outputPath = p.join(tempPath, 'build_output');
  final packageDir = Directory(packagePath)..createSync();

  logger.fine('Creating temporary package: $packagePath');

  // YAML is a superset of JSON :)
  File(p.join(packagePath, 'pubspec.yaml')).writeAsStringSync(jsonEncode({
    'name': '_over_react_benchmark_test',
    'version': '0.0.0',
    'environment': {
      'sdk': '>=2.19.0 <4.0.0',
    },
    'dependencies': {'over_react': overReactDep},
    'dev_dependencies': {
      'build_runner': 'any',
      'build_web_compilers': 'any',
    }
  }));
  // YAML is a superset of JSON :)
  File(p.join(packagePath, 'build.yaml')).writeAsStringSync(jsonEncode({
    'targets': {
      r'$default': {
        'builders': {
          'build_web_compilers:entrypoint': {
            'release_options': {
              'dart2js_args': [
                '--csp',
                '-O3',
                if (minify) '--minify' else '--no-minify',
                '--verbose',
                '--dump-info=binary',
              ]
            }
          },
          // Need this to prevent dumped info from being output.
          // See: https://github.com/dart-lang/build/issues/1622
          'build_web_compilers:dart2js_archive_extractor': {
            'release_options': {'filter_outputs': false}
          }
        }
      }
    }
  }));

  final webPath = p.join(packagePath, 'web');
  webFilesByName.forEach((name, contentsTemplate) {
    final filePath = p.join(packagePath, 'web', name);
    final partFilename =
        p.basenameWithoutExtension(name) + '.over_react.g.dart';
    final contents = contentsTemplate.replaceAll('{{PART_PATH}}', partFilename);

    if (!p.isWithin(webPath, filePath)) {
      throw ArgumentError.value(
          name, 'Filename must be a relative path without any `..`.');
    }
    File(filePath)
      ..parent.createSync(recursive: true)
      ..writeAsStringSync(contents);
  });

  const dartExecutable = 'dart';

  logger.fine('Running pub get...');
  final pubGetResult = await Process.run(
    dartExecutable,
    ['pub', 'get'],
    workingDirectory: packagePath,
    runInShell: true,
  );
  if (pubGetResult.exitCode != 0) {
    throw Exception(
        'Unexpected `pub get` failure in temporary package: $packagePath\n'
        '${pubGetResult.infoForErrorMessage}');
  }

  logger.fine('Running build...');

  final buildResult = await Process.run(
    dartExecutable,
    [
      'pub',
      'run',
      'build_runner',
      'build',
      // Make sure to build in dart2js
      '--release',
      '--output',
      outputPath,
      'web'
    ],
    workingDirectory: packagePath,
    runInShell: true,
  );
  logger.fine('Build complete; output to: $outputPath');
  File(p.join(outputPath, 'build_output.log'))
    ..parent.createSync(recursive: true)
    ..writeAsStringSync(buildResult.stdout.toString());
  if (buildResult.exitCode != 0) {
    throw Exception(
        'Unexpected build failure in temporary package: $packagePath\n'
        '${buildResult.infoForErrorMessage}');
  }

  await packageDir.delete(recursive: true);
  logger.fine('Deleted temporary package.');

  return BuildResult(
    buildFolderPath: outputPath,
  );
}

extension on ProcessResult {
  String get infoForErrorMessage => 'Exit code: ${this.exitCode}.'
      '\nstdout:\n${this.stdout}'
      '\nstderr:\n${this.stderr}';
}

class BuildResult {
  final String buildFolderPath;

  BuildResult({
    required this.buildFolderPath,
  });
}

extension BuildResultUtils on BuildResult {
  File getCompiledDart2jsFile([String? dartFilename]) {
    final webFolder = Directory(p.join(buildFolderPath, 'web'));

    final File compiledFile;
    if (dartFilename != null) {
      compiledFile = File(p.join(webFolder.path, dartFilename + '.js'));
      if (!compiledFile.existsSync()) {
        throw Exception('Compiled file ${compiledFile.path} does not exist');
      }
    } else {
      final candidates = webFolder
          .listSync()
          .whereType<File>()
          .where((f) => f.path.endsWith('.dart.js'))
          .toList();
      if (candidates.length != 1) {
        throw Exception(
            'Expected a single dart2js output, but found ${candidates.length}:'
            '${candidates.map((c) => '\n- ${c.path}')}');
      }
      compiledFile = candidates.single;
    }

    return compiledFile;
  }
}
