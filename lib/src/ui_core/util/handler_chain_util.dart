library ui_core.handler_chain_util;

import 'package:react/react.dart' as react;

import '../component/callback_typedefs.dart';

/// Creates an TargetKeyCallback that calls through to the two provided callbacks in order.
///
/// Useful for executing multiple callbacks where only a single callback is accepted.
///
/// Returns `false` if one or more of the provided callback returns `false`.
TargetKeyCallback createChainedTargetKeyCallback(TargetKeyCallback a, TargetKeyCallback b) {
  return (react.SyntheticEvent event, Object targetKey) {
    var aDidReturnFalse = a != null ? a(event, targetKey) == false : false;
    var bDidReturnFalse = b != null ? b(event, targetKey) == false : false;

    if (aDidReturnFalse || bDidReturnFalse) {
      return false;
    }
  };
}

/// Creates an TargetKeyIndexCallback that calls through to the two provided callbacks in order.
///
/// Useful for executing multiple callbacks where only a single callback is accepted.
///
/// Returns `false` if one or more of the provided callback returns `false`.
TargetKeyIndexCallback createChainedTargetKeyIndexCallback(TargetKeyIndexCallback a, TargetKeyIndexCallback b) {
  return (react.SyntheticEvent event, Object targetKey, int index) {
    var aDidReturnFalse = a != null ? a(event, targetKey, index) == false : false;
    var bDidReturnFalse = b != null ? b(event, targetKey, index) == false : false;

    if (aDidReturnFalse || bDidReturnFalse) {
      return false;
    }
  };
}

/// Creates an TargetKeyCallback that calls through to the list of provided callbacks in order.
///
/// Useful for executing multiple callbacks where only a single callback is accepted.
///
/// Returns `false` if one or more of the provided callback returns `false`.
TargetKeyCallback createChainedTargetKeyCallbackFromList(List<TargetKeyCallback> callbacks) {
  return (react.SyntheticEvent event, Object targetKey) {
    var didReturnFalse = false;

    callbacks.forEach((TargetKeyCallback callback) {
      if (callback != null && callback(event, targetKey) == false) {
        didReturnFalse = true;
      }
    });

    if (didReturnFalse) {
      return false;
    }
  };
}

/// Creates an IndexCallback that calls through to the two provided callbacks in order.
///
/// Useful for executing multiple callbacks where only a single callback is accepted.
///
/// Returns `false` if one or more of the provided callback returns `false`.
IndexCallback createChainedIndexCallback(IndexCallback a, IndexCallback b) {
  return (react.SyntheticEvent event, int index) {
    var aDidReturnFalse = a != null ? a(event, index) == false : false;
    var bDidReturnFalse = b != null ? b(event, index) == false : false;

    if (aDidReturnFalse || bDidReturnFalse) {
      return false;
    }
  };
}

/// Creates a DomEventCallback that calls through to the two provided callbacks in order.
///
/// Useful for executing multiple callbacks where only a single callback is accepted.
///
/// Returns `false` if one or more of the provided callback returns `false`.
DomEventCallback createChainedDomEventCallback(DomEventCallback a, DomEventCallback b) {
  return (react.SyntheticEvent event) {
    var aDidReturnFalse = a != null ? a(event) == false : false;
    var bDidReturnFalse = b != null ? b(event) == false : false;

    if (aDidReturnFalse || bDidReturnFalse) {
      return false;
    }
  };
}

/// Creates a ClipboardEventCallback that calls through to the two provided callbacks in order.
///
/// Useful for executing multiple callbacks where only a single callback is accepted.
///
/// Returns `false` if one or more of the provided callback returns `false`.
ClipboardEventCallback createChainedClipboardEventCallback(ClipboardEventCallback a, ClipboardEventCallback b) {
  return (react.SyntheticClipboardEvent event) {
    var aDidReturnFalse = a != null ? a(event) == false : false;
    var bDidReturnFalse = b != null ? b(event) == false : false;

    if (aDidReturnFalse || bDidReturnFalse) {
      return false;
    }
  };
}

/// Creates a KeyboardEventCallback that calls through to the two provided callbacks in order.
///
/// Useful for executing multiple callbacks where only a single callback is accepted.
///
/// Returns `false` if one or more of the provided callback returns `false`.
KeyboardEventCallback createChainedKeyboardEventCallback(KeyboardEventCallback a, KeyboardEventCallback b) {
  return (react.SyntheticKeyboardEvent event) {
    var aDidReturnFalse = a != null ? a(event) == false : false;
    var bDidReturnFalse = b != null ? b(event) == false : false;

    if (aDidReturnFalse || bDidReturnFalse) {
      return false;
    }
  };
}

