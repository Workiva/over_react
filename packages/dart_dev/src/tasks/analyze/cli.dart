// Copyright 2015 Workiva Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

library dart_dev.src.tasks.analyze.cli;

import 'dart:async';

import 'package:args/args.dart';

import 'package:dart_dev/util.dart' show reporter;

import 'package:dart_dev/src/tasks/analyze/api.dart';
import 'package:dart_dev/src/tasks/analyze/config.dart';
import 'package:dart_dev/src/tasks/cli.dart';
import 'package:dart_dev/src/tasks/config.dart';

class AnalyzeCli extends TaskCli {
  final ArgParser argParser = new ArgParser()
    ..addFlag('fatal-warnings',
        defaultsTo: defaultFatalWarnings,
        negatable: true,
        help: 'Treat non-type warnings as fatal.')
    ..addFlag('hints',
        defaultsTo: defaultHints, negatable: true, help: 'Show hint results.')
    ..addFlag('fatal-hints',
        defaultsTo: defaultFatalHints,
        negatable: true,
        help: 'Treat hints as fatal.')
    ..addFlag('strong',
        defaultsTo: defaultStrong,
        negatable: true,
        help: 'Enable strong static checks (https://goo.gl/DqcBsw)');

  final String command = 'analyze';

  Future<CliResult> run(ArgResults parsedArgs, {bool color: true}) async {
    List<String> entryPoints = config.analyze.entryPoints;
    bool fatalWarnings = TaskCli.valueOf(
        'fatal-warnings', parsedArgs, config.analyze.fatalWarnings);
    bool hints = TaskCli.valueOf('hints', parsedArgs, config.analyze.hints);
    bool fatalHints =
        TaskCli.valueOf('fatal-hints', parsedArgs, config.analyze.fatalHints);
    bool strong = TaskCli.valueOf('strong', parsedArgs, config.analyze.strong);

    if (!hints && fatalHints) {
      return new CliResult.fail('You must enable hints to fail on hints.');
    }

    AnalyzeTask task = analyze(
        entryPoints: entryPoints,
        fatalWarnings: fatalWarnings,
        hints: hints,
        fatalHints: fatalHints,
        strong: strong);
    var title = task.analyzerCommand;
    if (fatalHints) title += ' (treating hints as fatal)';

    reporter.logGroup(title, outputStream: task.analyzerOutput);
    await task.done;
    return task.successful
        ? new CliResult.success('Analysis completed.')
        : new CliResult.fail('Analysis failed.');
  }
}
