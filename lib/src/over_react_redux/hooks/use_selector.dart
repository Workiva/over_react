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

@JS()
library over_react_redux.hooks.use_selector;

import 'package:js/js.dart';
import 'package:over_react/src/over_react_redux/over_react_redux.dart';
import 'package:over_react/src/over_react_redux/hooks/use_dispatch.dart';
import 'package:over_react/src/util/context.dart';
import 'package:react/react_client/react_interop.dart' show ReactContext;

// ----------------------------------------------------
//  useSelector hook
// ----------------------------------------------------

/// A hook that allows you to extract data from the Redux `Store` state, using a [selector] function.
///
/// The use of this hook will also subscribe your component to the Redux `Store`, and run your [selector] whenever
/// an action is dispatched.
///
/// * The [selector] should be pure since it is potentially executed multiple times and at arbitrary points in time.
/// * The [selector] is approximately equivalent to the `mapStateToProps` argument of [connect] conceptually.
/// * The [selector] will be called with the entire Redux `Store` state as its only argument.
/// * The [selector] will be run whenever the function component renders.
///
/// By default, the return value of `selector` is compared using strict (`===`) equality. If you want to
/// customize how equality is defined, pass a comparator function to the [equalityFn] argument.
///
/// If you need to use a selector with custom [Context], use [createSelectorHook] instead.
///
/// See the [react-redux JS documentation](https://react-redux.js.org/api/hooks#useselector) for more details.
///
/// ### Example
///
/// > This example assumes that your `Counter` component is rendered as the descendant of a [ReduxProvider] component
///   that is wired up to a Redux `Store` instance with a `CounterState` instance containing a field called `count`.
///
/// ```dart
/// import 'package:over_react/over_react.dart';
/// import 'package:over_react/over_react_redux.dart';
/// import 'counter_state.dart';
///
/// mixin CounterProps on UiProps {}
///
/// UiFactory<CounterProps> Counter = uiFunction(
///   (props) {
///     final count = useSelector<CounterState, int>((state) => state.count);
///
///     return Dom.div()('The current count is $count');
///   },
///   $CounterConfig, // ignore: undefined_identifier
/// );
/// ```
///
/// ### Multiple Selectors
///
/// If you need to use multiple selectors in a single component, use [createSelectorHook] to
/// shadow `useSelector` as shown below to remove a bunch of unnecessary boilerplate as shown
/// in the example below.
///
/// Consider the previous example, but instead of only needing to access `count` from the store,
/// you need to access `count`, and two other field values as well. Using `useSelector` for all
/// of these can get a little messy:
///
/// ```dart
/// import 'package:over_react/over_react.dart';
/// import 'package:over_react/over_react_redux.dart';
/// import 'counter_state.dart';
///
/// mixin CounterProps on UiProps {}
///
/// UiFactory<CounterProps> Counter = uiFunction(
///   (props) {
///     final count = useSelector<CounterState, int>((state) => state.count);
///     final foo = useSelector<CounterState, String>((state) => state.foo);
///     final bar = useSelector<CounterState, Map>((state) => state.bar);
///
///     return Dom.div()('The current $foo count is $count. $bar my dude.');
///   },
///   $CounterConfig, // ignore: undefined_identifier
/// );
/// ```
///
/// Instead of needing to declare those generic parameters each time on `useSelector`, shadow it like so:
///
/// ```dart
/// import 'package:over_react/over_react.dart';
/// import 'package:over_react/over_react_redux.dart';
/// import 'counter_state.dart';
///
/// /// All the types for state fields within `CounterState` will be inferred!
/// final useSelector = createSelectorHook<CounterState>();
///
/// mixin CounterProps on UiProps {}
///
/// UiFactory<CounterProps> Counter = uiFunction(
///   (props) {
///     final count = useSelector((state) => state.count);
///     final foo = useSelector((state) => state.foo);
///     final bar = useSelector((state) => state.bar);
///
///     return Dom.div()('The current $foo count is $count. $bar my dude.');
///   },
///   $CounterConfig, // ignore: undefined_identifier
/// );
/// ```
///
/// > __CAUTION:__ Be sure to not export the shadowed value of `useSelector` unless you know exactly what you're doing,
///   and the consumers of your library expect the hook to always have the context of the state you
///   parameterize it with.
///
/// > Related: [useDispatch]
TValue useSelector<TReduxState, TValue>(TValue Function(TReduxState state) selector, [
  bool Function(TValue? tNextValue, TValue? tPrevValue)? equalityFn,
]) {
  ReactInteropValue jsSelector(ReactInteropValue jsState) => wrapInteropValue(selector(unwrapInteropValue(jsState) as TReduxState));
  _JsReduxStateEqualityFn? jsEqualityFn = equalityFn == null
      ? null
      : allowInterop((nextJsValue, prevJsValue) =>
          equalityFn(unwrapInteropValue(nextJsValue) as TValue?, unwrapInteropValue(prevJsValue) as TValue?));

  return unwrapInteropValue(_jsUseSelector(allowInterop(jsSelector), jsEqualityFn)) as TValue;
}

