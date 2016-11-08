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

library dart_dev.src.tasks.examples.cli;

import 'dart:async';

import 'package:args/args.dart';

import 'package:dart_dev/util.dart' show reporter;

import 'package:dart_dev/src/tasks/examples/api.dart';
import 'package:dart_dev/src/tasks/examples/config.dart';
import 'package:dart_dev/src/tasks/cli.dart';
import 'package:dart_dev/src/tasks/config.dart';

class ExamplesCli extends TaskCli {
  final ArgParser argParser = new ArgParser()
    ..addOption('hostname',
        defaultsTo: defaultHostname, help: 'The host name to listen on.')
    ..addOption('port',
        defaultsTo: defaultPort.toString(),
        help: 'The base port to listen on.');

  final String command = 'examples';

  Future<CliResult> run(ArgResults parsedArgs, {bool color: true}) async {
    String hostname =
        TaskCli.valueOf('hostname', parsedArgs, config.examples.hostname);
    var port = TaskCli.valueOf('port', parsedArgs, config.examples.port);
    if (port is String) {
      port = int.parse(port);
    }

    if (!hasExamples())
      return new CliResult.fail('This project does not have any examples.');

    ExamplesTask task = serveExamples(hostname: hostname, port: port);
    reporter.logGroup(task.pubServeCommand,
        outputStream: task.pubServeStdOut, errorStream: task.pubServeStdErr);
    await task.done;
    reporter.logGroup(task.dartiumCommand, outputStream: task.dartiumOutput);
    return task.successful ? new CliResult.success() : new CliResult.fail();
  }
}
