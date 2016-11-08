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

library dart_dev.src.tasks.gen_test_runner.config;

import 'package:dart_dev/src/tasks/config.dart';

const bool defaultCheck = false;
const List<String> defaultDartHeaders = const [];
const List<String> defaultPreTestCommands = const [];
const String defaultDirectory = 'test/';
const Environment defaultEnv = Environment.browser;
const String defaultFilename = 'generated_runner';
const bool defaultGenHtml = false;
const bool defaultReact = true;
const List<String> defaultHtmlHeaders = const [];

enum Environment { vm, browser }

class TestRunnerConfig {
  bool check = defaultCheck;
  List<String> dartHeaders = defaultDartHeaders;
  List<String> preTestCommands = defaultPreTestCommands;
  String directory = defaultDirectory;
  Environment env = defaultEnv;
  String filename = defaultFilename;
  bool genHtml = defaultGenHtml;
  List<String> htmlHeaders = defaultHtmlHeaders;

  TestRunnerConfig(
      {List<String> this.dartHeaders: defaultDartHeaders,
      List<String> this.preTestCommands: defaultPreTestCommands,
      String this.directory: defaultDirectory,
      Environment this.env: defaultEnv,
      String this.filename: defaultFilename,
      bool this.genHtml: defaultGenHtml,
      List<String> this.htmlHeaders: defaultHtmlHeaders});
}

class GenTestRunnerConfig extends TaskConfig {
  List<TestRunnerConfig> configs = [new TestRunnerConfig()];
}
