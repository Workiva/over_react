// Copyright 2018 Workiva Inc.
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

/// Exposes a typed version of `react_dom.render` and `react_dom.unmountComponentAtNode`
/// from the [`react` package](https://pub.dartlang.org/packages/react) so that `over_react` consumers
/// do not have to declare a direct dependency on the `react` package in their `pubspec.yaml`.
///
/// This allows us to insulate our consumers from "breaking" internal changes in the `react` package.
///
/// > __It is strongly suggested that consumers namespace when importing this library to avoid
/// collisions when creating custom `UiComponent`s.__
///
///     import 'package:over_react/react_dom.dart' as react_dom;
///     import 'package:over_react/over_react.dart';
library over_react.react_dom;

import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:react/react_dom.dart' as react_dom
    show render, unmountComponentAtNode;

/// Renders the provided [element] into the DOM mounted in the provided [mountNode]
/// and returns a reference to it based on its type:
///
/// 1. Returns an [Element] if [element] is a DOM component _(e.g. [Dom.div])_.
/// 2. Returns a React `Component` if [element] is a composite component.
///
/// > __Throws__ if [element] or [mountNode] are `null`.
///
/// If the [element] was previously rendered into the [mountNode], this will perform an update on it and only
/// mutate the DOM as necessary to reflect the latest React component.
///
/// Use [unmountComponentAtNode] to unmount the instance.
///
/// > Proxies [react_dom.render].
dynamic render(ReactElement element, Element mountNode) {
  return react_dom.render(element, mountNode);
}

/// Removes a React `Component` from the DOM that was mounted via [render]
/// and cleans up its event handlers and state.
///
/// * Returns `false` if a `Component` was not mounted in the [mountNode].
/// * Returns `true` if a `Component` was mounted in the [mountNode].
///
/// > Proxies [react_dom.unmountComponentAtNode].
bool unmountComponentAtNode(Element mountNode) {
  return react_dom.unmountComponentAtNode(mountNode);
}
