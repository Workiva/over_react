import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:meta/meta.dart';

import 'dart2js_output/compile.dart';
import 'dart2js_output/dart2js_normalize.dart';
import 'dart2js_output/logging.dart';
import 'dart2js_output/source.dart' as source;

Future<void> main(List<String> args) async {
  final runner = CommandRunner(
      'benchmark-dart2js-output',
      'Runs various dart2js output benchmarks and comparisons.'
          ' Useful for debugging/validating how changes to over_react affect dart2js output.')
    ..addCommand(CompareSizeCommand())..addCommand(
        CompareCodeCommand())..addCommand(GetCodeCommand());

  await runner.run(args);
}

final _originMasterDep = jsonEncode({
  'git': {
    'url': Directory.current.uri.toString(),
    'ref': 'origin/HEAD',
  }
});
final _localPathDep = jsonEncode({
  'path': Directory.current.path,
});

abstract class BaseCommand extends Command {
  BaseCommand() {
    argParser.addFlag('verbose', defaultsTo: true, negatable: true);
  }

  @override
  @mustCallSuper
  void run() {
    initLogging(verbose: argResults!['verbose'] as bool);
  }
}

abstract class CompareCommand extends BaseCommand {
  CompareCommand() {
    argParser.addOption(
      'head',
      help: 'Head over_react dependency to compare to the base.'
          ' Defaults to the enclosing local working copy of over_react.',
      defaultsTo: _localPathDep,
    );
    argParser.addOption(
      'base',
      help: 'Base over_react dependency to compare against.'
          ' Defaults to origin/master.',
      defaultsTo: _originMasterDep,
    );
  }

  dynamic get _baseDep => jsonDecode(argResults!['base'] as String);

  dynamic get _headDep => jsonDecode(argResults!['head'] as String);
}

class CompareSizeCommand extends CompareCommand {
  @override
  String get description =>
      'Compares the optimized, minified size of dart2js output for a benchmark React component between two over_react versions.';

  @override
  String get name => 'compare-size';

  @override
  Future<void> run() async {
    super.run();
    final baseSize = getComponentAndUsageSize(overReactDep: _baseDep);
    final headSize = getComponentAndUsageSize(overReactDep: _headDep);
    print('Base size: ${await baseSize} bytes');
    print('Head size: ${await headSize} bytes');
    print('(Head size) - (base size):'
        ' ${(await headSize) - (await baseSize)} bytes');
  }
}

class CompareCodeCommand extends CompareCommand {
  @override
  String get name => 'compare-code';

  @override
  String get description =>
      'Compares the optimized, non-minified dart2js output for a benchmark React component between two over_react versions.'
          '\nOutputs in a Git diff format.'
          '\nCompiled code is normalized before comparison for better diffing.';

  @override
  Future<void> run() async {
    super.run();
    final diff = await compareCodeAcrossVersions(
      source.componentBenchmark(
        componentCount: 1,
        propsCount: 5,
      ),
      overReactDep1: _baseDep,
      overReactDep2: _headDep,
    );
    if (diff.trim().isEmpty) {
      print('(No difference in dart2js output between base and head)');
    } else {
      print(diff);
    }
  }
}

class GetCodeCommand extends BaseCommand {
  @override
  String get name => 'get-code';

  @override
  String get description =>
      'Displays the optimized, non-minified dart2js output for a benchmark React component.'
          '\nOutputs in a Git diff format, showing output changes when adding a component.'
          '\nCompiled code is normalized before comparison for better diffing.';

  GetCodeCommand() {
    argParser.addOption(
      'dependency',
      help: 'over_react dependency to compile with.'
          ' Defaults to the enclosing local working copy of over_react.',
      defaultsTo: _localPathDep,
    );
  }

  dynamic get _dep => jsonDecode(argResults!['dependency'] as String);

  @override
  Future<void> run() async {
    super.run();
    print(await getCompiledComponentCode(overReactDep: _dep));
  }
}

