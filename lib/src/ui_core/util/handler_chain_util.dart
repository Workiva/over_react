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
final CallbackUtil2Arg<SyntheticEvent, Object> targetKeyCallbacks           = const CallbackUtil2Arg<SyntheticEvent, Object>();

/// Provides chaining utilities for [TargetKeyIndexCallback].
final CallbackUtil3Arg<SyntheticEvent, Object, int> targetKeyIndexCallbacks = const CallbackUtil3Arg<SyntheticEvent, Object, int>();

/// Provides chaining utilities for [IndexCallback].
final CallbackUtil2Arg<SyntheticEvent, int> indexCallbacks                  = const CallbackUtil2Arg<SyntheticEvent, int>();

/// Provides chaining utilities for [DomEventCallback].
final CallbackUtil1Arg<SyntheticEvent> domEventCallbacks                    = const CallbackUtil1Arg<SyntheticEvent>();

/// Provides chaining utilities for [ClipboardEventCallback].
final CallbackUtil1Arg<SyntheticClipboardEvent> clipboardEventCallbacks     = const CallbackUtil1Arg<SyntheticClipboardEvent>();

/// Provides chaining utilities for [KeyboardEventCallback].
final CallbackUtil1Arg<SyntheticKeyboardEvent> keyboardEventCallbacks       = const CallbackUtil1Arg<SyntheticKeyboardEvent>();

/// Provides chaining utilities for [FocusEventCallback].
final CallbackUtil1Arg<SyntheticFocusEvent> focusEventCallbacks             = const CallbackUtil1Arg<SyntheticFocusEvent>();

/// Provides chaining utilities for [FormEventCallback].
final CallbackUtil1Arg<SyntheticFormEvent> formEventCallbacks               = const CallbackUtil1Arg<SyntheticFormEvent>();

/// Provides chaining utilities for [MouseEventCallback].
final CallbackUtil1Arg<SyntheticMouseEvent> mouseEventCallbacks             = const CallbackUtil1Arg<SyntheticMouseEvent>();

/// Provides chaining utilities for [TouchEventCallback].
final CallbackUtil1Arg<SyntheticTouchEvent> touchEventCallbacks             = const CallbackUtil1Arg<SyntheticTouchEvent>();

/// Provides chaining utilities for [UIEventCallback].
final CallbackUtil1Arg<SyntheticUIEvent> uIEventCallbacks                   = const CallbackUtil1Arg<SyntheticUIEvent>();

/// Provides chaining utilities for [WheelEventCallback].
final CallbackUtil1Arg<SyntheticWheelEvent> wheelEventCallbacks             = const CallbackUtil1Arg<SyntheticWheelEvent>();

/// Provides chaining utilities for [Callback].
final CallbackUtil0Arg callbacks                                            = const CallbackUtil0Arg();

/// Provides chaining utilities for [FocusDidChangeCallback].
final CallbackUtil2Arg<int, int> focusDidChangeCallbacks                    = const CallbackUtil2Arg<int, int>();

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

/// Generic callback chaining utilities for callbacks with no arguments.
class CallbackUtil0Arg extends CallbackUtil<Callback0Arg> {
  const CallbackUtil0Arg();

  _noop() {}

  /// A function of type [Callback0Arg] that does nothing.
  @override
  Callback0Arg get noop => _noop;

  /// Returns a strongly-typed chained callback that calls through to the two provided callbacks, [a] and [b], in order.
  /// Useful for executing multiple callbacks where only a single callback is accepted.
  ///
  /// Returns `false` if one or more of the provided callback returns `false`.
  ///
  /// Gracefully handles when [a] and/or [b] are null, always returning a callable function.
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

/// Generic strongly-typed callback chaining utilities for callbacks with one argument.
class CallbackUtil1Arg<T> extends CallbackUtil<Callback1Arg<T>> {
  const CallbackUtil1Arg();

  _noop(T arg1) {}

  /// A function of type [Callback1Arg<T>] that does nothing.
  @override
  Callback1Arg<T> get noop => _noop;

  /// Returns a strongly-typed chained callback that calls through to the two provided callbacks, [a] and [b], in order.
  /// Useful for executing multiple callbacks where only a single callback is accepted.
  ///
  /// Returns `false` if one or more of the provided callback returns `false`.
  ///
  /// Gracefully handles when [a] and/or [b] are null, always returning a callable function.
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

/// Generic strongly-typed callback chaining utilities for callbacks with two arguments.
class CallbackUtil2Arg<T1, T2> extends CallbackUtil<Callback2Arg<T1, T2>> {
  const CallbackUtil2Arg();

  _noop(T1 arg1, T2 arg2) {}

  /// A function of type [Callback2Arg<T1, T2>] that does nothing.
  @override
  Callback2Arg<T1, T2> get noop => _noop;

  /// Returns a strongly-typed chained callback that calls through to the two provided callbacks, [a] and [b], in order.
  /// Useful for executing multiple callbacks where only a single callback is accepted.
  ///
  /// Returns `false` if one or more of the provided callback returns `false`.
  ///
  /// Gracefully handles when [a] and/or [b] are null, always returning a callable function.
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

/// Generic strongly-typed callback chaining utilities for callbacks with three arguments.
class CallbackUtil3Arg<T1, T2, T3> extends CallbackUtil<Callback3Arg<T1, T2, T3>> {
  const CallbackUtil3Arg();

  _noop(T1 arg1, T2 arg2, T3 arg3) {}

  /// A function of type [Callback3Arg<T1, T2, T3>] that does nothing.
  @override
  Callback3Arg<T1, T2, T3> get noop => _noop;

  /// Returns a strongly-typed chained callback that calls through to the two provided callbacks, [a] and [b], in order.
  /// Useful for executing multiple callbacks where only a single callback is accepted.
  ///
  /// Returns `false` if one or more of the provided callback returns `false`.
  ///
  /// Gracefully handles when [a] and/or [b] are null, always returning a callable function.
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

/// Base class for generic strongly-typed callback chaining utilities.
abstract class CallbackUtil<TTypedef extends Function> {
  const CallbackUtil();

  /// Returns a strongly-typed chained callback that calls through to the two provided callbacks, [a] and [b], in order.
  /// Useful for executing multiple callbacks where only a single callback is accepted.
  ///
  /// Returns `false` if one or more of the provided callback returns `false`.
  ///
  /// Gracefully handles when [a] and/or [b] are null, always returning a callable function.
  TTypedef chain(TTypedef a, TTypedef b);

  /// Returns a strongly-typed chained callback that calls through to the list of provided [callbacks] in order.
  /// Useful for executing multiple callbacks where only a single callback is accepted.
  ///
  /// Returns `false` if one or more of the provided callback returns `false`.
  ///
  /// Gracefully handles when [callbacks] is empty or its items are null, always returning a callable function.
  TTypedef chainFromList(List<TTypedef> callbacks) =>
      callbacks.fold(null, chain) ?? noop;

  /// A function of type [TTypedef] that does nothing.
  TTypedef get noop;
}

