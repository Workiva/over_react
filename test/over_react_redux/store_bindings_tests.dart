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

import '../test_util/test_util.dart';
import 'utils.dart';

part 'store_bindings_tests.over_react.g.dart';

/// Tests around selector hooks and connect that verify that
/// - state values of different types are passed to components properly
/// - components rerender when selected values change
/// - components don't rerender when selected values don't change
void main() {
  group('React Redux store bindings -', () {
    group('when selecting', () {
      sharedSelectorHookAndConnectTests<String>(
        'a primitive value',
        initialValue: 'initial',
        updatedValue1: 'updated 1',
        updatedValue2: 'updated 2',
      );

      sharedSelectorHookAndConnectTests<dynamic>(
        'a primitive value including null',
        initialValue: null,
        updatedValue1: 'updated 1',
        updatedValue2: 'updated 2',
      );

      sharedSelectorHookAndConnectTests<MyDartObject>(
        'a Dart object',
        initialValue: MyDartObject('initial'),
        updatedValue1: MyDartObject('updated 1'),
        updatedValue2: MyDartObject('updated 2'),
      );

      sharedSelectorHookAndConnectTests<Map>(
        'a Dart Map (which shouldn\'t get converted to a JS Map)',
        initialValue: {'initial': 'value'},
        updatedValue1: {'updated 1': 'value'},
        updatedValue2: {'updated 2': 'value'},
      );

      sharedSelectorHookAndConnectTests<String Function()>(
        'a Dart function (which requires special interop wrapping)',
        initialValue: () => 'initial',
        updatedValue1: () => 'updated 1',
        updatedValue2: () => 'updated 2',
        renderValue: (function) => function(),
      );

      sharedSelectorHookAndConnectTests<String Function()>(
        'an allowInteropped Dart function (which should bypass special interop wrapping)',
        initialValue: allowInterop(() => 'initial'),
        updatedValue1: allowInterop(() => 'updated 1'),
        updatedValue2: allowInterop(() => 'updated 2'),
        renderValue: (function) => function(),
      );
    });
  });
}

Matcher hasAttrs(Map<String, dynamic> attrs) =>
    allOf(attrs.entries.map((e) => hasAttr(e.key, e.value)).toList());

