library over_react.event_helpers;

import 'dart:html';

import 'package:react/react.dart' as react;

/// Helper util that wraps a native [KeyboardEvent] in a [react.SyntheticKeyboardEvent].
///
/// Used where a native [KeyboardEvent] is given and a [react.SyntheticKeyboardEvent] is needed.
react.SyntheticKeyboardEvent wrapNativeKeyboardEvent(KeyboardEvent nativeKeyboardEvent) {
  return new react.SyntheticKeyboardEvent(
    nativeKeyboardEvent.bubbles,
    nativeKeyboardEvent.cancelable,
    nativeKeyboardEvent.currentTarget,
    nativeKeyboardEvent.defaultPrevented,
    nativeKeyboardEvent.preventDefault,
    nativeKeyboardEvent.stopPropagation,
    nativeKeyboardEvent.eventPhase,
    null, // isTrusted
    nativeKeyboardEvent,
    nativeKeyboardEvent.target,
    nativeKeyboardEvent.timeStamp,
    nativeKeyboardEvent.type,
    nativeKeyboardEvent.altKey,
    nativeKeyboardEvent.charCode == null ? null : new String.fromCharCode(nativeKeyboardEvent.charCode),
    nativeKeyboardEvent.charCode,
    nativeKeyboardEvent.ctrlKey,
    null, // locale
    nativeKeyboardEvent.location,
    null, // key
    nativeKeyboardEvent.keyCode,
    nativeKeyboardEvent.metaKey,
    nativeKeyboardEvent.repeat,
    nativeKeyboardEvent.shiftKey);
}

/// Helper util that wraps a native [MouseEvent] in a [react.MouseEvent].
///
/// Used where a native [MouseEvent] is given and a [react.MouseEvent] is needed.
react.SyntheticMouseEvent wrapNativeMouseEvent(MouseEvent nativeMouseEvent) {
  return new react.SyntheticMouseEvent(
    nativeMouseEvent.bubbles,
    nativeMouseEvent.cancelable,
    nativeMouseEvent.currentTarget,
    nativeMouseEvent.defaultPrevented,
    nativeMouseEvent.preventDefault,
    nativeMouseEvent.stopPropagation,
    nativeMouseEvent.eventPhase,
    null, // isTrusted
    nativeMouseEvent,
    nativeMouseEvent.target,
    nativeMouseEvent.timeStamp,
    nativeMouseEvent.type,
    nativeMouseEvent.altKey,
    nativeMouseEvent.button,
    null, // buttons
    null, // clientX
    null, // clientY

    nativeMouseEvent.ctrlKey,
    null, // dataTransfer
    nativeMouseEvent.metaKey,
    null, // pageX
    null, // pageY
    nativeMouseEvent.relatedTarget,
    null, // screenX
    null, // screenY
    nativeMouseEvent.shiftKey);
}

/// If the consumer specifies a callback like `onChange` on one of our custom form components that are not *actually*
/// form elements - we still need a valid [react.SyntheticFormEvent] to pass as the expected parameter to that callback.
///
/// This helper method generates a "fake" [react.SyntheticFormEvent], with nothing but the `target` set to [element],
/// `type` set to [type] and `timeStamp` set to the current time. All other arguments are `noop`, `false` or `null`.
react.SyntheticFormEvent fakeSyntheticFormEvent(Element element, String type) {
  return new react.SyntheticFormEvent(
    false,
    false,
    element,
    false,
    () {},
    () {},
    Event.AT_TARGET,
    false,
    null,
    element,
    new DateTime.now().millisecondsSinceEpoch,
    type
  );
}
