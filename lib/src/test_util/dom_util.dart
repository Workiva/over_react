library test_util.dom_util;

import 'dart:async';
import 'dart:html';
import 'dart:js';

/// Dispatches a `transitionend` event when the CSS transition of the [element]
/// is complete. Returns a [Future] that completes after the event has been dispatched.
///
/// Used for testing components that rely on a `transitionend` event.
Future triggerTransitionEnd(Element element) {
  Future eventFiredFuture = element.onTransitionEnd.first;

  // Use JS interop to construct a native TransitionEvent since Dart doesn't allow instantiating them directly.
  // TODO: move this to JS so we can use TransitionEvent constructor

  var jsElement = new JsObject.fromBrowserObject(element);
  var jsDocument = new JsObject.fromBrowserObject(document);

  var jsEvent;
  try {
    // Dartium requires it actually to be a `TransitionEvent`, not `Event`.
    jsEvent = new JsObject.fromBrowserObject(jsDocument.callMethod('createEvent', ['TransitionEvent']));
  } catch (_) {
    // Firefox only supports `TransitionEvent` constructor, but `Event` is fine since checked mode is disabled.
    jsEvent = new JsObject.fromBrowserObject(jsDocument.callMethod('createEvent', ['Event']));
  }

  jsEvent.callMethod('initEvent', ['transitionend', true, true]);

  jsElement.callMethod('dispatchEvent', [jsEvent]);

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

/// Focuses the [target] and returns a [Future] when that `focus` event is fired.
///
/// Verifies that the [target] element is not a detached node.
///
/// This is neccessary because IE 11 `focus` events are async.
///
/// See: <https://connect.microsoft.com/IE/feedback/details/2238257/ie11-focus-change-delayed-when-using-the-focus-method>.
Future triggerFocus(Element target) {
  if (!document.documentElement.contains(target)) {
    throw new ArgumentError.value(target, 'target', 'Target should be attached to the document.');
  }

  var completer = new Completer()
    ..complete(target.onFocus.first);

  target.focus();

  return completer.future;
}