/// Creates a FocusEventCallback that calls through to the two provided callbacks in order.
///
/// Useful for executing multiple callbacks where only a single callback is accepted.
///
/// Returns `false` if one or more of the provided callback returns `false`.
FocusEventCallback createChainedFocusEventCallback(FocusEventCallback a, FocusEventCallback b) {
  return (react.SyntheticFocusEvent event) {
    var aDidReturnFalse = a != null ? a(event) == false : false;
    var bDidReturnFalse = b != null ? b(event) == false : false;

    if (aDidReturnFalse || bDidReturnFalse) {
      return false;
    }
  };
}

/// Creates a FormEventCallback that calls through to the two provided callbacks in order.
///
/// Useful for executing multiple callbacks where only a single callback is accepted.
///
/// Returns `false` if one or more of the provided callback returns `false`.
FormEventCallback createChainedFormEventCallback(FormEventCallback a, FormEventCallback b) {
  return (react.SyntheticFormEvent event) {
    var aDidReturnFalse = a != null ? a(event) == false : false;
    var bDidReturnFalse = b != null ? b(event) == false : false;

    if (aDidReturnFalse || bDidReturnFalse) {
      return false;
    }
  };
}

/// Creates a MouseEventCallback that calls through to the two provided callbacks in order.
///
/// Useful for executing multiple callbacks where only a single callback is accepted.
///
/// Returns `false` if one or more of the provided callback returns `false`.
MouseEventCallback createChainedMouseEventCallback(MouseEventCallback a, MouseEventCallback b) {
  return (react.SyntheticMouseEvent event) {
    var aDidReturnFalse = a != null ? a(event) == false : false;
    var bDidReturnFalse = b != null ? b(event) == false : false;

    if (aDidReturnFalse || bDidReturnFalse) {
      return false;
    }
  };
}

/// Creates a TouchEventCallback that calls through to the two provided callbacks in order.
///
/// Useful for executing multiple callbacks where only a single callback is accepted.
///
/// Returns `false` if one or more of the provided callback returns `false`.
TouchEventCallback createChainedTouchEventCallback(TouchEventCallback a, TouchEventCallback b) {
  return (react.SyntheticTouchEvent event) {
    var aDidReturnFalse = a != null ? a(event) == false : false;
    var bDidReturnFalse = b != null ? b(event) == false : false;

    if (aDidReturnFalse || bDidReturnFalse) {
      return false;
    }
  };
}

/// Creates a UIEventCallback that calls through to the two provided callbacks in order.
///
/// Useful for executing multiple callbacks where only a single callback is accepted.
///
/// Returns `false` if one or more of the provided callback returns `false`.
UIEventCallback createChainedUIEventCallback(UIEventCallback a, UIEventCallback b) {
  return (react.SyntheticUIEvent event) {
    var aDidReturnFalse = a != null ? a(event) == false : false;
    var bDidReturnFalse = b != null ? b(event) == false : false;

    if (aDidReturnFalse || bDidReturnFalse) {
      return false;
    }
  };
}

/// Creates a WheelEventCallback that calls through to the two provided callbacks in order.
///
/// Useful for executing multiple callbacks where only a single callback is accepted.
///
/// Returns `false` if one or more of the provided callback returns `false`.
WheelEventCallback createChainedWheelEventCallback(WheelEventCallback a, WheelEventCallback b) {
  return (react.SyntheticWheelEvent event) {
    var aDidReturnFalse = a != null ? a(event) == false : false;
    var bDidReturnFalse = b != null ? b(event) == false : false;

    if (aDidReturnFalse || bDidReturnFalse) {
      return false;
    }
  };
}

/// Creates a FocusDidChangeCallback that calls through to the two provided callbacks in order.
///
/// Useful for executing multiple callbacks where only a single callback is accepted.
///
/// Returns `false` if one or more of the provided callback returns `false`.
FocusDidChangeCallback createChainedFocusDidChangeCallback(FocusDidChangeCallback a, FocusDidChangeCallback b) {
  return (int currentIndex, int prevIndex) {
    var aDidReturnFalse = a != null ? a(currentIndex, prevIndex) == false : false;
    var bDidReturnFalse = b != null ? b(currentIndex, prevIndex) == false : false;

    if (aDidReturnFalse || bDidReturnFalse) {
      return false;
    }
  };
}

/// Creates a Callback that calls through to the two provided callbacks in order.
///
/// Useful for executing multiple callbacks where only a single callback is accepted.
///
/// Returns `false` if one or more of the provided callback returns `false`.
Callback createChainedCallback(Callback a, Callback b) {
  return () {
    var aDidReturnFalse = a != null ? a() == false : false;
    var bDidReturnFalse = b != null ? b() == false : false;

    if (aDidReturnFalse || bDidReturnFalse) {
      return false;
    }
  };
}
