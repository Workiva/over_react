library test_util.dom_util;

import 'dart:async';
import 'dart:html';

/// Dispatches a `transitionend` event when the CSS transition of the [element]
/// is complete. Returns a [Future] that completes after the event has been dispatched.
///
/// Used for testing components that rely on a `transitionend` event.
Future triggerTransitionEnd(Element element) {
  Future eventFiredFuture = element.onTransitionEnd.first;
  element.dispatchEvent(new CustomEvent('transitionend'));
  return eventFiredFuture;
}

/// Dispatches a `click` event to the specified [target].
///
/// Verifies that the [target] element is not a detached node.
void triggerDocumentClick(Element target) {
  if (!document.documentElement.contains(target)) {
    throw new ArgumentError.value(target, 'target', 'Target should be attached to the document.');
  }

  target.dispatchEvent(new MouseEvent('click'));
}
