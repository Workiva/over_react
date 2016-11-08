// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:collection';

import 'package:stack_trace/stack_trace.dart';

import 'code.dart';
import 'error.dart';
import 'exceptions.dart';
import 'function.dart';
import 'instance.dart';
import 'scope.dart';
import 'source_location.dart';
import 'utils.dart';

VMFrame newVMFrame(Scope scope, Map json) {
  if (json == null) return null;
  assert(json["type"] == "Frame");
  return new VMFrame._(scope, json);
}

/// An active stack frame.
class VMFrame {
  final Scope _scope;

  /// The index of the frame in [VMStack.frames].
  ///
  /// The lower the index, the closer the frame to the point of execution. The
  /// actual point of execution has index 0.
  final int index;

  /// The function containing the frame.
  final VMFunctionRef function;

  /// The frame's code.
  final VMCodeRef code;

  /// The location of the frame in Dart source.
  final VMSourceLocation location;

  /// The local variables in the current frame, indexed by name.
  final Map<String, VMBoundVariable> variables;

  VMFrame._(Scope scope, Map json)
      : _scope = scope,
        index = json["index"],
        function = newVMFunctionRef(scope, json["function"]),
        code = newVMCodeRef(scope, json["code"]),
        location = newVMSourceLocation(scope, json["location"]),
        variables = new UnmodifiableMapView(new Map.fromIterable(json["vars"],
            key: (variable) => variable["name"],
            value: (variable) => new VMBoundVariable._(scope, variable)));

  /// Evaluates [expression] in the context of this frame.
  ///
  /// Throws a [VMErrorException] if evaluating the expression throws an error.
  /// Throws a [VMSentinelException] if this frame has expired.
  Future<VMInstanceRef> evaluate(String expression) async {
    var result = await _scope.sendRequest("evaluateInFrame", {
      "frameIndex": index,
      "expression": expression
    });

    switch (result["type"]) {
      case "@Error": throw new VMErrorException(newVMErrorRef(_scope, result));
      case "@Instance": return newVMInstanceRef(_scope, result);
      default:
        throw new StateError('Unexpected Object type "${result["type"]}".');
    }
  }

  /// Loads a `stack_trace` [Frame] that corresponds to this frame.
  Future<Frame> getFrame() async => frameToFrame(this);

  String toString() => "#$index in $function";
}

/// A local variable bound to a particular value in a [VMFrame].
class VMBoundVariable {
  /// The name of the variable.
  final String name;

  /// The value of the variable.
  ///
  /// If this variable is uninitialized, this will be
  /// [VMSentinel.notInitialized]. If it's currently being initialized, it will
  /// be [VMSentinel.beingInitialized]. If it's been optimized out, it will be
  /// [VMSentinel.optimizedOut]. Otherwise, it will be a [VMInstanceRef].
  final value;

  VMBoundVariable._(Scope scope, Map json)
      : name = json["name"],
        value = newVMInstanceRefOrSentinel(scope, json["value"]);

  String toString() => "var $name = $value";
}

