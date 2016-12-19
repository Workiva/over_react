// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:stack_trace/stack_trace.dart';

import 'frame.dart';
import 'message.dart';
import 'scope.dart';
import 'script.dart';
import 'utils.dart';

VMStack newVMStack(Scope scope, Map json) {
  if (json == null) return null;
  assert(json["type"] == "Stack");
  return new VMStack._(scope, json);
}

/// The current execution stack and message queue for an isolate.
class VMStack {
  /// The current execution stack.
  ///
  /// The earlier a frame appears in this list, the closer to the current point
  /// of execution. This will be empty if the isolate is not currently executing
  /// any Dart code.
  final List<VMFrame> frames;

  /// The current message queue.
  ///
  /// The earlier a message appears in this list, the earlier it will be
  /// processed.
  final List<VMMessage> messages;

  VMStack._(Scope scope, Map json)
      : frames = new List.unmodifiable(json["frames"]
            .map((frame) => newVMFrame(scope, frame))),
        messages = new List.unmodifiable(json["messages"]
            .map((message) => newVMMessage(scope, message)));

  /// Returns the trace of this stack.
  Future<Trace> getTrace() async {
    var scripts = <String, VMScript>{};
    return new Trace(await Future.wait(
        frames.map((frame) => frameToFrame(frame, scripts))));
  }
}
