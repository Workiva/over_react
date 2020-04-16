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

library debugger_constant_utils;

import 'package:over_react/over_react.dart';
import 'package:test/test.dart';

/// Common tests that verify the values of `degbugDescription`s of [DebugFriendlyConstant]s.
void sharedDebugConstTest(String constName, Map<DebugFriendlyConstant, String> constToDebugDesc) {
  group(constName, () {
    constToDebugDesc.forEach((key, value) {
      test('has the correct debugDescription for $key', () {
        expect(key.debugDescription, value);
      });
    });
  });
}
