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
  return createSyntheticKeyboardEvent(
    bubbles: nativeKeyboardEvent.bubbles,
    cancelable: nativeKeyboardEvent.cancelable,
    currentTarget: nativeKeyboardEvent.currentTarget,
    defaultPrevented: nativeKeyboardEvent.defaultPrevented,
    preventDefault: nativeKeyboardEvent.preventDefault,
    stopPropagation: nativeKeyboardEvent.stopPropagation,
    eventPhase: nativeKeyboardEvent.eventPhase,
    nativeEvent: nativeKeyboardEvent,
    target: nativeKeyboardEvent.target,
    timeStamp: nativeKeyboardEvent.timeStamp,
    type: nativeKeyboardEvent.type,
    altKey: nativeKeyboardEvent.altKey,
    char: nativeKeyboardEvent.charCode == null ? null : String.fromCharCode(nativeKeyboardEvent.charCode),
    charCode: nativeKeyboardEvent.charCode,
    ctrlKey: nativeKeyboardEvent.ctrlKey,
    location: nativeKeyboardEvent.location,
    keyCode: nativeKeyboardEvent.keyCode,
    metaKey: nativeKeyboardEvent.metaKey,
    repeat: nativeKeyboardEvent.repeat,
    shiftKey: nativeKeyboardEvent.shiftKey,
  );
}

/// Helper util that wraps a native [MouseEvent] in a [SyntheticMouseEvent].
///
/// Used where a native [MouseEvent] is given and a [SyntheticMouseEvent] is needed.
SyntheticMouseEvent wrapNativeMouseEvent(MouseEvent nativeMouseEvent) {
  return createSyntheticMouseEvent(
    bubbles: nativeMouseEvent.bubbles,
    cancelable: nativeMouseEvent.cancelable,
    currentTarget: nativeMouseEvent.currentTarget,
    defaultPrevented: nativeMouseEvent.defaultPrevented,
    preventDefault: nativeMouseEvent.preventDefault,
    stopPropagation: nativeMouseEvent.stopPropagation,
    eventPhase: nativeMouseEvent.eventPhase,
    nativeEvent: nativeMouseEvent,
    target: nativeMouseEvent.target,
    timeStamp: nativeMouseEvent.timeStamp,
    type: nativeMouseEvent.type,
    altKey: nativeMouseEvent.altKey,
    button: nativeMouseEvent.button,
    ctrlKey: nativeMouseEvent.ctrlKey,
    metaKey: nativeMouseEvent.metaKey,
    relatedTarget: nativeMouseEvent.relatedTarget,
    shiftKey: nativeMouseEvent.shiftKey,
  );
}

/// If the consumer specifies a callback like `onChange` on one of our custom form components that are not *actually*
/// form elements - we still need a valid [SyntheticFormEvent] to pass as the expected parameter to that callback.
///
/// This helper method generates a "fake" [SyntheticFormEvent], with nothing but the `target` set to [element],
/// `type` set to [type] and `timeStamp` set to the current time. All other arguments are `noop`, `false` or `null`.
SyntheticFormEvent fakeSyntheticFormEvent(Element element, String type) {
  return createSyntheticFormEvent(
    cancelable: false,
    currentTarget: element,
    eventPhase: Event.AT_TARGET,
    target: element,
    timeStamp: DateTime.now().millisecondsSinceEpoch,
    type: type,
  );
}
