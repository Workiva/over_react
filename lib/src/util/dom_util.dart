library dom_util;

import 'dart:html';
import 'dart:js';

import 'js_util.dart';

/// Returns whether [root] is the same as or contains the [other] node.
///
/// Returns false if either [root] or [other] is null.
bool isOrContains(Element root, Element other) => (
  (root != null && other != null) &&
  (root == other || root.contains(other))
);

/// Returns the JS [HTMLFormElement](https://developer.mozilla.org/en-US/docs/Web/API/HTMLFormElement)
JsObject _getJsForm(FormElement form) => new JsObject.fromBrowserObject(form);

/// Returns a [List] of all of the form control [Element]s contained in a given [form].
///
/// Does not include `<input type="image">` controls.
///
/// __NOTE: Currently does not include Web Skin Dart custom components like [DropdownSelect].__
///
/// Wraps the [HTMLFormElement.elements](https://developer.mozilla.org/en-US/docs/Web/API/HTMLFormElement/elements) property.
List<Element> getFormElements(FormElement form) => convertToArray(_getJsForm(form)['elements']);

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
