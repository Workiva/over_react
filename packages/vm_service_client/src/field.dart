// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'class.dart';
import 'instance.dart';
import 'library.dart';
import 'object.dart';
import 'scope.dart';
import 'source_location.dart';

VMFieldRef newVMFieldRef(Scope scope, Map json) {
  if (json == null) return null;
  assert(json["type"] == "@Field" || json["type"] == "Field");
  return new VMFieldRef._(scope, json);
}

/// A reference to a field or variable.
class VMFieldRef implements VMObjectRef {
  final Scope _scope;

  /// The ID for this field, which is unique relative to its isolate.
  final String _id;

  /// Whether [_id] is guaranteed to be the same for different VM service field
  /// objects that refer to the same field.
  final bool _fixedId;

  /// The name of this field.
  final String name;

  /// The owner of this field.
  ///
  /// This is either a [VMLibraryRef] or a [VMClassRef].
  final VMObjectRef owner;

  /// The declared type of this field.
  final VMTypeLikeInstanceRef declaredType;

  /// Whether this is a const field.
  final bool isConst;

  /// Whether this is a final field.
  final bool isFinal;

  /// Whether this is a static field.
  final bool isStatic;

  /// The Dart declaration of this field, excluding its value.
  String get description {
    var buffer = new StringBuffer();
    if (isStatic && owner is! VMLibraryRef) buffer.write("static ");
    if (isConst) {
      buffer.write("const ");
    } else if (isFinal) {
      buffer.write("final ");
    }
    if (declaredType is! VMTypeInstanceRef ||
        (declaredType as VMTypeInstanceRef).name != "dynamic") {
      buffer.write("$declaredType ");
    } else if (!isConst && !isFinal) {
      buffer.write("var ");
    }
    buffer.write(name);
    return buffer.toString();
  }

  VMFieldRef._(Scope scope, Map json)
      : _scope = scope,
        _id = json["id"],
        _fixedId = json["fixedId"] ?? false,
        name = json["name"],
        owner = _newLibraryOrClassRef(scope, json["owner"]),
        declaredType = newVMTypeLikeInstanceRef(scope, json["declaredType"]),
        isConst = json["const"],
        isFinal = json["final"],
        isStatic = json["static"];

  /// Parses and returns either a [VMLibraryRef] or [VMClassRef].
  static VMObjectRef _newLibraryOrClassRef(Scope scope, Map json) {
    if (json == null) return null;
    switch (json["type"]) {
      case "@Library": return newVMLibraryRef(scope, json);
      case "@Class": return newVMClassRef(scope, json);
      default:
        throw new StateError('Unexpected Object type "${json["type"]}".');
    }
  }

  Future<VMField> load() async =>
      new VMField._(_scope, await _scope.loadObject(_id));

  bool operator ==(other) => other is VMFieldRef &&
      (_fixedId ? _id == other._id : super == other);

  int get hashCode => _fixedId ? _id.hashCode : super.hashCode;

  String toString() => "$description = ...";
}

/// A field or variable.
class VMField extends VMFieldRef implements VMObject {
  final VMClassRef klass;

  final int size;

  /// The value of this field.
  ///
  /// This will be `null` unless this is a static field. The values of
  /// non-static fields are available through [VMInstance.fields].
  final VMInstanceRef value;

  /// The lcoation of this field in the source code.
  final VMSourceLocation location;

  VMField._(Scope scope, Map json)
      : klass = newVMClassRef(scope, json["class"]),
        size = json["size"],
        value = newVMInstanceRef(scope, json["staticValue"]),
        location = newVMSourceLocation(scope, json["location"]),
        super._(scope, json);

  String toString() => "$description = ${value ?? '...'}";
}
