// Copyright 2025 Workiva Inc.
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
import 'dart:html';

import 'package:over_react/src/component/dom_components.dart';
import 'package:react/react_client.dart' show ReactNode;
import 'package:react/react_dom.dart' as react_dom show render, unmountComponentAtNode;

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
dynamic render(ReactNode element, Element mountNode) {
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
  return react_dom.unmountComponentAtNode(mountNode) as bool;
}
