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

import 'package:react/react.dart' as react show Component2;
import 'package:over_react/src/util/equality.dart';

/// A mixin to make a [react.Component2] instance behave
/// like a [ReactJS `PureComponent`](https://reactjs.org/docs/react-api.html#reactpurecomponent).
///
/// The value of `props.children` is not compared deeply by default. Any time a new `ReactElement`
/// for this component is created, a new `props.children` list is created, unless `props.children` is empty.
///
/// If you want to optimize updates caused by `props.children`, you can:
///
/// 1. Update your component to not accept `props.children`.
/// 2. Recommend that consumers of your component memoize the creation of their
///   list of children and pass that in as shown in the example below:
///
/// ```dart
/// import 'package:memoize/memoize.dart';
///
/// final getMemoizedChildren = imemo1((items) => items.map((item) {
///   return (Child()
///     ..key = item.id
///     ..item = item
///   )();
/// }).toList());
///
/// render() {
///   return YourPureComponentFactory()(
///     getMemoizedChildren(props.items),
///   )
/// }
/// ```
mixin PureComponentMixin on react.Component2 {
  @override
  bool shouldComponentUpdate(Map nextProps, Map nextState) {
    return !propsOrStateMapsEqual(props, nextProps) || !propsOrStateMapsEqual(state, nextState);
  }
}
