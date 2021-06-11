// Copyright 2021 Workiva Inc.
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

import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';
import 'package:redux/redux.dart';
import 'package:test/test.dart';

import '../../test_util/test_util.dart';
import '../fixtures/counter.dart';
import '../fixtures/counter_fn.dart';
import '../fixtures/store.dart';

import 'utils.dart';

main() {
  group('useSelector hook', () {
    UiFactory<CounterProps> ConnectedCounter;
    UiFactory<CounterProps> ConnectedBigCounter;
    TestJacket jacket;
    Store<CounterState> counterStore;
    Store<BigCounterState> bigCounterStore;

    setUp(() {
      jacket = null;

      counterStore = Store(counterStateReducer, initialState: CounterState());
      bigCounterStore = Store(bigCounterStateReducer, initialState: BigCounterState(bigCount: 9));
      ConnectedCounter = connect<CounterState, CounterProps>()(Counter);
      ConnectedBigCounter = connect<BigCounterState, CounterProps>(context: bigCounterContext)(Counter);
    });

    group('subscribes to the store and redraws when', () {
      group('a selector with a primitive value is updated', () {
        test('', () async {
          jacket = mount(
            (ReduxProvider()..store = counterStore)(
              CounterFn()(),
              // Use a sibling connected component for dispatching actions in these tests
              // that shouldn't rely on `useDispatch` to ensure the subscription to context is wired up correctly
              (ConnectedCounter()..addTestId('sibling-counter'))(),
            ), attachedToDocument: true);

          expectCountValue(jacket, 0);
          await clickSiblingConnectedIncrementButton(jacket);
          expectCountValue(jacket, 1);
        });

        test('unless a custom equalityFn returns true', () async {
          jacket = mount(
            (ReduxProvider()..store = counterStore)(
              (CounterFn()..countEqualityFn = (nextCount, prevCount) {
                // Use 2 so that the equalityFn returns false once, and then returns true.
                return nextCount == 2;
              })(),
              // Use a sibling connected component for dispatching actions in these tests
              // that shouldn't rely on `useDispatch` to ensure the subscription to context is wired up correctly
              (ConnectedCounter()..addTestId('sibling-counter'))(),
            ), attachedToDocument: true);

          expectCountValue(jacket, 0);
          await clickSiblingConnectedIncrementButton(jacket);
          expectCountValue(jacket, 1, reason: 'Component should update when equalityFn returns false');
          await clickSiblingConnectedIncrementButton(jacket);
          expectCountValue(jacket, 1, reason: 'Component should not update when equalityFn returns true');
        });
      });

      // Exercise js interop wrapping / unwrapping of dart types
      group('a selector with a Dart value is updated', () {
        void expectModelCountValue(TestJacket jacket, int expectedValue, {String reason}) {
          expect(queryByTestId(jacket.mountNode, 'count-from-model').text, 'Model Count: $expectedValue',
              reason: reason);
        }

        test('', () async {
          jacket = mount(
            (ReduxProvider()..store = counterStore)(
              ModelCounterFn()(),
              // Use a sibling connected component for dispatching actions in these tests
              // that shouldn't rely on `useDispatch` to ensure the subscription to context is wired up correctly
              (ConnectedCounter()..addTestId('sibling-counter'))(),
            ), attachedToDocument: true);

          expectModelCountValue(jacket, 0);
          await clickSiblingConnectedModelCountIncrementButton(jacket);
          expectModelCountValue(jacket, 1);
        });

        test('unless a custom equalityFn returns true', () async {
          jacket = mount(
            (ReduxProvider()..store = counterStore)(
              (ModelCounterFn()..modelCountEqualityFn = (nextModel, prevModel) {
                // Use 2 so that the equalityFn returns false once, and then returns true.
                return nextModel.count == 2;
              })(),
              // Use a sibling connected component for dispatching actions in these tests
              // that shouldn't rely on `useDispatch` to ensure the subscription to context is wired up correctly
              (ConnectedCounter()..addTestId('sibling-counter'))(),
            ), attachedToDocument: true);

          expectModelCountValue(jacket, 0);
          await clickSiblingConnectedModelCountIncrementButton(jacket);
          expectModelCountValue(jacket, 1, reason: 'Component should update when equalityFn returns false');
          await clickSiblingConnectedModelCountIncrementButton(jacket);
          expectModelCountValue(jacket, 1, reason: 'Component should not update when equalityFn returns true');
        });
      });
    });

    group('subscribes to custom context when createSelectorHook is used and redraws when', () {
      group('the selector value is updated', () {
        test('', () async {
          jacket = mount(
              (ReduxProvider()..store = counterStore)(
                (ReduxProvider()
                  ..store = bigCounterStore
                  ..context = bigCounterContext
                )(
                  CustomContextCounterFn()(),
                  // Use a sibling connected component for dispatching actions in these tests
                  // that shouldn't rely on `useDispatch` to ensure the subscription to context is wired up correctly
                  (ConnectedBigCounter()..addTestId('big-sibling-counter'))(),
                ),
                // Use a sibling connected component for dispatching actions in these tests
                // that shouldn't rely on `useDispatch` to ensure the subscription to context is wired up correctly
                (ConnectedCounter()..addTestId('sibling-counter'))(),
              ), attachedToDocument: true);

          expectBigCountValue(jacket, 9);
          await clickSiblingConnectedBigCountIncrementButton(jacket);
          expectBigCountValue(jacket, 109);

          expectCountValue(jacket, 0);
          await clickSiblingConnectedIncrementButton(jacket);
          expectCountValue(jacket, 1);
        });

        test('unless a custom equalityFn returns true', () async {
          jacket = mount(
              (ReduxProvider()..store = counterStore)(
                (ReduxProvider()
                  ..store = bigCounterStore
                  ..context = bigCounterContext
                )(
                  (CustomContextCounterFn()..bigCountEqualityFn = (nextBigCount, prevBigCount) {
                    // Use 209 so that the equalityFn returns false once, and then returns true.
                    return nextBigCount == 209;
                  })(),
                  // Use a sibling connected component for dispatching actions in these tests
                  // that shouldn't rely on `useDispatch` to ensure the subscription to context is wired up correctly
                  (ConnectedBigCounter()..addTestId('big-sibling-counter'))(),
                ),
                // Use a sibling connected component for dispatching actions in these tests
                // that shouldn't rely on `useDispatch` to ensure the subscription to context is wired up correctly
                (ConnectedCounter()..addTestId('sibling-counter'))(),
              ), attachedToDocument: true);

          expectBigCountValue(jacket, 9);
          await clickSiblingConnectedBigCountIncrementButton(jacket);
          expectBigCountValue(jacket, 109, reason: 'Component should update when equalityFn returns false');
          await clickSiblingConnectedBigCountIncrementButton(jacket);
          expectBigCountValue(jacket, 109, reason: 'Component should not update when equalityFn returns true');

          expectCountValue(jacket, 0);
          await clickSiblingConnectedIncrementButton(jacket);
          expectCountValue(jacket, 1);
        });
      });
    });
  });
}
