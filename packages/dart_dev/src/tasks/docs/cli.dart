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

library dart_dev.src.tasks.docs.cli;

import 'dart:async';
import 'dart:io';

import 'package:args/args.dart';
import 'package:dart_dev/util.dart' show hasImmediateDependency, reporter;
import 'package:path/path.dart' as path;

import 'package:dart_dev/src/tasks/cli.dart';
import 'package:dart_dev/src/tasks/docs/api.dart';

class DocsCli extends TaskCli {
  ArgParser argParser = new ArgParser()
    ..addFlag('open',
        defaultsTo: true, help: 'Opens the docs site after being generated.');

  final String command = 'docs';

  Future<CliResult> run(ArgResults parsedArgs, {bool color: true}) async {
    if (!hasImmediateDependency('dartdoc'))
      return new CliResult.fail(
          'Package "dartdoc" must be an immediate dependency in order to run its executables.');

    bool open = TaskCli.valueOf('open', parsedArgs, true);

    DocsResult result;
    try {
      DocsTask task = await DocsTask.start();
      reporter.logGroup(task.pubCommand,
          outputStream: task.output, errorStream: task.errorOutput);
      result = await task.done;
    } on DocsFailure catch (e) {
      return new CliResult.fail('$e');
    } catch (e, stackTrace) {
      return new CliResult.fail('$e\n$stackTrace');
    }
    if (open) {
      await Process.run('open', [path.join(result.output.path, 'index.html')]);
    }
    return new CliResult.success(
        'Documentation generated: ${result.output.path}');
  }
}
