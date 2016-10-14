// Copyright 2016 Workiva Inc.
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

library dom_util;

import 'dart:html';

/// Returns whether [root] is the same as or contains the [other] node.
///
/// Returns false if either [root] or [other] is null.
bool isOrContains(Element root, Element other) => (
  (root != null && other != null) &&
  (root == other || root.contains(other))
);

/// Returns an Iterable of [element] and all its ancestors, in ascending order.
Iterable<Element> _hierarchy(Element element) sync* {
  var current = element;
  do {
    yield current;
  } while ((current = current.parent) != null);
}

/// Returns the closest element in the hierarchy of [lowerBound] up to an optional [upperBound] (both inclusive)
/// that matches [selector], or `null if no matches are found.
Element closest(Element lowerBound, String selector, {Element upperBound}) {
  for (var element in _hierarchy(lowerBound)) {
    if (element.matches(selector)) return element;
    if (upperBound != null && upperBound == element) break;
  }

  return null;
}

/// Returns the currently focused element, or `null` if there is none.
Element getActiveElement() {
  var activeElement = document.activeElement;

  if (activeElement is! Element || activeElement == document.body) return null;

  return activeElement;
}
