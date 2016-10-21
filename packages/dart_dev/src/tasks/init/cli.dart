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

library dart_dev.src.tasks.init.cli;

import 'dart:async';

import 'package:args/args.dart';

import 'package:dart_dev/src/tasks/init/api.dart';
import 'package:dart_dev/src/tasks/cli.dart';

class InitCli extends TaskCli {
  final ArgParser argParser = new ArgParser();

  final String command = 'init';

  Future<CliResult> run(ArgResults parsedArgs, {bool color: true}) async {
    InitTask task = init();
    await task.done;
    return task.successful
        ? new CliResult.success('dart_dev config initialized: tool/dev.dart')
        : new CliResult.fail('dart_dev config already exists!');
  }
}
