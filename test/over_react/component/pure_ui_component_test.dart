// Copyright 2020 Workiva Inc.
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
library pure_ui_component_test;

import 'package:over_react/over_react.dart';

import 'package:over_react_test/over_react_test.dart';
import 'package:test/test.dart';

import './fixtures/pure_test_components.dart';
import '../../test_util/test_util.dart';

/// Main entry point for `PureUiComponent` testing
main() {
  group('PureUiComponent', () {
    const initialChildren = ['initial'];
    const nextChildren = ['next'];
    TestJacket<PureTestWrapperComponent> jacket;

    PureTestComponent getChildPureComponent() => jacket.getDartInstance().pureComponentRef.current;

    void doInitialRender({bool supportsPropChildren = true, bool addVDomElToProps = false}) {
      jacket = mount(PureTestWrapper()(
        initialChildren,
      ));
      final pureDartComponent = getChildPureComponent();

      expect(pureDartComponent, isNotNull, reason: 'test setup sanity check');
      expect(pureDartComponent.props.children, initialChildren, reason: 'test setup sanity check');
      expect(pureDartComponent.props.childFuncProp, isA<Function>(),
        reason: 'A prop value should be present on the pure component set to a function '
            'so we can assert that functions that are not anonymous closures do not cause '
            'redraws every time `shouldComponentUpdate` is called.');
      expect(pureDartComponent.redrawCount, 0, reason: 'test setup sanity check');
      expect(jacket.getDartInstance().redrawCount, 0, reason: 'test setup sanity check');
    }

    tearDown(() {
      jacket = null;
    });

    group('prevents component updates', () {
      group('when a parent component redraws', () {
        test('', () {
          doInitialRender();
          jacket.getDartInstance().forceUpdate();

          expect(jacket.getDartInstance().redrawCount, 1);
          expect(getChildPureComponent().redrawCount, 0);
        });

        test('unless the redraw results in new props being received', () {
          doInitialRender();
          final currentSharedBoolPropValue = jacket.getDartInstance().props.sharedBoolProp;
          jacket.rerender((PureTestWrapper()..sharedBoolProp = !currentSharedBoolPropValue)(
            initialChildren,
          ));

          expect(jacket.getDartInstance().redrawCount, 1);
          expect(getChildPureComponent().redrawCount, 1);
        });

        test('unless the redraw results in a new prop with a ReactElement value being received', () {
          doInitialRender(addVDomElToProps: true);
          jacket.rerender((PureTestWrapper()..someVDomEl = (PureTest()..id = 'updated')())(
            initialChildren,
          ));

          expect(jacket.getDartInstance().redrawCount, 1);
          expect(getChildPureComponent().redrawCount, 1);
        });

        test('unless the redraw results in new children being received', () {
          doInitialRender();
          jacket.rerender(PureTestWrapper()(
            nextChildren,
          ));

          expect(jacket.getDartInstance().redrawCount, 1);
          expect(getChildPureComponent().redrawCount, 1);
        });
      });
    });

    group('allows internal component updates', () {
      setUp(doInitialRender);

      test('when forceUpdate() is called', () {
        final pureComponent = getChildPureComponent();
        pureComponent.forceUpdate();

        expect(pureComponent.redrawCount, 1);
      });

      group('when setState() is called', () {
        test('with an updated internal state value', () {
          final pureComponent = getChildPureComponent();
          pureComponent.setState(pureComponent.newState()..childBoolState = !pureComponent.state.childBoolState);

          expect(pureComponent.redrawCount, 1);
        });

        test('unless it is called with a null value', () {
          final pureComponent = getChildPureComponent();
          pureComponent.setState(null);

          expect(pureComponent.redrawCount, 0);
        });

        test('unless it is called with an empty map', () {
          final pureComponent = getChildPureComponent();
          pureComponent.setState(pureComponent.newState());

          expect(pureComponent.redrawCount, 0);
        });
      });
    });
  });
}
