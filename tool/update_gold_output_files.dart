import 'dart:io';

import 'package:glob/glob.dart';
import 'package:glob/list_local_fs.dart';
import 'package:path/path.dart' as p;

final sourceFixturesDir = Directory('test_fixtures/source_files');
final goldsDir = Directory('test_fixtures/gold_output_files');

/// A temporary directory used to generate new golds.
final tmpSourceDir = Directory('test/tmp_test_files');

/// Updates gold files in [goldsDir] by re-generating them from a copy of the files in [sourceFixturesDir].
Future<void> main() async {
  print('Copying files from ${sourceFixturesDir.path} to temporary directory ${tmpSourceDir.path}');
  if (tmpSourceDir.existsSync()) tmpSourceDir.deleteSync(recursive: true);
  tmpSourceDir.createSync(recursive: true);
  for (final file in Glob(p.join(sourceFixturesDir.path, '**')).listSync().whereType<File>()) {
    final newPath = p.join(tmpSourceDir.path, p.relative(file.path, from: sourceFixturesDir.path));
    File(newPath).parent.createSync(recursive: true);
    file.copySync(newPath);
  }

  print('Building files in temporary directory ${tmpSourceDir.path}');
  final buildProcess = await Process.start(
      'dart', ['run', 'build_runner', 'build', '--build-filter=${p.join(tmpSourceDir.path, '**')}'],
      mode: ProcessStartMode.inheritStdio);
  // Wait for build to complete.
  final buildExitCode = await buildProcess.exitCode;
  if (buildExitCode != 0) {
    stderr.writeln(
        '^ Build failures are expected for "missing_over_react_g_part" files, and can be ignored.');
  }

  print('Copying built files to golds directory ${goldsDir.path}');
  final generatedTmpFiles =
      Glob(p.join(tmpSourceDir.path, '**.over_react.g.dart')).listSync().whereType<File>().toList();
  if (generatedTmpFiles.isEmpty) {
    throw Exception('No generated files were found in ${tmpSourceDir.path}.'
        ' Ensure in build.yaml the over_react builder runs on directory with build_to:source');
  }
  for (final file in generatedTmpFiles) {
    final newPath =
        p.join(goldsDir.path, p.relative(file.path, from: tmpSourceDir.path)) + '.goldFile';
    File(newPath).parent.createSync(recursive: true);
    file.copySync(newPath);
  }

  print('Cleaning up temporary directory ${tmpSourceDir.path}');
  tmpSourceDir.deleteSync(recursive: true);

  print('Done!');

  print('\nIf non-gold generated files throughout this package got deleted'
      ' (which usually only happens after it prompts you about conflicting outputs),'
      ' you can restore them by running a build:\n\n'
      '    dart run build_runner build');
}
