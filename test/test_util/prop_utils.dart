// @dart=2.11
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
library test_util.prop_utils;

import 'package:over_react_test/over_react_test.dart';
import 'package:test/test.dart';

void testInvalidKey(dynamic Function() instanceBuilder) {
  test('cannot set / read values that are not its prop map', () {
    var instance = instanceBuilder();
    // ignore: unnecessary_statements
    expect(() {instance['notThere'];},
        throwsA(hasToStringValue(contains('Map does not contain this key'))));
  });
}
