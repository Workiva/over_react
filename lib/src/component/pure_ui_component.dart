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

import 'package:over_react/over_react.dart';

/// A mixin to make a [UiComponent2] instance behave
/// like a [ReactJS `PureComponent`](https://reactjs.org/docs/react-api.html#reactpurecomponent).
///
/// The value of `props.children` is not compared deeply by default, and any `ReactElement`s found within
/// `props.children` are compared using [identical] _(analogous to `===` in JS)_ via [propsOrStateMapsEqual].
///
/// If you want to optimize updates that are being caused by children, you can override [shouldComponentUpdate]
/// with some custom logic _(see example below)_, or use memoization to prevent new `ReactElement` creation at
/// your component's consumption-site - which will allow them to be seen as [identical] in the
/// default [shouldComponentUpdate] implementation.
///
/// __Custom children equality check example:__
///
/// ```dart
/// class YourComponent extends UiComponent2<YourProps> with PureUiComponent<YourProps> {
///   @override
///   bool shouldComponentUpdate(Map nextProps, Map nextState) {
///     final currentPropsWithoutChildren = Map.of(this.props)..remove('children');
///     final nextPropsWithoutChildren = Map.of(nextProps)..remove('children');
///
///     return !propsOrStateMapsEqual(currentPropsWithoutChildren, nextPropsWithoutChildren)
///         || !propsOrStateMapsEqual(state, nextState)
///         || !const ListEquality().equals(this.props['children'], nextProps['children']);
///   }
/// }
/// ```
mixin PureUiComponent<T extends UiProps> on UiComponent2<T> {
  @override
  bool shouldComponentUpdate(Map nextProps, Map nextState) {
    return !propsOrStateMapsEqual(props, nextProps) || !propsOrStateMapsEqual(state, nextState);
  }
}
