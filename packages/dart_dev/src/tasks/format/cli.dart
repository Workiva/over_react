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

library dart_dev.src.tasks.format.cli;

import 'dart:async';

import 'package:args/args.dart';

import 'package:dart_dev/util.dart' show reporter;

import 'package:dart_dev/src/platform_util/api.dart' as platform_util;
import 'package:dart_dev/src/tasks/format/api.dart';
import 'package:dart_dev/src/tasks/format/config.dart';
import 'package:dart_dev/src/tasks/cli.dart';
import 'package:dart_dev/src/tasks/config.dart';

class FormatCli extends TaskCli {
  final ArgParser argParser = new ArgParser()
    ..addFlag('check',
        defaultsTo: defaultCheck,
        negatable: false,
        help:
            'Dry-run; checks if formatter needs to be run and sets exit code accordingly.')
    ..addOption('line-length',
        abbr: 'l', defaultsTo: '80', help: 'Wrap lines longer than this.');

  final String command = 'format';

  Future<CliResult> run(ArgResults parsedArgs, {bool color: true}) async {
    try {
      if (!platform_util.hasImmediateDependency('dart_style'))
        return new CliResult.fail(
            'Package "dart_style" must be an immediate dependency in order to run its executables.');
    } catch (e) {
      // It's possible that this check may throw if the pubspec.yaml
      // could not be found or if the yaml could not be parsed.
      // We silence this error and let the task continue in case it
      // was a false negative. If it was accurate, then the task will
      // fail anyway and the error will be available in the output.
    }

    bool check = TaskCli.valueOf('check', parsedArgs, config.format.check);
    List<String> directories = config.format.directories;
    List<String> exclude = config.format.exclude;
    var lineLength =
        TaskCli.valueOf('line-length', parsedArgs, config.format.lineLength);
    if (lineLength is String) {
      lineLength = int.parse(lineLength);
    }

    FormatTask task = format(
        check: check,
        directories: directories,
        exclude: exclude,
        lineLength: lineLength);
    reporter.logGroup(task.formatterCommand,
        outputStream: task.formatterOutput);
    await task.done;

    String excludedFilesWarning = '';
    if (task.excludedFiles.isNotEmpty) {
      excludedFilesWarning = 'WARNING - These files were excluded:\n    ';
      excludedFilesWarning += task.excludedFiles.join('\n    ');
      excludedFilesWarning += '\n\n';
    }

    if (task.isDryRun) {
      if (task.successful)
        return new CliResult.success(
            excludedFilesWarning + 'Your Dart code is good to go!');
      if (task.affectedFiles.isEmpty)
        return new CliResult.fail(
            excludedFilesWarning + 'The Dart formatter needs to be run.');
      return new CliResult.fail(excludedFilesWarning +
          'The Dart formatter needs to be run. The following files require changes:\n    ' +
          task.affectedFiles.join('\n    '));
    } else {
      if (!task.successful) return new CliResult.fail('Dart formatter failed.');
      if (task.affectedFiles.isEmpty)
        return new CliResult.success(excludedFilesWarning +
            'Success! All files are already formatted correctly.');
      return new CliResult.success(excludedFilesWarning +
          'Success! The following files were formatted:\n    ' +
          task.affectedFiles.join('\n    '));
    }
  }
}
