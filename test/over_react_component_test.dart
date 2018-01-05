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

import 'over_react/component/resize/resize_observer_test.dart' as internal_resize_observer_test;
import 'over_react/component/resize/resize_sensor_test.dart' as internal_resize_sensor_test;
import 'over_react/component/abstract_transition_test.dart' as abstract_transition_test;
import 'over_react/component/dom_components_test.dart' as dom_components_test;
import 'over_react/component/prop_mixins_test.dart' as prop_mixins_test;
import 'over_react/component/resize_sensor_test.dart' as resize_sensor_test;


void main() {
  setClientConfiguration();

  enableTestMode();

  internal_resize_observer_test.main();
  internal_resize_sensor_test.main();
  abstract_transition_test.main();
  dom_components_test.main();
  prop_mixins_test.main();
  resize_sensor_test.main();
}
