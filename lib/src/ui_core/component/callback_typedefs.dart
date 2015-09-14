library ui_core.callback_typedefs;

import 'package:react/react.dart' as react;

// Callbacks for React's DOM event system
typedef DomEventCallback(react.SyntheticEvent event);
typedef ClipboardEventCallback(react.SyntheticClipboardEvent event);
typedef KeyboardEventCallback(react.SyntheticKeyboardEvent event);
typedef FocusEventCallback(react.SyntheticFocusEvent event);
typedef FormEventCallback(react.SyntheticFormEvent event);
typedef MouseEventCallback(react.SyntheticMouseEvent event);
/// A callback for React 'mouseenter' and 'mouseleave' events.
///
/// React JS either calls this with:
/// - just a [react.SyntheticMouseEvent] event
/// - a [JsObject] and String id
typedef MouseEnterLeaveEventCallback(/* String|JsObject */ eventOrInstance, [String reactId]);
typedef TouchEventCallback(react.SyntheticTouchEvent event);
typedef UIEventCallback(react.SyntheticUIEvent event);
typedef WheelEventCallback(react.SyntheticWheelEvent event);

// Callback for item selection events
typedef EventKeyCallback(react.SyntheticEvent event, Object eventKey);

// Callback for state changes
typedef StateDidChangeCallback(react.SyntheticEvent event, Map oldState);
typedef StateWillChangeCallback(react.SyntheticEvent event, Map newState);

// Callback for Collapse events
typedef CollapseCallback();
