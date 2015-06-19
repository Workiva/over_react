part of w_ui_platform.ui_core;

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

// Callback for hitarea selection events
typedef EventKeyCallback(react.SyntheticEvent event, dynamic eventKey);
typedef HitAreaSelectCallback(react.SyntheticEvent event, dynamic eventKey, {String href, String target});
