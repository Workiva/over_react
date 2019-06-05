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

library over_react.handler_chain_util;

import 'package:over_react/over_react.dart' show ResizeSensorEvent;
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
final CallbackUtil1Arg<SyntheticUIEvent> uiEventCallbacks                   = const CallbackUtil1Arg<SyntheticUIEvent>();

/// Provides chaining utilities for [WheelEventCallback].
final CallbackUtil1Arg<SyntheticWheelEvent> wheelEventCallbacks             = const CallbackUtil1Arg<SyntheticWheelEvent>();

/// Provides chaining utilities for [Callback].
final CallbackUtil0Arg callbacks                                            = const CallbackUtil0Arg();

/// Provides chaining utilities for [ResizeSensorHandler].
final CallbackUtil1Arg<ResizeSensorEvent> resizeEventCallbacks              = const CallbackUtil1Arg<ResizeSensorEvent>();

typedef Callback0Arg();
typedef Callback1Arg<T1>(T1 arg1);
typedef Callback2Arg<T1, T2>(T1 arg1, T2 arg2);
typedef Callback3Arg<T1, T2, T3>(T1 arg1, T2 arg2, T3 arg3);
typedef Callback4Arg<T1, T2, T3, T4>(T1 arg1, T2 arg2, T3 arg3, T4 arg4);

/// Generic callback chaining utilities for callbacks with no arguments.
class CallbackUtil0Arg extends CallbackUtil {
  const CallbackUtil0Arg();

  _noop() {}

  /// A function of type [Callback0Arg] that does nothing.
  @override
  Callback0Arg get noop => _noop;

  /// Returns a strongly-typed chained callback that calls through to the two provided callbacks, [a] and [b], in order.
  /// Useful for executing multiple callbacks where only a single callback is accepted.
  ///
  /// Returns `false` if one or more of the provided callbacks returns `false`.
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

  @override
  Callback0Arg chainFromList(List<Callback0Arg> callbacks) =>
      callbacks.fold(null, chain) ?? noop;
}

/// Generic strongly-typed callback chaining utilities for callbacks with one argument.
class CallbackUtil1Arg<T> extends CallbackUtil {
  const CallbackUtil1Arg();

  _noop(T arg1) {}

  /// A function of type [Callback1Arg<T>] that does nothing.
  @override
  Callback1Arg<T> get noop => _noop;

  /// Returns a strongly-typed chained callback that calls through to the two provided callbacks, [a] and [b], in order.
  /// Useful for executing multiple callbacks where only a single callback is accepted.
  ///
  /// Returns `false` if one or more of the provided callbacks returns `false`.
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

  @override
  Callback1Arg<T> chainFromList(List<Callback1Arg<T>> callbacks) =>
      callbacks.fold(null, chain) ?? noop;
}

/// Generic strongly-typed callback chaining utilities for callbacks with two arguments.
class CallbackUtil2Arg<T1, T2> extends CallbackUtil {
  const CallbackUtil2Arg();

  _noop(T1 arg1, T2 arg2) {}

  /// A function of type [Callback2Arg<T1, T2>] that does nothing.
  @override
  Callback2Arg<T1, T2> get noop => _noop;

  /// Returns a strongly-typed chained callback that calls through to the two provided callbacks, [a] and [b], in order.
  /// Useful for executing multiple callbacks where only a single callback is accepted.
  ///
  /// Returns `false` if one or more of the provided callbacks returns `false`.
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

  @override
  Callback2Arg<T1, T2> chainFromList(List<Callback2Arg<T1, T2>> callbacks) =>
      callbacks.fold(null, chain) ?? noop;
}

/// Generic strongly-typed callback chaining utilities for callbacks with three arguments.
class CallbackUtil3Arg<T1, T2, T3> extends CallbackUtil {
  const CallbackUtil3Arg();

  _noop(T1 arg1, T2 arg2, T3 arg3) {}

  /// A function of type [Callback3Arg<T1, T2, T3>] that does nothing.
  @override
  Callback3Arg<T1, T2, T3> get noop => _noop;

  /// Returns a strongly-typed chained callback that calls through to the two provided callbacks, [a] and [b], in order.
  /// Useful for executing multiple callbacks where only a single callback is accepted.
  ///
  /// Returns `false` if one or more of the provided callbacks returns `false`.
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

  @override
  Callback3Arg<T1, T2, T3> chainFromList(List<Callback3Arg<T1, T2, T3>> callbacks) =>
      callbacks.fold(null, chain) ?? noop;
}

/// Generic strongly-typed callback chaining utilities for callbacks with four arguments.
class CallbackUtil4Arg<T1, T2, T3, T4> extends CallbackUtil {
  const CallbackUtil4Arg();

  _noop(T1 arg1, T2 arg2, T3 arg3, T4 arg4) {}

  /// A function of type [Callback3Arg<T1, T2, T3, T4>] that does nothing.
  @override
  Callback4Arg<T1, T2, T3, T4> get noop => _noop;

  /// Returns a strongly-typed chained callback that calls through to the two provided callbacks, [a] and [b], in order.
  /// Useful for executing multiple callbacks where only a single callback is accepted.
  ///
  /// Returns `false` if one or more of the provided callbacks returns `false`.
  ///
  /// Gracefully handles when [a] and/or [b] are null, always returning a callable function.
  @override
  Callback4Arg<T1, T2, T3, T4> chain(Callback4Arg<T1, T2, T3, T4> a, Callback4Arg<T1, T2, T3, T4> b) {
    if (a == null && b == null) return noop;
    if (a == null) return b;
    if (b == null) return a;

    return (T1 arg1, T2 arg2, T3 arg3, T4 arg4) {
      var aDidReturnFalse = a(arg1, arg2, arg3, arg4) == false;
      var bDidReturnFalse = b(arg1, arg2, arg3, arg4) == false;

      if (aDidReturnFalse || bDidReturnFalse) return false;
    };
  }

  @override
  Callback4Arg<T1, T2, T3, T4> chainFromList(List<Callback4Arg<T1, T2, T3, T4>> callbacks) =>
      callbacks.fold(null, chain) ?? noop;
}

/// Base class for generic strongly-typed callback chaining utilities.
abstract class CallbackUtil<_> {
  const CallbackUtil();

  /// Returns a strongly-typed chained callback that calls through to the two provided callbacks, [a] and [b], in order.
  /// Useful for executing multiple callbacks where only a single callback is accepted.
  ///
  /// Returns `false` if one or more of the provided callbacks returns `false`.
  ///
  /// Gracefully handles when [a] and/or [b] are null, always returning a callable function.
  Function chain(covariant Function a, covariant Function b);

  /// Returns a strongly-typed chained callback that calls through to the list of provided [callbacks] in order.
  /// Useful for executing multiple callbacks where only a single callback is accepted.
  ///
  /// Returns `false` if one or more of the provided callbacks returns `false`.
  ///
  /// Gracefully handles when [callbacks] is empty or its items are null, always returning a callable function.
  Function chainFromList(covariant List<Function> callbacks) =>
      callbacks.fold(null, chain) ?? noop;

  /// A function of type [Function] that does nothing.
  Function get noop;
}
