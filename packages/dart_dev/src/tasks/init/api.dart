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

library dart_dev.src.tasks.init.api;

import 'dart:async';
import 'dart:io';

import 'package:dart_dev/src/tasks/task.dart';

const String _initialConfig = '''library tool.dev;

import 'package:dart_dev/dart_dev.dart' show dev, config;

main(List<String> args) async {
  // https://github.com/Workiva/dart_dev

  // Perform task configuration here as necessary.

  // Available task configurations:
  // config.analyze
  // config.copyLicense
  // config.coverage
  // config.docs
  // config.examples
  // config.format
  // config.test

  await dev(args);
}
''';

InitTask init() {
  InitTask task = new InitTask();

  File configFile = new File('tool/dev.dart');
  if (configFile.existsSync()) {
    task.successful = false;
    return task;
  }

  configFile.createSync(recursive: true);
  configFile.writeAsStringSync(_initialConfig);
  task.successful = true;

  return task;
}

class InitTask extends Task {
  final Future done = new Future.value();
  InitTask();
}