@isTestGroup
void sharedSelectorHookAndConnectTests<T>(
  String name, {
  @required T initialValue,
  @required T updatedValue1,
  @required T updatedValue2,
  String Function(T) renderValue,
}) {
  renderValue ??= (value) => value.toString();

  group(name, () {
    setUpAll(() {
      final allValues = [initialValue, updatedValue1, updatedValue2];
      if (allValues.toSet().length != allValues.length) {
        throw ArgumentError('initialValue and updatedValues must all be unique.');
      }
      if (allValues.map(renderValue).toSet().length != allValues.length) {
        throw ArgumentError('Rendered initialValue and updatedValues values must all be unique.');
      }
    });

    Store<TestState<T>> store;

    setUp(() {
      store = Store((state, action) {
        if (action is UpdateInterestingAction) {
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
      }, initialState: TestState(interestingValue: initialValue, otherValue: 0));
    });

    void sharedTests(
      UiFactory<TestSelectorProps> factory, {
      Context context,
      bool supportsEqualityFunction = true,
    }) {
      test('properly selects the value without converting it whatsoever', () {
        final selectedValuesFromRender = [];
        mount((ReduxProvider()
          ..store = store
          ..context = context
        )(
          (factory()..onRender = selectedValuesFromRender.add)(),
        ));
        expect(selectedValuesFromRender, [same(initialValue)]);
      });

      group('redraws a single time when the values updates in the store', () {
        test('', () async {
          final jacket = mount((ReduxProvider()
            ..store = store
            ..context = context
          )(
            factory()(),
          ));
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

        if (supportsEqualityFunction) {
          test('and calls a custom equalityFn with the correct arguments', () async {
            final calls = [];
            mount((ReduxProvider()
              ..store = store
              ..context = context
            )(
              (factory()
                ..equality = (next, prev) {
                  calls.add({'next': next, 'prev': prev});
                  // Mimic default behavior
                  return identical(next, prev);
                }
              )(),
            ));
            await dispatchAndWait(store, UpdateInterestingAction());
            // Use contains instead of expecting the exact number of calls,
            // since React Redux isn't guaranteed to call the equality function exactly once,
            // and that behavior may change slightly from version to version.
            expect(
                calls,
                contains(equals({
                  'next': same(updatedValue1),
                  'prev': same(initialValue),
                })),
                reason: 'should have been called with the next and previous values, properly unwrapped');
          });

          test('unless a custom equalityFn returns true', () async {
            final jacket = mount((ReduxProvider()
              ..store = store
              ..context = context
            )(
              (factory()
                ..equality = (next, prev) {
                  // Return true for the final state change to prevent updates.
                  if (next == updatedValue2) return true;
                  // Otherwise, mimic default behavior.
                  return identical(next, prev);
                }
              )(),
            ));
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
        }
      });

      test('does not redraw when the store triggers and the selected value is the same', () async {
        final jacket = mount((ReduxProvider()
          ..store = store
          ..context = context
        )(
          factory()(),
        ));
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
    }

    group('useSelector', () {
      final TestUseSelector = uiFunction<TestSelectorProps>((props) {
        final renderCount = useRenderCount();
        final interestingValue =
            useSelector<TestState<T>, T>((state) => state.interestingValue, props.equality);
        props.onRender?.call(interestingValue);
        return (Dom.div()
          ..addProp('data-render-count', renderCount)
          ..addProp('data-interesting-value', renderValue(interestingValue))
        )();
      }, _$TestSelectorConfig); // ignore: undefined_identifier

      sharedTests(TestUseSelector);
    });

    group('createSelector', () {
      group('(default context)', () {
        final _useCustomSelector = createSelectorHook<TestState<T>>();
        final TestCreateSelector = uiFunction<TestSelectorProps>((props) {
          final renderCount = useRenderCount();
          final interestingValue =
              _useCustomSelector((state) => state.interestingValue, props.equality);
          props.onRender?.call(interestingValue);
          return (Dom.div()
            ..addProp('data-render-count', renderCount)
            ..addProp('data-interesting-value', renderValue(interestingValue))
          )();
        }, _$TestSelectorConfig); // ignore: undefined_identifier

        sharedTests(TestCreateSelector);
      });

      group('(custom context)', () {
        final context = createContext();
        final _useCustomSelector = createSelectorHook<TestState<T>>(context);
        final TestCreateSelector = uiFunction<TestSelectorProps>((props) {
          final renderCount = useRenderCount();
          final interestingValue =
              _useCustomSelector((state) => state.interestingValue, props.equality);
          props.onRender?.call(interestingValue);
          return (Dom.div()
            ..addProp('data-render-count', renderCount)
            ..addProp('data-interesting-value', renderValue(interestingValue))
          )();
        }, _$TestSelectorConfig); // ignore: undefined_identifier

        sharedTests(TestCreateSelector, context: context);
      });
    });

    // This is in place mainly to test rerender behavior; additional test coverage exists in connect_test.dart.
    group('connect', () {
      group('(default context)', () {
        final TestConnect = connect<TestState<T>, TestConnectProps>(
          mapStateToProps: ((state) => TestConnectMapView()
            ..interestingValue = state.interestingValue
          ),
        )(uiFunction((props) {
          final renderCount = useRenderCount();
          final interestingValue = props.interestingValue as T;
          props.onRender?.call(interestingValue);
          return (Dom.div()
            ..addProp('data-render-count', renderCount)
            ..addProp('data-interesting-value', renderValue(interestingValue))
          )();
        }, _$TestConnectMapViewConfig)); // ignore: undefined_identifier

        sharedTests(TestConnect, supportsEqualityFunction: false);
      });

      group('(custom context)', () {
        final context = createContext();
        final TestConnect = connect<TestState<T>, TestConnectProps>(
          context: context,
          mapStateToProps: ((state) => TestConnectMapView()
            ..interestingValue = state.interestingValue
          ),
        )(uiFunction((props) {
          final renderCount = useRenderCount();
          final interestingValue = props.interestingValue as T;
          props.onRender?.call(interestingValue);
          return (Dom.div()
            ..addProp('data-render-count', renderCount)
            ..addProp('data-interesting-value', renderValue(interestingValue))
          )();
        }, _$TestConnectMapViewConfig)); // ignore: undefined_identifier

        sharedTests(TestConnect, context: context, supportsEqualityFunction: false);
      });
    });
  });
}

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

/// Updates [TestState.interestingValue].
class UpdateInterestingAction {}

/// Updates [TestState.otherValue].
class UpdateOtherAction {}

class MyDartObject {
  final String name;

  MyDartObject(this.name);

  @override
  String toString() => 'MyDartObject($name)';
}

// We need this to generate _$TestSelectorConfig for use in non-top-level components.
UiFactory<TestSelectorProps> TestSelector = uiFunction((_) {}, _$TestSelectorConfig); // ignore: undefined_identifier

mixin TestSelectorProps on UiProps {
  void Function(Object selectedValue) onRender;
  bool Function(dynamic next, dynamic prev) equality;
}

// We also need this to generate _$TestConnectConfig for use in non-top-level components.
UiFactory<TestConnectProps> TestConnectMapView =
    uiFunction((_) {}, _$TestConnectMapViewConfig); // ignore: undefined_identifier

class TestConnectProps = UiProps with TestSelectorProps, TestConnectPropsMixin;

mixin TestConnectPropsMixin on UiProps {
  Object interestingValue;
}

/// A hook that returns a count of calls to a function component's render, specific to that instance.
///
/// The result of the first call is `1`.
int useRenderCount() {
  final count = useRef(0);
  count.current++;
  return count.current;
}
