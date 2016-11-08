// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'breakpoint.dart';
import 'frame.dart';
import 'instance.dart';
import 'scope.dart';

VMPauseEvent newVMPauseEvent(Scope scope, Map json) {
  if (json == null) return null;

  assert(json["type"] == "Event");
  switch (json["kind"]) {
    case "PauseStart": return new VMPauseStartEvent._(scope, json);
    case "PauseExit": return new VMPauseExitEvent._(scope, json);
    case "PauseBreakpoint": return new VMPauseBreakpointEvent._(scope, json);
    case "PauseInterrupted": return new VMPauseInterruptedEvent._(scope, json);
    case "PauseException": return new VMPauseExceptionEvent._(scope, json);
    case "Resume": return new VMResumeEvent._(scope, json);
    case "None": return new VMNoneEvent._(scope, json);
    default: return null;
  }
}

/// An event indicating that an isolate has been paused or resumed.
abstract class VMPauseEvent {
  /// The top stack frame associated with this event.
  ///
  /// This is `null` for [VMPauseInterruptedEvent]s when the interrupt arrived
  /// while the Isolate was idle, and for pause events that don't occur while
  /// the isolate is running code.
  final VMFrame topFrame;

  /// The time at which the event fired.
  ///
  /// This is only available in version 3.0 or greater of the VM service
  /// protocol.
  final DateTime time;

  VMPauseEvent._(Scope scope, Map json)
      : topFrame = newVMFrame(scope, json["frame"]),
        time = json["timestamp"] == null
            ? null
            : new DateTime.fromMillisecondsSinceEpoch(json["timestamp"]);
}

/// An event indicating that an isolate was paused as it started, before it
/// executed any code.
class VMPauseStartEvent extends VMPauseEvent {
  VMPauseStartEvent._(Scope scope, Map json)
      : super._(scope, json);

  String toString() => "pause before start";
}

/// An event indicating that an isolate was paused as it exited, before it
/// terminated.
class VMPauseExitEvent extends VMPauseEvent {
  VMPauseExitEvent._(Scope scope, Map json)
      : super._(scope, json);

  String toString() => "pause before exit";
}

/// An event indicating that an isolate was paused at a breakpoint or due to
/// stepping through code.
class VMPauseBreakpointEvent extends VMPauseEvent {
  /// The breakpoint that caused this pause event.
  final VMBreakpoint breakpoint;

  /// The list of breakpoints at the current execution point.
  final List<VMBreakpoint> breakpoints;

  VMPauseBreakpointEvent._(Scope scope, Map json)
      : breakpoint = newVMBreakpoint(scope, json["breakpoint"]),
        breakpoints = new List.unmodifiable(json["pauseBreakpoints"]
            .map((breakpoint) => newVMBreakpoint(scope, breakpoint))),
        super._(scope, json);

  String toString() => "pause at $breakpoint";
}

/// An event indicating that an isolate was paused due to an interruption.
///
/// This usually means its process received `SIGQUIT`.
class VMPauseInterruptedEvent extends VMPauseEvent {
  VMPauseInterruptedEvent._(Scope scope, Map json)
      : super._(scope, json);

  String toString() => "pause on interrupt";
}

/// An event indicating that an isolate was paused due to an exception.
class VMPauseExceptionEvent extends VMPauseEvent {
  /// The exception that caused the isolate to become paused.
  final VMInstanceRef exception;

  VMPauseExceptionEvent._(Scope scope, Map json)
      : exception = newVMInstanceRef(scope, json["exception"]),
        super._(scope, json);

  String toString() => "pause on exception";
}

/// An event indicating that an isolate was unpaused.
class VMResumeEvent extends VMPauseEvent {
  VMResumeEvent._(Scope scope, Map json)
      : super._(scope, json);

  String toString() => "resume";
}

/// An event indicating that an isolate was unpaused.
class VMNoneEvent extends VMPauseEvent {
  VMNoneEvent._(Scope scope, Map json)
      : super._(scope, json);

  String toString() => "none";
}
