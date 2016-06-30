library ui_core.handler_chain_util;

import 'package:react/react.dart' show
    SyntheticEvent,
    SyntheticClipboardEvent,
    SyntheticKeyboardEvent,
    SyntheticFocusEvent,
    SyntheticFormEvent,
    SyntheticMouseEvent,
    SyntheticTouchEvent,
    SyntheticUIEvent,
    SyntheticWheelEvent;

import '../component/callback_typedefs.dart';

/// Provides chaining utilities for [TargetKeyCallback].
final Callbacks2Arg<SyntheticEvent, Object> targetKeyCallbacks           = const Callbacks2Arg<SyntheticEvent, Object>();

/// Provides chaining utilities for [TargetKeyIndexCallback].
final Callbacks3Arg<SyntheticEvent, Object, int> targetKeyIndexCallbacks = const Callbacks3Arg<SyntheticEvent, Object, int>();

/// Provides chaining utilities for [IndexCallback].
final Callbacks2Arg<SyntheticEvent, int> indexCallbacks                  = const Callbacks2Arg<SyntheticEvent, int>();

/// Provides chaining utilities for [DomEventCallback].
final Callbacks1Arg<SyntheticEvent> domEventCallbacks                    = const Callbacks1Arg<SyntheticEvent>();

/// Provides chaining utilities for [ClipboardEventCallback].
final Callbacks1Arg<SyntheticClipboardEvent> clipboardEventCallbacks     = const Callbacks1Arg<SyntheticClipboardEvent>();

/// Provides chaining utilities for [KeyboardEventCallback].
final Callbacks1Arg<SyntheticKeyboardEvent> keyboardEventCallbacks       = const Callbacks1Arg<SyntheticKeyboardEvent>();

/// Provides chaining utilities for [FocusEventCallback].
final Callbacks1Arg<SyntheticFocusEvent> focusEventCallbacks             = const Callbacks1Arg<SyntheticFocusEvent>();

/// Provides chaining utilities for [FormEventCallback].
final Callbacks1Arg<SyntheticFormEvent> formEventCallbacks               = const Callbacks1Arg<SyntheticFormEvent>();

/// Provides chaining utilities for [MouseEventCallback].
final Callbacks1Arg<SyntheticMouseEvent> mouseEventCallbacks             = const Callbacks1Arg<SyntheticMouseEvent>();

/// Provides chaining utilities for [TouchEventCallback].
final Callbacks1Arg<SyntheticTouchEvent> touchEventCallbacks             = const Callbacks1Arg<SyntheticTouchEvent>();

/// Provides chaining utilities for [UIEventCallback].
final Callbacks1Arg<SyntheticUIEvent> uIEventCallbacks                   = const Callbacks1Arg<SyntheticUIEvent>();

/// Provides chaining utilities for [WheelEventCallback].
final Callbacks1Arg<SyntheticWheelEvent> wheelEventCallbacks             = const Callbacks1Arg<SyntheticWheelEvent>();

/// Provides chaining utilities for [Callback].
final Callbacks0Arg callbacks                                            = const Callbacks0Arg();

/// Provides chaining utilities for [FocusDidChangeCallback].
final Callbacks2Arg<int, int> focusDidChangeCallbacks                    = const Callbacks2Arg<int, int>();

/// Creates an TargetKeyCallback that calls through to the two provided callbacks in order.
///
/// Useful for executing multiple callbacks where only a single callback is accepted.
///
/// Returns `false` if one or more of the provided callback returns `false`.
///
/// Deprecated: use [targetKeyCallbacks] instead.
@deprecated
TargetKeyCallback createChainedTargetKeyCallback(TargetKeyCallback a, TargetKeyCallback b) =>
    targetKeyCallbacks.chain(a, b);

/// Creates an TargetKeyIndexCallback that calls through to the two provided callbacks in order.
///
/// Useful for executing multiple callbacks where only a single callback is accepted.
///
/// Returns `false` if one or more of the provided callback returns `false`.
///
/// Deprecated: use [targetKeyIndexCallbacks] instead.
@deprecated
TargetKeyIndexCallback createChainedTargetKeyIndexCallback(TargetKeyIndexCallback a, TargetKeyIndexCallback b) =>
    targetKeyIndexCallbacks.chain(a, b);

/// Creates an TargetKeyCallback that calls through to the list of provided callbacks in order.
///
/// Useful for executing multiple callbacks where only a single callback is accepted.
///
/// Returns `false` if one or more of the provided callback returns `false`.
///
/// Deprecated: use [targetKeyCallbacks.chainFromList.
@deprecated
TargetKeyCallback createChainedTargetKeyCallbackFromList(List<TargetKeyCallback> callbacks) =>
    targetKeyCallbacks.chainFromList(callbacks);

