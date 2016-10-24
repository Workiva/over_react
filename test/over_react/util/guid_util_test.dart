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

library guid_util_test;

import 'package:over_react/over_react.dart';
import 'package:test/test.dart';

/// Main entry point for Guid Util testing
main() {
  group('generateGuid returns a string with correct length', () {
    test('by default', () {
      var guid = generateGuid();

      expect(guid.length, 4);
    });

    test('when length is set', () {
      var guid = generateGuid(10);

      expect(guid.length, 10);
    });
  });
}
