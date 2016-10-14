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

library prop_error_test;

import 'package:over_react/over_react.dart';
import 'package:test/test.dart';

import '../../test_util/test_util.dart';

/// Main entrypoint for PropError testing
main() {
  group('PropError\'s', () {
    test('default constructor throws a PropError with correct message', () {
      expect(() => throw new PropError('Prop Name', 'Custom Message'), throwsPropError('Prop Name', 'Custom Message'));
    });

    test('`required` named constructor throws a PropError with correct message', () {
      expect(() => throw new PropError.required('Prop Name', 'Custom Message'),
          throwsPropError_Required('Prop Name', 'Custom Message')
      );
    });

    test('`value` named constructor throws a PropError with correct message', () {
      expect(() => throw new PropError.value('Invalid Value', 'Prop Name', 'Custom Message'),
          throwsPropError_Value('Invalid Value', 'Prop Name', 'Custom Message')
      );
    });

    test('`combination` named constructor throws a PropError with correct message', () {
      expect(() => throw new PropError.combination('Prop Name', 'Prop 2 Name', 'Custom Message'),
          throwsPropError_Combination('Prop Name', 'Prop 2 Name', 'Custom Message')
      );
    });
  });
}