/// Creates an IndexCallback that calls through to the two provided callbacks in order.
///
/// Useful for executing multiple callbacks where only a single callback is accepted.
///
/// Returns `false` if one or more of the provided callback returns `false`.
///
/// Deprecated: use [indexCallbacks] instead.
@deprecated
IndexCallback createChainedIndexCallback(IndexCallback a, IndexCallback b) =>
    indexCallbacks.chain(a, b);

/// Creates a DomEventCallback that calls through to the two provided callbacks in order.
///
/// Useful for executing multiple callbacks where only a single callback is accepted.
///
/// Returns `false` if one or more of the provided callback returns `false`.
///
/// Deprecated: use [domEventCallbacks] instead.
@deprecated
DomEventCallback createChainedDomEventCallback(DomEventCallback a, DomEventCallback b) =>
    domEventCallbacks.chain(a, b);

/// Creates a ClipboardEventCallback that calls through to the two provided callbacks in order.
///
/// Useful for executing multiple callbacks where only a single callback is accepted.
///
/// Returns `false` if one or more of the provided callback returns `false`.
///
/// Deprecated: use [clipboardEventCallbacks] instead.
@deprecated
ClipboardEventCallback createChainedClipboardEventCallback(ClipboardEventCallback a, ClipboardEventCallback b) =>
    clipboardEventCallbacks.chain(a, b);

/// Creates a KeyboardEventCallback that calls through to the two provided callbacks in order.
///
/// Useful for executing multiple callbacks where only a single callback is accepted.
///
/// Returns `false` if one or more of the provided callback returns `false`.
///
/// Deprecated: use [keyboardEventCallbacks] instead.
@deprecated
KeyboardEventCallback createChainedKeyboardEventCallback(KeyboardEventCallback a, KeyboardEventCallback b) =>
    keyboardEventCallbacks.chain(a, b);

/// Creates a FocusEventCallback that calls through to the two provided callbacks in order.
///
/// Useful for executing multiple callbacks where only a single callback is accepted.
///
/// Returns `false` if one or more of the provided callback returns `false`.
///
/// Deprecated: use [focusEventCallbacks] instead.
@deprecated
FocusEventCallback createChainedFocusEventCallback(FocusEventCallback a, FocusEventCallback b) =>
    focusEventCallbacks.chain(a, b);

/// Creates a FormEventCallback that calls through to the two provided callbacks in order.
///
/// Useful for executing multiple callbacks where only a single callback is accepted.
///
/// Returns `false` if one or more of the provided callback returns `false`.
///
/// Deprecated: use [formEventCallbacks] instead.
@deprecated
FormEventCallback createChainedFormEventCallback(FormEventCallback a, FormEventCallback b) =>
    formEventCallbacks.chain(a, b);

/// Creates a MouseEventCallback that calls through to the two provided callbacks in order.
///
/// Useful for executing multiple callbacks where only a single callback is accepted.
///
/// Returns `false` if one or more of the provided callback returns `false`.
///
/// Deprecated: use [mouseEventCallbacks] instead.
@deprecated
MouseEventCallback createChainedMouseEventCallback(MouseEventCallback a, MouseEventCallback b) =>
    mouseEventCallbacks.chain(a, b);

/// Creates a TouchEventCallback that calls through to the two provided callbacks in order.
///
/// Useful for executing multiple callbacks where only a single callback is accepted.
///
/// Returns `false` if one or more of the provided callback returns `false`.
///
/// Deprecated: use [touchEventCallbacks] instead.
@deprecated
TouchEventCallback createChainedTouchEventCallback(TouchEventCallback a, TouchEventCallback b) =>
    touchEventCallbacks.chain(a, b);

/// Creates a UIEventCallback that calls through to the two provided callbacks in order.
///
/// Useful for executing multiple callbacks where only a single callback is accepted.
///
/// Returns `false` if one or more of the provided callback returns `false`.
///
/// Deprecated: use [uIEventCallbacks] instead.
@deprecated
UIEventCallback createChainedUIEventCallback(UIEventCallback a, UIEventCallback b) =>
    uIEventCallbacks.chain(a, b);

