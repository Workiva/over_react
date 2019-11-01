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

library over_react.event_helpers;

import 'dart:html';

import 'package:over_react/over_react.dart';

/// Helper util that wraps a native [KeyboardEvent] in a [SyntheticKeyboardEvent].
///
/// Used where a native [KeyboardEvent] is given and a [SyntheticKeyboardEvent] is needed.
SyntheticKeyboardEvent wrapNativeKeyboardEvent(KeyboardEvent nativeKeyboardEvent) {
  return SyntheticKeyboardEvent(
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
    nativeKeyboardEvent.charCode == null ? null :  String.fromCharCode(nativeKeyboardEvent.charCode),
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

/// Helper util that wraps a native [MouseEvent] in a [SyntheticMouseEvent].
///
/// Used where a native [MouseEvent] is given and a [SyntheticMouseEvent] is needed.
SyntheticMouseEvent wrapNativeMouseEvent(MouseEvent nativeMouseEvent) {
  return SyntheticMouseEvent(
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
/// form elements - we still need a valid [SyntheticFormEvent] to pass as the expected parameter to that callback.
///
/// This helper method generates a "fake" [SyntheticFormEvent], with nothing but the `target` set to [element],
/// `type` set to [type] and `timeStamp` set to the current time. All other arguments are `noop`, `false` or `null`.
SyntheticFormEvent fakeSyntheticFormEvent(Element element, String type) {
  return SyntheticFormEvent(
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
     DateTime.now().millisecondsSinceEpoch,
    type
  );
}
