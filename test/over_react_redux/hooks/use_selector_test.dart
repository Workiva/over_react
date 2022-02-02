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

import 'package:js/js.dart';
import 'package:meta/meta.dart';
import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';
import 'package:redux/redux.dart';
import 'package:test/test.dart';

import '../../test_util/test_util.dart';
import '../fixtures/counter_fn.dart';

class TestState<T> {
  final T interestingValue;
  final int otherValue;

  TestState({
    @required this.interestingValue,
    @required this.otherValue,
  });

  TestState<T> update({
    T interestingValue,
    int otherValue,
  }) =>
      TestState(
        interestingValue: interestingValue ?? this.interestingValue,
        otherValue: otherValue ?? this.otherValue,
      );
}

class UpdateInterestingAction {}

class UpdateOtherAction {}

class MyDartObject {
  final String name;

  MyDartObject(this.name);

  @override
  String toString() => 'MyDartObject($name)';
}

main() {
  group('useSelector hook', () {
    group('when selecting', () {
      sharedTests<String>(
        'a primitive value',
        initialValue: 'initial',
        updatedValue1: 'updated 1',
        updatedValue2: 'updated 2',
      );

      sharedTests<MyDartObject>(
        'a Dart object',
        initialValue: MyDartObject('initial'),
        updatedValue1: MyDartObject('updated 1'),
        updatedValue2: MyDartObject('updated 2'),
      );

      sharedTests<String Function()>(
        'a Dart function (which requires special interop wrapping)',
        initialValue: () => 'initial',
        updatedValue1: () => 'updated 1',
        updatedValue2: () => 'updated 2',
        renderValue: (function) => function(),
      );

      sharedTests<String Function()>(
        'an allowInteropped Dart function (which should bypass special interop wrapping)',
        initialValue: allowInterop(() => 'initial'),
        updatedValue1: allowInterop(() => 'updated 1'),
        updatedValue2: allowInterop(() => 'updated 2'),
        renderValue: (function) => function(),
      );
    });

    // group('subscribes to custom context when createSelectorHook is used and redraws when', () {
    //   group('the selector value is updated', () {
    //     test('', () async {
    //       jacket = mount(
    //           (ReduxProvider()..store = counterStore)(
    //             (ReduxProvider()
    //               ..store = bigCounterStore
    //               ..context = bigCounterContext
    //             )(
    //               CustomContextCounterFn()(),
    //               // Use a sibling connected component for dispatching actions in these tests
    //               // that shouldn't rely on `useDispatch` to ensure the subscription to context is wired up correctly
    //               (ConnectedBigCounter()..addTestId('big-sibling-counter'))(),
    //             ),
    //             // Use a sibling connected component for dispatching actions in these tests
    //             // that shouldn't rely on `useDispatch` to ensure the subscription to context is wired up correctly
    //             (ConnectedCounter()..addTestId('sibling-counter'))(),
    //           ), attachedToDocument: true);
    //
    //       expectBigCountValue(jacket, 9);
    //       await clickSiblingConnectedBigCountIncrementButton(jacket);
    //       expectBigCountValue(jacket, 109);
    //
    //       expectCountValue(jacket, 0);
    //       await clickSiblingConnectedIncrementButton(jacket);
    //       expectCountValue(jacket, 1);
    //     });
    //
    //     test('unless a custom equalityFn returns true', () async {
    //       jacket = mount(
    //           (ReduxProvider()..store = counterStore)(
    //             (ReduxProvider()
    //               ..store = bigCounterStore
    //               ..context = bigCounterContext
    //             )(
    //               (CustomContextCounterFn()..bigCountEqualityFn = (nextBigCount, prevBigCount) {
    //                 // Use 209 so that the equalityFn returns false once, and then returns true.
    //                 return nextBigCount == 209;
    //               })(),
    //               // Use a sibling connected component for dispatching actions in these tests
    //               // that shouldn't rely on `useDispatch` to ensure the subscription to context is wired up correctly
    //               (ConnectedBigCounter()..addTestId('big-sibling-counter'))(),
    //             ),
    //             // Use a sibling connected component for dispatching actions in these tests
    //             // that shouldn't rely on `useDispatch` to ensure the subscription to context is wired up correctly
    //             (ConnectedCounter()..addTestId('sibling-counter'))(),
    //           ), attachedToDocument: true);
    //
    //       expectBigCountValue(jacket, 9);
    //       await clickSiblingConnectedBigCountIncrementButton(jacket);
    //       expectBigCountValue(jacket, 109, reason: 'Component should update when equalityFn returns false');
    //       await clickSiblingConnectedBigCountIncrementButton(jacket);
    //       expectBigCountValue(jacket, 109, reason: 'Component should not update when equalityFn returns true');
    //
    //       expectCountValue(jacket, 0);
    //       await clickSiblingConnectedIncrementButton(jacket);
    //       expectCountValue(jacket, 1);
    //     });
    //   });
    // });
  });
}

