import 'dart:io';

import 'package:glob/glob.dart';
import 'package:glob/list_local_fs.dart';
import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

final sourceFixtureDir = Directory('test_fixtures/test_packages/builder');
final goldsDir = Directory('test_fixtures/gold_output_files');

/// Updates gold files in [goldsDir] by re-generating them from a copy of the files in [sourceFixtureDir].
Future<void> main() async {
  final sourceFixturePubspec =
      loadYaml(File(p.join(sourceFixtureDir.path, 'pubspec.yaml')).readAsStringSync());
  final sourceFixturePackageName = sourceFixturePubspec['name'] as String;

  print('Building files in test fixture ${goldsDir.path}');

  print('Building files in ${sourceFixtureDir.path} to .dart_tool...');
  final buildProcess = await Process.start('dart', ['run', 'build_runner', 'build'],
      workingDirectory: sourceFixtureDir.path, mode: ProcessStartMode.inheritStdio);
  // Wait for build to complete.
  final buildExitCode = await buildProcess.exitCode;
  if (buildExitCode != 0) {
    stderr.writeln(
        '\n^ Build failures are expected for "missing_over_react_g_part" files, and can be ignored.\n');
  }

  print('Copying built files to golds directory ${goldsDir.path}');
  final outputPath = p.join(
      sourceFixtureDir.path, '.dart_tool', 'build', 'generated', sourceFixturePackageName, 'lib');
  late final generatedTmpFiles =
      Glob(p.join(outputPath, '**.over_react.g.dart')).listSync().whereType<File>().toList();
  if (!Directory(outputPath).existsSync() || generatedTmpFiles.isEmpty) {
    throw Exception(
        'No generated files were found in $outputPath; something is probably wrong with the paths in this script.');
  }
  for (final file in generatedTmpFiles) {
    final newPath = p.join(goldsDir.path, p.relative(file.path, from: outputPath)) + '.goldFile';
    File(newPath).parent.createSync(recursive: true);
    file.copySync(newPath);
  }

  print('Done!');
}
