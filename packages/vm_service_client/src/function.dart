// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:json_rpc_2/json_rpc_2.dart' as rpc;

import 'breakpoint.dart';
import 'class.dart';
import 'code.dart';
import 'library.dart';
import 'object.dart';
import 'scope.dart';
import 'source_location.dart';

VMFunctionRef newVMFunctionRef(Scope scope, Map json) {
  if (json == null) return null;
  assert(json["type"] == "@Function" || json["type"] == "Function");
  return new VMFunctionRef._(scope, json);
}

/// A reference to a Dart function or method.
class VMFunctionRef implements VMObjectRef {
  final Scope _scope;

  /// The ID for this function, which is unique relative to its isolate.
  final String _id;

  /// Whether [_id] is guaranteed to be the same for different VM service
  /// function objects that refer to the same function.
  final bool _fixedId;

  /// The name of this function.
  final String name;

  /// The owner of this function.
  ///
  /// This is either a [VMClassRef], a [VMLibraryRef], or another
  /// [VMFunctionRef].
  final VMObjectRef owner;

  /// Whether this is a static function.
  final bool isStatic;

  /// Whether this is a const function—that is, a const constructor.
  final bool isConst;

  VMFunctionRef._(Scope scope, Map json)
      : _scope = scope,
        _id = json["id"],
        _fixedId = json["fixedId"] ?? false,
        name = json["name"],
        owner = _owner(scope, json["owner"]),
        isStatic = json["static"],
        isConst = json["const"];

  /// Parses and returns the a library, class, or function.
  static VMObjectRef _owner(Scope scope, Map json) {
    if (json == null) return null;
    switch (json["type"]) {
      case "@Library": return newVMLibraryRef(scope, json);
      case "@Class": return newVMClassRef(scope, json);
      case "@Function": return newVMFunctionRef(scope, json);
      default: throw new StateError('Unknown owner type "${json["type"]}".');
    }
  }

  Future<VMFunction> load() async =>
      new VMFunction._(_scope, await _scope.loadObject(_id));

  /// Adds a breakpoint at the entrypoint of this function.
  ///
  /// If no breakpoint is possible for this function, this will throw an
  /// [rpc.RpcException] with code `102`.
  Future<VMBreakpoint> addBreakpoint() async {
    try {
      var response = await _scope.sendRequest(
          "addBreakpointAtEntry", {"functionId": _id});
      return newVMBreakpoint(_scope, response);
    } on rpc.RpcException catch (error) {
      // Error 102 indicates that the breakpoint couldn't be created.
      if (error.code == 102) return null;
      rethrow;
    }
  }

  bool operator ==(other) => other is VMFunctionRef &&
      (_fixedId ? _id == other._id : super == other);

  int get hashCode => _fixedId ? _id.hashCode : super.hashCode;

  String toString() {
    var buffer = new StringBuffer();
    if (isStatic && owner is VMClassRef) buffer.write("static ");
    if (isConst) buffer.write("const ");
    buffer.write(name);
    return buffer.toString();
  }
}

/// A Dart function or method.
class VMFunction extends VMFunctionRef implements VMObject {
  final int size;

  final VMClassRef klass;

  /// The location of this function in the source code.
  final VMSourceLocation location;

  /// The function's code.
  final VMCodeRef code;

  VMFunction._(Scope scope, Map json)
      : size = json["size"],
        klass = newVMClassRef(scope, json["class"]),
        location = newVMSourceLocation(scope, json["location"]),
        code = newVMCodeRef(scope, json["code"]),
        super._(scope, json);
}
