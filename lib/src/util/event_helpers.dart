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
import 'package:react/react_client/js_interop_helpers.dart';

// FIXME move these to react-dart and re-export here so the implementations don't get out of sync, possibly deprecate them?

/// Helper util that wraps a native [KeyboardEvent] in a [SyntheticKeyboardEvent].
///
/// Used where a native [KeyboardEvent] is given and a [SyntheticKeyboardEvent] is needed.
SyntheticKeyboardEvent wrapNativeKeyboardEvent(KeyboardEvent nativeEvent) {
  return jsifyAndAllowInterop({
    // SyntheticEvent fields
    'bubbles': nativeEvent.bubbles,
    'cancelable': nativeEvent.cancelable,
    'currentTarget': nativeEvent.currentTarget,
    'defaultPrevented': nativeEvent.defaultPrevented,
    'eventPhase': nativeEvent.eventPhase,
    'isTrusted': nativeEvent.isTrusted,
    'nativeEvent': nativeEvent,
    'target': nativeEvent.target,
    'timeStamp': nativeEvent.timeStamp,
    'type': nativeEvent.type,
    // SyntheticEvent methods
    'stopPropagation': nativeEvent.stopPropagation,
    'preventDefault': nativeEvent.preventDefault,
    'persist': () {},
    'isPersistent': () => true,
    // SyntheticKeyboardEvent fields
    'altKey': nativeEvent.altKey,
    'char': nativeEvent.charCode == null ? null : String.fromCharCode(nativeEvent.charCode),
    'ctrlKey': nativeEvent.ctrlKey,
    'locale': null,
    'location': nativeEvent.location,
    'key': nativeEvent.key,
    'metaKey': nativeEvent.metaKey,
    'repeat': nativeEvent.repeat,
    'shiftKey': nativeEvent.shiftKey,
    'keyCode': nativeEvent.keyCode,
    'charCode': nativeEvent.charCode,
  }) as SyntheticKeyboardEvent;
}

/// Helper util that wraps a native [MouseEvent] in a [SyntheticMouseEvent].
///
/// Used where a native [MouseEvent] is given and a [SyntheticMouseEvent] is needed.
SyntheticMouseEvent wrapNativeMouseEvent(MouseEvent nativeEvent) {
  return jsifyAndAllowInterop({
    // SyntheticEvent fields
    'bubbles': nativeEvent.bubbles,
    'cancelable': nativeEvent.cancelable,
    'currentTarget': nativeEvent.currentTarget,
    'defaultPrevented': nativeEvent.defaultPrevented,
    'eventPhase': nativeEvent.eventPhase,
    'isTrusted': nativeEvent.isTrusted,
    'nativeEvent': nativeEvent,
    'target': nativeEvent.target,
    'timeStamp': nativeEvent.timeStamp,
    'type': nativeEvent.type,
    // SyntheticEvent methods
    'stopPropagation': nativeEvent.stopPropagation,
    'preventDefault': nativeEvent.preventDefault,
    'persist': () {},
    'isPersistent': () => true,
    // SyntheticMouseEvent fields
    'altKey': nativeEvent.altKey,
    'button': nativeEvent.button,
    'buttons': nativeEvent.buttons,
    'clientX': nativeEvent.client.x,
    'clientY': nativeEvent.client.y,
    'ctrlKey': nativeEvent.ctrlKey,
    'dataTransfer': nativeEvent.dataTransfer,
    'metaKey': nativeEvent.metaKey,
    'pageX': nativeEvent.page.x,
    'pageY': nativeEvent.page.y,
    'relatedTarget': nativeEvent.relatedTarget,
    'screenX': nativeEvent.screen.x,
    'screenY': nativeEvent.screen.y,
    'shiftKey': nativeEvent.shiftKey,
  }) as SyntheticMouseEvent;
}

/// If the consumer specifies a callback like `onChange` on one of our custom form components that are not *actually*
/// form elements - we still need a valid [SyntheticFormEvent] to pass as the expected parameter to that callback.
///
/// This helper method generates a "fake" [SyntheticFormEvent], with nothing but the `target` set to [element],
/// `type` set to [type] and `timeStamp` set to the current time. All other arguments are `noop`, `false` or `null`.
SyntheticFormEvent fakeSyntheticFormEvent(Element element, String type) {
  return jsifyAndAllowInterop({
    // SyntheticEvent fields
    'bubbles': false,
    'cancelable': false,
    'currentTarget': element,
    'defaultPrevented': false,
    'eventPhase': Event.AT_TARGET,
    'isTrusted': false,
    'nativeEvent': null,
    'target': element,
    'timeStamp': DateTime.now().millisecondsSinceEpoch,
    'type': type,
    // SyntheticEvent methods
    'stopPropagation': () {},
    'preventDefault': () {},
    'persist': () {},
    'isPersistent': () => true,
  }) as SyntheticFormEvent;
}