Matcher hasAttrs(Map<String, dynamic> attrs) =>
    allOf(attrs.entries.map((e) => hasAttr(e.key, e.value)).toList());

Future<void> dispatchAndWait(Store store, dynamic action) async {
  final storeChangeFuture = store.onChange.first;
  store.dispatch(action);
  await storeChangeFuture.timeout(Duration(milliseconds: 100));
  await pumpEventQueue();
}

@isTestGroup
void sharedTests<T>(
  String name, {
  T initialValue,
  T updatedValue1,
  T updatedValue2,
  String Function(T) renderValue,
}) {
  renderValue ??= (value) => value.toString();

  group(name, () {
    setUpAll(() {
      if ([initialValue, updatedValue1, updatedValue2].map(renderValue).toSet().length != 3) {
        throw ArgumentError('Rendered initialValue/updatedValue values must be different.');
      }
    });

    TestJacket jacket;
    Store<TestState<T>> store;

    UiFactory TestUseSelector;

    setUp(() {
      store = Store((state, action) {
        if (action is UpdateInterestingAction) {
          switch (state.interestingValue) {
          }

          if (state.interestingValue == initialValue) {
            return state.update(interestingValue: updatedValue1);
          } else if (state.interestingValue == updatedValue1) {
            return state.update(interestingValue: updatedValue2);
          } else {
            throw StateError('Only expected at most two updates');
          }
        } else if (action is UpdateOtherAction) {
          return state.update(otherValue: state.otherValue + 1);
        } else {
          throw ArgumentError('Unexpected action');
        }
      },
          initialState: TestState(
            interestingValue: initialValue,
            otherValue: 0,
          ));

      TestUseSelector = uiFunction((props) {
        final renderCount = useRenderCount();
        final interestingValue = useSelector<TestState<T>, T>(
            (state) => state.interestingValue, props['equality'] as bool Function(T, T));
        return (Dom.div()
          ..addProp('data-render-count', renderCount)
          ..addProp('data-interesting-value', renderValue(interestingValue))
        )();
      }, UiFactoryConfig());
    });

    group('redraws a single time when the values updates in the store', () {
      test('', () async {
        jacket = mount(
            (ReduxProvider()..store = store)(
              TestUseSelector()(),
            ),
            attachedToDocument: true);
        final node = jacket.mountNode.children.single;

        expect(
            node,
            hasAttrs({
              'data-interesting-value': renderValue(initialValue),
              'data-render-count': '1',
            }));
        final storeCallsFinished = store.onChange.take(1).toList().then((value) => null);
        await dispatchAndWait(store, UpdateInterestingAction());
        await storeCallsFinished;
        expect(
            node,
            hasAttrs({
              'data-interesting-value': renderValue(updatedValue1),
              'data-render-count': '2',
            }));
      });

      test('unless a custom equalityFn returns true', () async {
        jacket = mount(
            (ReduxProvider()..store = store)(
              (TestUseSelector()
                ..addProp('equality', (T next, T prev) {
                  // Return true for the final state change to prevent updates.
                  if (next == updatedValue2) return true;

                  // Otherwise behave normally
                  return next == prev;
                })
              )(),
            ),
            attachedToDocument: true);
        final node = jacket.mountNode.children.single;

        expect(
            node,
            hasAttrs({
              'data-interesting-value': renderValue(initialValue),
              'data-render-count': '1',
            }));

        await dispatchAndWait(store, UpdateInterestingAction());
        expect(
            node,
            hasAttrs({
              'data-interesting-value': renderValue(updatedValue1),
              'data-render-count': '2',
            }),
            reason: 'should update when equalityFn returns false');

        await dispatchAndWait(store, UpdateInterestingAction());
        // Use equals here otherwise function values are treated as matcher functions by `expect`.
        expect(store.state.interestingValue, equals(updatedValue2), reason: 'test setup check');
        expect(
            node,
            hasAttrs({
              'data-interesting-value': renderValue(updatedValue1),
              'data-render-count': '2',
            }),
            reason: 'should not update when equalityFn returns true');
      });
    });

    test('does not redraw when the store triggers and the selected value is the same', () async {
      jacket = mount(
          (ReduxProvider()..store = store)(
            TestUseSelector()(),
          ),
          attachedToDocument: true);
      final node = jacket.mountNode.children.single;

      expect(
          node,
          hasAttrs({
            'data-interesting-value': renderValue(initialValue),
            'data-render-count': '1',
          }));

      await dispatchAndWait(store, UpdateOtherAction());
      expect(
          node,
          hasAttrs({
            'data-interesting-value': renderValue(initialValue),
            'data-render-count': '1',
          }));
    });
  });
}