Future<String> compareCodeAcrossVersions(String code, {
  required dynamic overReactDep1,
  required dynamic overReactDep2,
}) async {
  final results1 = compileOverReactProgram(
    webFilesByName: {'main.dart': code},
    overReactDep: overReactDep1,
    minify: false,
  );
  final results2 = compileOverReactProgram(
    webFilesByName: {'main.dart': code},
    overReactDep: overReactDep2,
    minify: false,
  );

  return gitDiffNoIndex(
    createNormalizedDart2jsFile((await results1).getCompiledDart2jsFile()).path,
    createNormalizedDart2jsFile((await results2).getCompiledDart2jsFile()).path,
  );
}

Future<String> getCompiledComponentCode({
  dynamic overReactDep,
}) async {
  const baselineComponentCount = 2;
  const propsCount = 3;

  final result = await compileOverReactProgram(webFilesByName: {
    'baseline.dart': source.componentBenchmark(
      componentCount: baselineComponentCount,
      propsCount: propsCount,
    ),
    'additional.dart': source.componentBenchmark(
      componentCount: baselineComponentCount + 1,
      propsCount: propsCount,
    ),
  }, overReactDep: overReactDep, minify: false);

  final baselineCompiledFile = result.getCompiledDart2jsFile('baseline.dart');
  final additionalCompiledFile =
  result.getCompiledDart2jsFile('additional.dart');

  return gitDiffNoIndex(
    createNormalizedDart2jsFile(baselineCompiledFile).path,
    createNormalizedDart2jsFile(additionalCompiledFile).path,
  );
}

File createNormalizedDart2jsFile(File f) {
  return File(f.path + '.normalized.js')
    ..writeAsStringSync(normalizeDart2jsContents(f.readAsStringSync()));
}

Future<String> gitDiffNoIndex(
  String file1,
  String file2, {
  int contextLines = 1,
  bool color = false,
}) async {
  final result = await Process.run('git', [
    'diff',
    '--no-index',
    '-U$contextLines',
    if (color) '--color',
    file1,
    file2,
  ]);

  if (result.exitCode == 0 || result.exitCode == 1) {
    return result.stdout as String;
  }

  throw Exception(
      'Error diffing files. Exit code: ${result.exitCode} stderr: $stderr');
}

/// Gets the total size of a single test component, plus usage that sets all props,
/// and render that reads all props.
///
/// Since it contains this extra usage and render code, it's mainly useful when
/// comparing across versions, and shouldn't by itself be used as a number that
/// represents "the cost of declaring a component"."
Future<int> getComponentAndUsageSize({
  dynamic overReactDep,
}) async {
  const baselineComponentCount = 100;
  const propsCount = 5;

  final result = await compileOverReactProgram(webFilesByName: {
    'baseline.dart': source.componentBenchmark(
      componentCount: baselineComponentCount,
      propsCount: propsCount,
    ),
    'additional.dart': source.componentBenchmark(
      componentCount: baselineComponentCount + 1,
      propsCount: propsCount,
    ),
  }, overReactDep: overReactDep);

  final baselineFileSize =
      result
          .getCompiledDart2jsFile('baseline.dart')
          .statSync()
          .size;
  final additionalFileSize =
      result
          .getCompiledDart2jsFile('additional.dart')
          .statSync()
          .size;
  validateFileSize(baselineFileSize);
  validateFileSize(additionalFileSize);

  return additionalFileSize - baselineFileSize;
}

void validateFileSize(int actualSizeInBytes) {
  // Arbitrary minimum expected size to help ensure the test setup is correct.
  //
  // Value derived from the compiled size of the following Dart program:
  //     import 'package:over_react/over_react.dart';
  //     void main() { Dom.div()(); }
  const minimumExpectedSizeInBytes = 144339;

  if (actualSizeInBytes < minimumExpectedSizeInBytes) {
    throw Exception('Expected compiled size to be larger,'
        ' at least $minimumExpectedSizeInBytes bytes.'
        ' Was: $actualSizeInBytes bytes.');
  }
}
