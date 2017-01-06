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

library test_mode_test;

import 'package:over_react/src/component_declaration/component_base.dart' as component_base;
import 'package:over_react/src/util/test_mode.dart';
import 'package:test/test.dart';

/// Main entry point for enableTestMode and disabledTestMode testing
main() {
  test('enableTestMode and disableTestMode set UiProps.testMode as expected', () {
    disableTestMode();

    expect(component_base.UiProps.testMode, isFalse);

    enableTestMode();

    expect(component_base.UiProps.testMode, isTrue);
  });
}
