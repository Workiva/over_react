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

library dart_dev;

export 'package:dart_dev/src/dart_dev_cli.dart' show registerTask, dev;
export 'package:dart_dev/src/tasks/config.dart' show config, TaskConfig;
export 'package:dart_dev/src/tasks/cli.dart' show CliResult, TaskCli;
export 'package:dart_dev/src/tasks/gen_test_runner/config.dart'
    show TestRunnerConfig, Environment;
export 'package:dart_dev/src/tasks/saucelabs/platforms.dart';
export 'package:dart_dev/src/tasks/task.dart' show Task;
