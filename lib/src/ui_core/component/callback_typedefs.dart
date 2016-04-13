library ui_core.callback_typedefs;

import 'dart:html';

import 'package:react/react.dart' as react;

// Callbacks for React's DOM event system
typedef DomEventCallback(react.SyntheticEvent event);
typedef ClipboardEventCallback(react.SyntheticClipboardEvent event);
typedef KeyboardEventCallback(react.SyntheticKeyboardEvent event);
typedef FocusEventCallback(react.SyntheticFocusEvent event);
typedef FormEventCallback(react.SyntheticFormEvent event);
typedef MouseEventCallback(react.SyntheticMouseEvent event);
typedef TouchEventCallback(react.SyntheticTouchEvent event);
typedef UIEventCallback(react.SyntheticUIEvent event);
typedef WheelEventCallback(react.SyntheticWheelEvent event);

// Callback for item selection events
typedef EventKeyCallback(react.SyntheticEvent event, Object eventKey);
typedef IndexCallback(react.SyntheticEvent event, int index);
typedef DateSelectCallback(react.SyntheticEvent event, DateTime date);

// Callback for state changes
typedef StateDidChangeCallback(react.SyntheticEvent event, Map oldState);
typedef StateWillChangeCallback(react.SyntheticEvent event, Map newState);

/// A generic callback that takes no arguments.
typedef Callback();

// Callback for DOM elements
typedef Element ElementCallback();
