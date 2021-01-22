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
import 'package:redux/redux.dart';

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
///     final count = useSelector<int, CounterState>((state) => state.count);
///
///     return Dom.div()('The current count is $count');
///   },
///   $CounterConfig, // ignore: undefined_identifier
/// );
/// ```
///
/// > Related: [useDispatch]
TSelector useSelector<TSelector, TReduxState>(TSelector Function(TReduxState state) selector, [
  bool Function(TSelector tNextSelector, TSelector tPrevSelector) equalityFn,
]) {
  ReactInteropValue jsSelector(ReactInteropValue jsState) => wrapInteropValue(selector(unwrapInteropValue(jsState)));
  _JsReduxStateEqualityFn jsEqualityFn = equalityFn == null
      ? null
      : allowInterop((nextJsSelector, prevJsSelector) =>
          equalityFn(unwrapInteropValue(nextJsSelector), unwrapInteropValue(prevJsSelector)));

  return unwrapInteropValue<TSelector>(_jsUseSelector(allowInterop(jsSelector), jsEqualityFn));
}

@JS('ReactRedux.useSelector')
external ReactInteropValue _jsUseSelector(_JsSelectorFn selector, [_JsReduxStateEqualityFn equalityFn]);

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
/// final MyContext = createContext<Store<MyState>>();
/// final useMySelector = createSelectorHook(MyContext);
/// final myStore = Store(myReducer);
///
/// // ------------------------------------
/// //  2. (Optional) Create a custom
/// //  provider component that uses the
/// //  context defined above.
/// // ------------------------------------
/// mixin MyProviderProps = UiProps with ReduxProviderProps;
///
/// UiFactory<MyProviderProps> MyProvider = uiFunction(
///   (props) {
///     return (ReduxProvider()
///       ..addUnconsumedProps(props, const [])
///       ..context = MyContext
///       ..store = myStore
///     )(
///       props.children,
///     );
///   },
///   $MyProviderConfig, // ignore: undefined_identifier
/// );
///
/// // ------------------------------------
/// //  3. Create a function component that
/// //  uses `useMySelector`.
/// // ------------------------------------
/// mixin MyComponentProps on UiProps {}
///
/// UiFactory<MyComponentProps> MyComponent = uiFunction(
///   (props) {
///     final count = useMySelector((state) => state.count);
///
///     return Dom.div()('The current count is $count');
///   },
///   $MyComponentConfig, // ignore: undefined_identifier
/// );
///
/// // ------------------------------------
/// //  4. Render the function component
/// //  nested within the custom provider.
/// // ------------------------------------
/// main() {
///   final app = MyProvider()(
///     MyComponent()(),
///   );
///
///   react_dom.render(app, querySelector('#id_of_mount_node'));
/// }
/// ```
_SelectorFnHook<TReduxState> createSelectorHook<TReduxState>([Context<Store<TReduxState>> context]) {
  final jsHook = _jsCreateSelectorHook(context?.jsThis ?? JsReactRedux.ReactReduxContext);

  return <TSelector>(selector, [equalityFn]) {
    ReactInteropValue jsSelector(jsState) => wrapInteropValue(selector(unwrapInteropValue(jsState)));
    _JsReduxStateEqualityFn jsEqualityFn = equalityFn == null
        ? null
        : allowInterop((nextJsSelector, prevJsSelector) =>
            equalityFn(unwrapInteropValue(nextJsSelector), unwrapInteropValue(prevJsSelector)));

    return unwrapInteropValue<TSelector>(jsHook(allowInterop(jsSelector), jsEqualityFn));
  };
}

@JS('ReactRedux.createSelectorHook')
external _JsSelectorFnHook _jsCreateSelectorHook(ReactContext context);

// ----------------------------------------------------
//  Typedefs
// ----------------------------------------------------

typedef _JsSelectorFn = ReactInteropValue Function(ReactInteropValue jsState);
typedef _JsReduxStateEqualityFn = bool Function(ReactInteropValue nextJsSelector, ReactInteropValue prevJsSelector);
typedef _JsSelectorFnHook = ReactInteropValue Function(_JsSelectorFn selector, [_JsReduxStateEqualityFn equalityFn]);
typedef _SelectorFnHook<TReduxState> = TSelector Function<TSelector>(
  TSelector Function(TReduxState state) selector, [
  bool Function(TSelector tNextSelector, TSelector tPrevSelector) equalityFn,
]);
