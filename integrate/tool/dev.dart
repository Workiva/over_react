// Copyright 2016 Workiva Inc.
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

library over_react.integrate.tool.dev;

import 'package:dart_dev/dart_dev.dart' show dev, config;

main(List<String> args) async {
  config.analyze
    ..strong = true
    ..fatalWarnings = true
    ..entryPoints = ['web/', 'lib/'];

  config.test
    ..pubServe = true
    ..platforms = [
      'content-shell'
    ]
    ..unitTests = [
      'test/test_runtime_import.dart',
    ];

  await dev(args);
}
