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

library dart_dev.src.tasks.cli;

import 'dart:async';

import 'package:args/args.dart';

class CliResult {
  final String message;
  final bool successful;
  CliResult.success([String this.message = '']) : successful = true;
  CliResult.fail([String this.message = '']) : successful = false;
}

abstract class TaskCli {
  static valueOf(String arg, ArgResults parsedArgs, dynamic fallback) =>
      parsedArgs.wasParsed(arg) ? parsedArgs[arg] : fallback;

  ArgParser get argParser;
  String get command;

  Future<CliResult> run(ArgResults parsedArgs, {bool color: true});
}