@JS('ReactRedux.useSelector')
external ReactInteropValue _jsUseSelector(_JsSelectorFn selector, [_JsReduxStateEqualityFn? equalityFn]);

// ----------------------------------------------------
//  createSelectorHook
// ----------------------------------------------------

/// Returns a function that can be named and used as a replacement for [useSelector] when you want to
/// use custom [context].
///
/// This is useful if you're building a complex reusable component, and you don't want your `Store` to collide
/// with any Redux `Store` your consumers' applications might use.
///
/// See the [react-redux JS documentation](https://react-redux.js.org/api/hooks#custom-context) for more details.
///
/// ### Custom Context Example
///
/// ```dart
/// import 'package:over_react/over_react.dart';
/// import 'package:over_react/over_react_redux.dart';
/// import 'package:redux/redux.dart';
///
/// // ------------------------------------
/// //  1. Declare the custom context
/// // ------------------------------------
/// final MyContext = createContext();
/// final useSelector = createSelectorHook<MyState>(MyContext);
/// final myStore = Store(myReducer);
///
/// // ------------------------------------
/// //  2. Create a function component that
/// //  uses the shadowed `useSelector`.
/// // ------------------------------------
/// mixin MyComponentProps on UiProps {}
///
/// UiFactory<MyComponentProps> MyComponent = uiFunction(
///   (props) {
///     final count = useSelector((state) => state.count);
///
///     return Dom.div()('The current count is $count');
///   },
///   $MyComponentConfig, // ignore: undefined_identifier
/// );
///
/// // ------------------------------------
/// //  3. Render the function component
/// //  nested within the ReduxProvider
/// //  that is wired up to the
/// //  custom context / store.
/// // ------------------------------------
/// main() {
///   final app = (ReduxProvider()
///     ..context = MyContext
///     ..store = myStore
///   )(
///     MyComponent()(),
///   );
///
///   react_dom.render(app, querySelector('#id_of_mount_node'));
/// }
/// ```
_SelectorFnHook<TReduxState> createSelectorHook<TReduxState>([Context? context]) {
  final jsHook = _jsCreateSelectorHook(context?.jsThis ?? JsReactRedux.ReactReduxContext);
  TValue dartHook<TValue>(TValue Function(TReduxState state) selector, [
    bool Function(TValue tNextValue, TValue tPrevValue)? equalityFn,
  ]) {
    ReactInteropValue jsSelector(ReactInteropValue jsState) => wrapInteropValue(selector(unwrapInteropValue(jsState) as TReduxState));
    _JsReduxStateEqualityFn? jsEqualityFn = equalityFn == null
        ? null
        : allowInterop((nextJsValue, prevJsValue) =>
            equalityFn(unwrapInteropValue(nextJsValue) as TValue, unwrapInteropValue(prevJsValue) as TValue));

    return unwrapInteropValue(jsHook(allowInterop(jsSelector), jsEqualityFn)) as TValue;
  }

  return dartHook;
}

@JS('ReactRedux.createSelectorHook')
external _JsSelectorFnHook _jsCreateSelectorHook(ReactContext context);

// ----------------------------------------------------
//  Typedefs
// ----------------------------------------------------

typedef _JsSelectorFn = ReactInteropValue Function(ReactInteropValue jsState);
typedef _JsReduxStateEqualityFn = bool Function(ReactInteropValue nextJsValue, ReactInteropValue prevJsValue);
typedef _JsSelectorFnHook = ReactInteropValue Function(_JsSelectorFn selector, [_JsReduxStateEqualityFn? equalityFn]);
typedef _SelectorFnHook<TReduxState> = TValue Function<TValue>(
  TValue Function(TReduxState state) selector, [
  bool Function(TValue tNextValue, TValue tPrevValue)? equalityFn,
]);