/// Creates a WheelEventCallback that calls through to the two provided callbacks in order.
///
/// Useful for executing multiple callbacks where only a single callback is accepted.
///
/// Returns `false` if one or more of the provided callback returns `false`.
///
/// Deprecated: use [wheelEventCallbacks] instead.
@deprecated
WheelEventCallback createChainedWheelEventCallback(WheelEventCallback a, WheelEventCallback b) =>
    wheelEventCallbacks.chain(a, b);

/// Creates a FocusDidChangeCallback that calls through to the two provided callbacks in order.
///
/// Useful for executing multiple callbacks where only a single callback is accepted.
///
/// Returns `false` if one or more of the provided callback returns `false`.
///
/// Deprecated: use [focusDidChangeCallbacks] instead.
@deprecated
FocusDidChangeCallback createChainedFocusDidChangeCallback(FocusDidChangeCallback a, FocusDidChangeCallback b) =>
    focusDidChangeCallbacks.chain(a, b);

/// Creates a Callback that calls through to the two provided callbacks in order.
///
/// Useful for executing multiple callbacks where only a single callback is accepted.
///
/// Returns `false` if one or more of the provided callback returns `false`.
///
/// Deprecated: use [callbacks] instead.
@deprecated
Callback createChainedCallback(Callback a, Callback b) =>
    callbacks.chain(a, b);


typedef Callback0Arg();
typedef Callback1Arg<T1>(T1 arg1);
typedef Callback2Arg<T1, T2>(T1 arg1, T2 arg2);
typedef Callback3Arg<T1, T2, T3>(T1 arg1, T2 arg2, T3 arg3);

class Callbacks0Arg extends CallbackHelper<Callback0Arg> {
  const Callbacks0Arg();

  noop() {}

  @override
  Callback0Arg chain(Callback0Arg a, Callback0Arg b) {
    if (a == null && b == null) return noop;
    if (a == null) return b;
    if (b == null) return a;

    return () {
      var aDidReturnFalse = a() == false;
      var bDidReturnFalse = b() == false;

      if (aDidReturnFalse || bDidReturnFalse) return false;
    };
  }
}

class Callbacks1Arg<T> extends CallbackHelper<Callback1Arg<T>> {
  const Callbacks1Arg();

  noop(T arg1) {}

  @override
  Callback1Arg<T> chain(Callback1Arg<T> a, Callback1Arg<T> b) {
    if (a == null && b == null) return noop;
    if (a == null) return b;
    if (b == null) return a;

    return (T arg1) {
      var aDidReturnFalse = a(arg1) == false;
      var bDidReturnFalse = b(arg1) == false;

      if (aDidReturnFalse || bDidReturnFalse) return false;
    };
  }
}

class Callbacks2Arg<T1, T2> extends CallbackHelper<Callback2Arg<T1, T2>> {
  const Callbacks2Arg();

  noop(T1 arg1, T2 arg2) {}

  @override
  Callback2Arg<T1, T2> chain(Callback2Arg<T1, T2> a, Callback2Arg<T1, T2> b) {
    if (a == null && b == null) return noop;
    if (a == null) return b;
    if (b == null) return a;

    return (T1 arg1, T2 arg2) {
      var aDidReturnFalse = a(arg1, arg2) == false;
      var bDidReturnFalse = b(arg1, arg2) == false;

      if (aDidReturnFalse || bDidReturnFalse) return false;
    };
  }
}

class Callbacks3Arg<T1, T2, T3> extends CallbackHelper<Callback3Arg<T1, T2, T3>> {
  const Callbacks3Arg();

  noop(T1 arg1, T2 arg2, T3 arg3) {}

  @override
  Callback3Arg<T1, T2, T3> chain(Callback3Arg<T1, T2, T3> a, Callback3Arg<T1, T2, T3> b) {
    if (a == null && b == null) return noop;
    if (a == null) return b;
    if (b == null) return a;

    return (T1 arg1, T2 arg2, T3 arg3) {
      var aDidReturnFalse = a(arg1, arg2, arg3) == false;
      var bDidReturnFalse = b(arg1, arg2, arg3) == false;

      if (aDidReturnFalse || bDidReturnFalse) return false;
    };
  }
}

abstract class CallbackHelper<TTypedef extends Function> {
  const CallbackHelper();

  /// Creates a chained callback that calls through to the two provided callbacks in order.
  /// Useful for executing multiple callbacks where only a single callback is accepted.
  ///
  /// Returns `false` if one or more of the provided callback returns `false`.
  TTypedef chain(TTypedef a, TTypedef b);

  TTypedef chainFromList(List<TTypedef> callbacks) =>
      callbacks.fold(null, chain);
}

