// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:collection';

import 'error.dart';
import 'field.dart';
import 'function.dart';
import 'instance.dart';
import 'library.dart';
import 'object.dart';
import 'scope.dart';
import 'source_location.dart';

VMClassRef newVMClassRef(Scope scope, Map json) {
  if (json == null) return null;
  assert(json["type"] == "@Class" || json["type"] == "Class");
  return new VMClassRef._(scope, json);
}

/// A reference to a Dart class.
class VMClassRef implements VMObjectRef {
  final Scope _scope;

  /// The ID for this class, which is unique relative to its isolate.
  final String _id;

  /// Whether [_id] is guaranteed to be the same for different VM service class
  /// objects that refer to the same class.
  final bool _fixedId;

  /// The name of this class.
  final String name;

  VMClassRef._(this._scope, Map json)
      : _id = json["id"],
        _fixedId = json["fixedId"] ?? false,
        name = json["name"];

  Future<VMClass> load() async => new VMClass._(
      _scope, await _scope.loadObject(_id));

  /// Evaluates [expression] in the context of this class.
  ///
  /// Throws a [VMErrorException] if evaluating the expression throws an error.
  Future<VMInstanceRef> evaluate(String expression) =>
      _scope.evaluate(_id, expression);

  bool operator ==(other) => other is VMClassRef &&
      (_fixedId ? _id == other._id : super == other);

  int get hashCode => _fixedId ? _id.hashCode : super.hashCode;

  String toString() => name;
}

/// A Dart class.
class VMClass extends VMClassRef implements VMObject {
  final VMClassRef klass;

  final int size;

  /// The error that occurred during class finalization, or `null` if no error
  /// occurred.
  final VMErrorRef error;

  /// Whether this class is abstract.
  final bool isAbstract;

  /// Whether this class is const.
  final bool isConst;

  /// The library that contains this class.
  final VMLibraryRef library;

  /// The location of this class in the isolate's source code.
  final VMSourceLocation location;

  /// The superclass of this class, or `null` if it has no superclass.
  final VMClassRef superclass;

  /// This class's interface types.
  final List<VMTypeInstanceRef> interfaces;

  /// The fields defined in this class, indexed by name.
  ///
  /// This doesn't include fields from superclasses.
  final Map<String, VMFieldRef> fields;

  /// The functions defined in this class, indexed by name.
  ///
  /// This includes both static and instance functions, but doesn't include
  /// functions from superclasses.
  final Map<String, VMFunctionRef> functions;

  /// This class's subclasses.
  final List<VMClassRef> subclasses;

  VMClass._(Scope scope, Map json)
      : klass = new VMClassRef._(scope, json["class"]),
        size = json["size"],
        error = newVMErrorRef(scope, json["error"]),
        isAbstract = json["abstract"],
        isConst = json["const"],
        library = newVMLibraryRef(scope, json["library"]),
        location = newVMSourceLocation(scope, json["location"]),
        superclass = newVMClassRef(scope, json["super"]),
        interfaces = new List.unmodifiable(json["interfaces"]
            .map((interfaceJson) =>
                newVMTypeInstanceRef(scope, interfaceJson))),
        fields = new UnmodifiableMapView(new Map.fromIterable(json["fields"],
            key: (field) => field["name"],
            value: (field) => newVMFieldRef(scope, field))),
        functions = new UnmodifiableMapView(
            new Map.fromIterable(json["functions"],
                key: (function) => function["name"],
                value: (function) => newVMFunctionRef(scope, function))),
        subclasses = new List.unmodifiable(json["subclasses"]
            .map((subclass) => newVMClassRef(scope, subclass))),
        super._(scope, json);
}
