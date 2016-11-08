// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'class.dart';
import 'object.dart';
import 'scope.dart';

VMCodeRef newVMCodeRef(Scope scope, Map json) {
  if (json == null) return null;
  assert(json["type"] == "@Code" || json["type"] == "Code");
  return new VMCodeRef._(scope, json);
}

/// A reference to compiled code in the Dart VM.
class VMCodeRef implements VMObjectRef {
  final Scope _scope;

  /// The ID for this code, which is unique relative to its isolate.
  final String _id;

  /// Whether [_id] is guaranteed to be the same for different VM service code
  /// objects that refer to the same code.
  final bool _fixedId;

  /// This code's name.
  final String name;

  /// The type of code this is.
  final VMCodeKind kind;

  VMCodeRef._(this._scope, Map json)
      : _id = json["id"],
        _fixedId = json["fixedId"] ?? false,
        name = json["name"],
        kind = new VMCodeKind._parse(json["kind"]);

  Future<VMCode> load() async =>
      new VMCode._(_scope, await _scope.loadObject(_id));

  bool operator ==(other) => other is VMCodeRef &&
      (_fixedId ? _id == other._id : super == other);

  int get hashCode => _fixedId ? _id.hashCode : super.hashCode;

  String toString() {
    // For stubs, the name already includes "[Stub]".
    if (kind == VMCodeKind.stub) return name;
    return "$name ($kind)";
  }
}

/// Compiled code in the Dart VM.
class VMCode extends VMCodeRef implements VMObject {
  final VMClassRef klass;

  final int size;

  VMCode._(Scope scope, Map json)
      : klass = newVMClassRef(scope, json["class"]),
        size = json["size"],
        super._(scope, json);
}

/// An enum of types of code.
class VMCodeKind {
  /// User-authored Dart code.
  static const dart = const VMCodeKind._("Dart");

  /// Native C++ code.
  static const native = const VMCodeKind._("Native");

  /// A stub that hasn't yet been parsed compiled.
  static const stub = const VMCodeKind._("Stub");

  static const tag = const VMCodeKind._("Tag");

  /// Code that's been garbage-collected.
  static const collected = const VMCodeKind._("Collected");

  /// The name of the kind of code.
  final String name;

  factory VMCodeKind._parse(String name) {
    switch (name) {
      case "Dart": return VMCodeKind.dart;
      case "Native": return VMCodeKind.native;
      case "Stub": return VMCodeKind.stub;
      case "Tag": return VMCodeKind.tag;
      case "Collected": return VMCodeKind.collected;
      default: throw new StateError("Unknown VM code kind \"$name\".");
    }
  }

  const VMCodeKind._(this.name);

  String toString() => name;
}
