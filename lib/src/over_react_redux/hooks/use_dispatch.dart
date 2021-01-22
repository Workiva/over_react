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
library over_react_redux.hooks.use_dispatch;

import 'package:js/js.dart';
import 'package:over_react/src/over_react_redux/over_react_redux.dart';
import 'package:over_react/src/over_react_redux/hooks/use_selector.dart';
import 'package:over_react/src/util/context.dart';
import 'package:react/react_client/react_interop.dart' show ReactContext;
import 'package:redux/redux.dart';

// ----------------------------------------------------
//  useDispatch hook
// ----------------------------------------------------

/// This hook returns a reference to the Redux [Store.dispatch] function.
///
/// You may use it to dispatch actions as needed.
///
/// If you need to dispatch actions within a custom [Context], use [createDispatchHook] instead.
///
/// See the [react-redux JS documentation](https://react-redux.js.org/api/hooks#usedispatch) for more details.
///
/// ### Example
///
/// > This example assumes that your `Counter` component is rendered as the descendant of a [ReduxProvider] component
///   that is wired up to a Redux [Store] instance with a `CounterState` instance containing a field called `count`.
/// >
/// > It also assumes that you have two actions wired up to your reducer - `IncrementAction` and `DecrementAction`.
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
///     final dispatch = useDispatch();
///
///     return Dom.div()(
///       Dom.div()('The current count is $count'),
///       (Dom.button()
///         ..onClick = (_) {
///           dispatch(IncrementAction());
///         }
///       )('+'),
///       (Dom.button()
///         ..onClick = (_) {
///           dispatch(DecrementAction());
///         }
///       )('-'),
///     );
///   },
///   $CounterConfig, // ignore: undefined_identifier
/// );
/// ```
///
/// > Related: [useSelector]
dynamic Function(dynamic action) useDispatch() => _jsUseDispatch();

@JS('ReactRedux.useDispatch')
external dynamic Function(dynamic action) _jsUseDispatch();

// ----------------------------------------------------
//  createDispatchHook
// ----------------------------------------------------

/// Returns a function that can be named and used as a replacement for [useDispatch] when you want to
/// use custom [context].
///
/// This is useful if you're building a complex reusable component, and you don't want your [Store] to collide
/// with any Redux [Store] your consumers' applications might use.
///
/// See the [react-redux JS documentation](https://react-redux.js.org/api/hooks#custom-context) for more details.
///
/// See the [createSelectorHook] documentation for an example of creating / using custom context.
dynamic Function(dynamic action) Function() createDispatchHook<TReduxState>([Context<Store<TReduxState>> context]) {
  return _jsCreateDispatchHook(context?.jsThis ?? JsReactRedux.ReactReduxContext);
}

@JS('ReactRedux.createDispatchHook')
external dynamic Function(dynamic action) Function() _jsCreateDispatchHook(ReactContext context);
