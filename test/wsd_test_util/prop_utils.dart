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

// Tell dart2js that this library only needs to reflect types annotated with `Props`/`PropsMixin`.
// This speeds up compilation and makes JS output much smaller.
@MirrorsUsed(metaTargets: const [
  'over_react.component_declaration.annotations.Props',
  'over_react.component_declaration.annotations.PropsMixin',
])
import 'dart:mirrors';

import 'package:test/test.dart';

void testProp (Symbol name, dynamic expectedKey, instance, testValue) {
  InstanceMirror mirror = reflect(instance);

  mirror.setField(name, testValue);
  expect(instance[expectedKey], equals(testValue));
  expect(mirror.getField(name).reflectee, equals(testValue));
}

void testKeys (List<String> keys, dynamic instanceBuilder()) {
  test('cannot set / read values that are not its prop map', () {
    var instance = instanceBuilder();
    expect(() {instance['notThere'];}, throws);
  });
  for (var propKey in keys) {
    test('prop: $propKey can have its value set / read', () {
      var instance = instanceBuilder();
      testProp(new Symbol(propKey), propKey, instance, null);
    });
  }
}
