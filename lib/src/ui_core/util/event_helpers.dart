part of web_skin_dart.ui_core;

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
    nativeMouseEvent.clientX,
    nativeMouseEvent.clientY,

    nativeMouseEvent.ctrlKey,
    null, // dataTransfer
    nativeMouseEvent.metaKey,
    null, // pageX
    null, // pageY
    nativeMouseEvent.relatedTarget,
    nativeMouseEvent.screenX,
    nativeMouseEvent.screenY,
    nativeMouseEvent.shiftKey);
}
