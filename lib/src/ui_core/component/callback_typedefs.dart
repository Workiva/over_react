library ui_core.callback_typedefs;

import 'dart:html';

import 'package:react/react.dart' as react;
import 'package:web_skin_dart/ui_core.dart' show ResizeSensorEvent;

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

// Callbacks for native events.
typedef NativeKeyboardEventCallback(KeyboardEvent event);

// Callback for item selection events
typedef DateSelectCallback<TEvent extends react.SyntheticEvent>(TEvent event, DateTime date);
/// Deprecated: Use [TargetKeyCallback]
@Deprecated('2.0.0')
typedef EventKeyCallback(react.SyntheticEvent event, Object eventKey);
/// Deprecated: Use [TargetKeyIndexCallback]
@Deprecated('2.0.0')
typedef EventKeyIndexCallback(react.SyntheticEvent event, Object eventKey, int index);
typedef TargetKeyCallback(react.SyntheticEvent event, Object targetKey);
typedef TargetKeyIndexCallback(react.SyntheticEvent event, Object targetKey, int index);
@deprecated
/// Use [TargetKeyCallback] instead.
typedef EventValueCallback(react.SyntheticEvent event, String value);
typedef IndexCallback(react.SyntheticEvent event, int index);

// Callback for state changes
typedef StateDidChangeCallback(react.SyntheticEvent event, Map oldState);
typedef StateWillChangeCallback(react.SyntheticEvent event, Map newState);

// Callbacks for selection and focus changes.
typedef FocusWillChangeCallback(int nextFocusedItemIndex, int currentFocusedItemIndex);
typedef FocusDidChangeCallback(int currentFocusedItemIndex, int prevFocusedItemIndex);
typedef SelectionWillChangeCallback(Set<int> nextSelectedItemIndices, Set<int> currentSelectedItemIndices);
typedef SelectionDidChangeCallback(Set<int> currentSelectedItemIndices, Set<int> prevSelectedItemIndices);

/// A generic callback that takes no arguments.
typedef Callback();

// Callback for DOM elements
typedef Element ElementCallback();

// Callback for ResizeSensor events
typedef void ResizeSensorHandler(ResizeSensorEvent event);
