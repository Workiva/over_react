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

library dart_dev.src.tasks.test.config;

import 'package:dart_dev/src/tasks/config.dart';

const int defaultConcurrency = 4;
const bool defaultPubServe = false;
const int defaultPubServePort = 0;
const bool defaultIntegration = false;
const bool defaultFunctional = false;
const List<String> defaultIntegrationTests = const [];
const bool defaultUnit = true;
const List<String> defaultUnitTests = const ['test/'];
const List<String> defaultFunctionalTests = const [];
const List<String> defaultPlatforms = const [];

class TestConfig extends TaskConfig {
  int concurrency = defaultConcurrency;
  List<String> functionalTests = defaultFunctionalTests;
  List<String> integrationTests = defaultIntegrationTests;
  List<String> platforms = defaultPlatforms;
  bool pubServe = defaultPubServe;
  int pubServePort = defaultPubServePort;
  List<String> unitTests = defaultUnitTests;
}
