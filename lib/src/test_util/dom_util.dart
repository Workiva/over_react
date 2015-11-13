library test_util.dom_util;

import 'dart:async';
import 'dart:html';

/// Dispatches a transitionEnd event.
///
/// Used for testing components that rely on a transitionEnd event.
Future triggerTransitionEnd(Element element) {
  Future eventFiredFuture = element.onTransitionEnd.first;
  element.dispatchEvent(new CustomEvent('transitionend'));
  return eventFiredFuture;
}

/// Dispatches a click event to the specified Element.
///
/// Verifies that the element is not a detached node.
void triggerDocumentClick(Element target) {
  assert(document.documentElement.contains(target) && 'Target should be attached to the document.' is String);

  target.dispatchEvent(new MouseEvent('click'));
}