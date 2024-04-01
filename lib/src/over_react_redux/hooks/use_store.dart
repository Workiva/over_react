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
library over_react_redux.hooks.use_store;

import 'package:js/js.dart';
import 'package:over_react/src/over_react_redux/over_react_redux.dart';
import 'package:over_react/src/over_react_redux/hooks/use_selector.dart';
import 'package:over_react/src/util/context.dart';
import 'package:react/react_client/react_interop.dart' show ReactContext;
import 'package:redux/redux.dart';

// ----------------------------------------------------
//  useStore hook
// ----------------------------------------------------

/// A hook that returns a reference to the same Redux [Store] that was passed in to the [ReduxProvider]
/// component that the function component using the hook is a descendant of.
///
/// This hook should probably not be used frequently. Prefer [useSelector] as your primary choice.
/// However, this may be useful for less common scenarios that do require access to the [Store],
/// such as replacing reducers.
///
/// If you need access to a specific store from a nested [ReduxProvider] with a custom [Context],
/// use [createStoreHook] instead.
///
/// See the [react-redux JS documentation](https://react-redux.js.org/api/hooks#usestore) for more details.
Store<TReduxState> useStore<TReduxState>() => _jsUseStore().dartStore as Store<TReduxState>;

@JS('ReactRedux.useStore')
external JsReactReduxStore _jsUseStore();

// ----------------------------------------------------
//  createStoreHook
// ----------------------------------------------------

/// Returns a function that can be named and used as a replacement for [useStore] when you want to
/// use custom [context].
///
/// This is useful if you're building a complex reusable component, and you don't want your [Store] to collide
/// with any Redux [Store] your consumers' applications might use.
///
/// This should probably not be used frequently. Prefer [createSelectorHook] as your primary choice.
/// However, this may be useful for less common scenarios that do require access to the [Store],
/// such as replacing reducers. __Using this hook will not result in the component updating when store values change!__
///
/// See the [react-redux JS documentation](https://react-redux.js.org/api/hooks#custom-context) for more details.
///
/// See the [createSelectorHook] documentation for an example of creating / using custom context.
Store<TReduxState> Function() createStoreHook<TReduxState>([Context? context]) {
  final jsHook = _jsCreateStoreHook(context?.jsThis ?? JsReactRedux.ReactReduxContext);
  Store<TReduxState> dartHook() => jsHook().dartStore as Store<TReduxState>;

  return dartHook;
}

@JS('ReactRedux.createStoreHook')
external JsReactReduxStore Function() _jsCreateStoreHook(ReactContext context);
