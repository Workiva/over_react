library test_util.dom_util;

import 'dart:async';
import 'dart:html';

Future triggerTransitionEnd(Element element) {
  Future eventFiredFuture = element.onTransitionEnd.first;
  element.dispatchEvent(new CustomEvent('transitionend'));
  return eventFiredFuture;
}

void triggerDocumentClick(Element target) {
  // Ensure that the target is attached to the document.
  assert(document.documentElement.contains(target));

  target.dispatchEvent(new MouseEvent('click'));
}