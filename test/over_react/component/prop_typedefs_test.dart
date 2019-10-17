// Copyright 2019 Workiva Inc.
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

@TestOn('browser')
library prop_typedefs_test.dart;

import 'package:test/test.dart';
import 'package:over_react_test/over_react_test.dart';
import './fixtures/prop_typedef_fixtures.dart';

main() {
  // Regression tests for https://github.com/dart-lang/sdk/issues/38880
  group('CustomRenderFunction typedef', () {
    TestJacket jacket;

    tearDown(() {
      jacket = null;
    });

    void sharedTest() {
      final customRendererContainerNode =
          queryByTestId(jacket.getInstance(), 'customRendererContainer');
      expect(customRendererContainerNode, isNotNull, reason: 'test setup sanity check');
      final parameterizedCustomRendererContainerNode =
          queryByTestId(jacket.getInstance(), 'parameterizedCustomRendererContainer');
      expect(parameterizedCustomRendererContainerNode, isNotNull, reason: 'test setup sanity check');

      expect(customRendererContainerNode.text, 'props.somePropKey: foo \nprops.someStateKey: bar');
      expect(parameterizedCustomRendererContainerNode.text, 'props.somePropKey: foo \nprops.someStateKey: bar');
    }

    test('works as expected when the custom render prop is defined in a concrete class', () {
      jacket = mount((TestConsumingCustomRendererComponent()
        ..propKeyValueToTest = 'foo'
        ..stateKeyValueToTest = 'bar'
      )());
      sharedTest();
    });

    test('works as expected when the custom render prop is defined in an abstract class', () {
      jacket = mount((TestConsumingAbstractCustomRendererComponent()
        ..propKeyValueToTest = 'foo'
        ..stateKeyValueToTest = 'bar'
      )());
      sharedTest();
    });
  });
}
