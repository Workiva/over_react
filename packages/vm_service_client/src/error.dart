// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:stack_trace/stack_trace.dart';

import 'class.dart';
import 'instance.dart';
import 'object.dart';
import 'scope.dart';

VMErrorRef newVMErrorRef(Scope scope, Map json) {
  if (json == null) return null;
  assert(json["type"] == "@Error" || json["type"] == "Error");
  return new VMErrorRef._(scope, json);
}

VMErrorRef newVMError(Scope scope, Map json) {
  if (json == null) return null;
  assert(json["type"] == "Error");
  return new VMError._(scope, json);
}

/// A reference to a Dart language error.
class VMErrorRef implements VMObjectRef {
  final Scope _scope;

  /// The ID for the error, which is unique relative to its isolate.
  final String _id;

  /// Whether [_id] is guaranteed to be the same for different VM service error
  /// objects that refer to the same error.
  final bool _fixedId;

  /// The kind of error this is.
  final VMErrorKind kind;

  /// The error message.
  final String message;

  VMErrorRef._(this._scope, Map json)
      : _id = json["id"],
        _fixedId = json["fixedId"] ?? false,
        kind = new VMErrorKind._parse(json["kind"]),
        message = json["message"];

  Future<VMError> load() async =>
      new VMError._(_scope, await _scope.loadObject(_id));

  bool operator ==(other) => other is VMErrorRef &&
      (_fixedId ? _id == other._id : super == other);

  int get hashCode => _fixedId ? _id.hashCode : super.hashCode;

  String toString() => "$kind: $message";
}

/// A Dart language error.
class VMError extends VMErrorRef implements VMObject {
  final VMClassRef klass;

  final int size;

  /// The exception that caused the error.
  ///
  /// Note that for asynchonous errors prior to VM service version 3.0, this
  /// may be a wrapped instance of [AsyncError].
  final VMInstanceRef exception;

  /// The stack trace for the error.
  ///
  /// This can be accessed as a local trace using [getTrace].
  ///
  /// Note that for asynchonous errors prior to VM service version 3.0,
  /// [exception] may be an instance of [AsyncError], in which case that error
  /// contains the original stack trace.
  final VMInstanceRef stackTrace;

  VMError._(Scope scope, Map json)
      : klass = newVMClassRef(scope, json["class"]),
        size = json["size"],
        exception = newVMInstanceRef(scope, json["exception"]),
        stackTrace = newVMInstanceRef(scope, json["stacktrace"]),
        super._(scope, json);

  /// Loads the error's stack trace as a concrete Dart stack trace.
  ///
  /// If the original stack trace was a [Chain], this returns a [Chain].
  /// Otherwise, it returns a [Trace].
  Future<StackTrace> getTrace() async {
    var vmTrace = stackTrace;
    if (exception.klass.name == '_UncaughtAsyncError') {
      vmTrace = (await exception.load()).fields['stackTrace'].value;
    }

    if (vmTrace is VMStackTraceInstanceRef) return vmTrace.value;

    VMStringInstanceRef contents = await vmTrace.evaluate("toString()");
    if (contents.isValueTruncated) contents = await contents.load();
    return new Chain.parse(contents.value);
  }
}

/// An enum of different kinds of Dart errors.
class VMErrorKind {
  /// A Dart exception with no handler.
  static const unhandledException = const VMErrorKind._("UnhandledException");

  /// An error caused by invalid Dart code.
  static const languageError = const VMErrorKind._("LanguageError");

  /// An internal error.
  ///
  /// These errors should not be exposed—if seen, they should be [reported as
  /// bugs](https://github.com/dart-lang/sdk/issues/new).
  static const internalError = const VMErrorKind._("InternalError");

  /// The isolate has been terminated from an external source.
  static const terminationError = const VMErrorKind._("TerminationError");

  /// The name of the error.
  final String name;

  /// Parses the error from its service protocol name.
  factory VMErrorKind._parse(String name) {
    switch (name) {
      case "UnhandledException": return VMErrorKind.unhandledException;
      case "LanguageError": return VMErrorKind.languageError;
      case "InternalError": return VMErrorKind.internalError;
      case "TerminationError": return VMErrorKind.terminationError;
      default: throw new StateError("Unknown VM error kind \"$name\".");
    }
  }

  const VMErrorKind._(this.name);

  String toString() => name;
}
