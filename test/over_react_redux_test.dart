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

// Currently dart_dev only runs tests on dart files that end with _test.
// So this file's name had to change to match.
// It can be changed back when that issue is taken care of.
// https://github.com/Workiva/dart_dev/issues/74
@TestOn('browser')
library over_react_component_test;

import 'package:over_react/over_react.dart';
import 'package:react/react_client.dart';
import 'package:test/test.dart';

import './over_react_redux/connect_test.dart' as connect_test;
import './over_react_redux/connect_flux_test.dart' as connect_flux_test;
import './over_react_redux/connect_flux_integration_test.dart' as connect_flux_integration_test;
import './over_react_redux/redux_multi_provider_test.dart' as multi_provider_test;
import './over_react_redux/value_mutation_checker_test.dart' as value_mutation_checker_test;


void main() {
  setClientConfiguration();

  enableTestMode();
  connect_test.main();
  connect_flux_test.main();
  connect_flux_integration_test.main();
  multi_provider_test.main();
  value_mutation_checker_test.main();
}
