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
  test('_ReactElementSafeEquality()', () {
    ReactElement vDomElementAsPropValue = PureTest()();
    ReactElement updatedVDomElementAsPropValue = (PureTest()..id = 'updated')();

    final _jacket = mount((PureTest()..someVDomEl = vDomElementAsPropValue)());

    // We're not particularly concerned with the equality here; we sort of
    // expect it to be wrong since it doesn't no real comparison of the
    // elements. We're mostly just concerned that it doesn't error when
    // passed a ReactElement.
    expect(() => _jacket.rerender((PureTest()..someVDomEl = updatedVDomElementAsPropValue)()), returnsNormally);
  });

  group('PureUiComponent', () {
    const initialChildren = ['initial'];
    const nextChildren = ['next'];
    TestJacket<PureTestWrapperComponent> jacket;
    UiFactory<SharedPureTestChildPropsMixin> childFactory;

    PureTestComponentMixin getChildPureComponent() => jacket.getDartInstance().pureComponentRef.current;

    PureTestWrapperProps wrapperBuilderWithInitialProps({
      UiFactory<SharedPureTestChildPropsMixin> customChildFactory,
      bool addVDomElToProps = false,
    }) {
      customChildFactory ??= childFactory;

      final builder = PureTestWrapper()..childFactory = customChildFactory;

      if (addVDomElToProps) {
        builder.someVDomEl = PureTest()();
      }

      return builder;
    }

    void doInitialRender({bool supportsPropChildren = true, bool addVDomElToProps = false}) {
      childFactory = supportsPropChildren
          ? PureTest
          : PureTestWithoutChildrenSupport;
      jacket = mount(wrapperBuilderWithInitialProps(addVDomElToProps: addVDomElToProps)(
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
      childFactory = null;
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
          jacket.rerender((wrapperBuilderWithInitialProps()..sharedBoolProp = !currentSharedBoolPropValue)(
            initialChildren,
          ));

          expect(jacket.getDartInstance().redrawCount, 1);
          expect(getChildPureComponent().redrawCount, 1);
        });

        test('unless the redraw results in a new prop with a ReactElement value being received', () {
          doInitialRender(addVDomElToProps: true);
          jacket.rerender((wrapperBuilderWithInitialProps()..someVDomEl = (PureTest()..id = 'updated')())(
            initialChildren,
          ));

          expect(jacket.getDartInstance().redrawCount, 1);
          expect(getChildPureComponent().redrawCount, 1);
        });

        test('unless the redraw results in new children being received', () {
          doInitialRender();
          jacket.rerender(wrapperBuilderWithInitialProps()(
            nextChildren,
          ));

          expect(jacket.getDartInstance().redrawCount, 1);
          expect(getChildPureComponent().redrawCount, 1);
        });

        test('even if the redraw results in new children being received when supportsPropChildren is false', () {
          doInitialRender(supportsPropChildren: false);
          jacket.rerender(wrapperBuilderWithInitialProps(customChildFactory: PureTestWithoutChildrenSupport)(
            nextChildren,
          ));

          expect(jacket.getDartInstance().redrawCount, 1);
          expect(getChildPureComponent().redrawCount, 0,
              reason: 'Components with supportsPropChildren overridden to false '
                  'should not redraw when the value of props.children updates');
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
