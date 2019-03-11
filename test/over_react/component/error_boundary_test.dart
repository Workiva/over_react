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

@Timeout(const Duration(seconds: 2))
library error_boundary_test;

import 'package:over_react/over_react.dart';
import 'package:over_react_test/over_react_test.dart';
import 'package:test/test.dart';

void main() {
  group('ErrorBoundary', () {
    TestJacket<ErrorBoundaryComponent> jacket;
    ReactElement dummyChild;

    setUp(() {
      dummyChild = Dom.div()('hi there');
    });

    tearDown(() {
      jacket = null;
      dummyChild = null;
    });

    // TODO: Add tests that exercise the actual ReactJS 16 error lifecycle methods once implemented.

    test('initializes with the expected default prop values', () {
      jacket = mount(ErrorBoundary()(dummyChild));

      expect(() => ErrorBoundary(jacket.getProps()).fallbackUIRenderer(null, null), throwsUnimplementedError);
    });

    test('initializes with the expected initial state values', () {
      jacket = mount(ErrorBoundary()(dummyChild));

      expect(jacket.getDartInstance().state.hasError, isFalse);
    });

    group('renders', () {
      test('its child when `state.error` is false', () {
        jacket = mount(ErrorBoundary()(dummyChild));
        expect(jacket.getDartInstance().state.hasError, isFalse, reason: 'test setup sanity check');

        expect(jacket.getNode().text, 'hi there');
      });

      group('fallback UI when `state.error` is true', () {
        test('', () {
          jacket = mount(ErrorBoundary()(dummyChild));
          final component = jacket.getDartInstance();

          // Using throws for now since this is temporary, and the throwsUnimplementedError doesn't work here for some reason
          expect(() => component.setState(component.newState()..hasError = true), throws);
        });

        // TODO: Update this test to assert the error / component stack values passed to the callback once the actual ReactJS 16 error lifecycle methods are implemented.
        test('and props.fallbackUIRenderer is set', () {
          ReactElement _fallbackUIRenderer(_, __) {
            return Dom.h4()('Something super not awesome just happened.');
          }

          jacket = mount((ErrorBoundary()..fallbackUIRenderer = _fallbackUIRenderer)(dummyChild));
          final component = jacket.getDartInstance();
          component.setState(component.newState()..hasError = true);

          expect(jacket.getNode(), hasNodeName('H4'));
          expect(jacket.getNode().text, 'Something super not awesome just happened.');
        });
      });
    });

    group('throws a PropError when', () {
      test('more than one child is provided', () {
        expect(() => mount(ErrorBoundary()(dummyChild, dummyChild)),
            throwsPropError_Value([dummyChild, dummyChild], 'children'));
      });

      test('an invalid child is provided', () {
        expect(() => mount(ErrorBoundary()('oh hai')),
            throwsPropError_Value(['oh hai'], 'children'));
      });
    });
  });
}
