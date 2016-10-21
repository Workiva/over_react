// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:collection';

import 'class.dart';
import 'field.dart';
import 'function.dart';
import 'instance.dart';
import 'object.dart';
import 'scope.dart';
import 'script.dart';

VMLibraryRef newVMLibraryRef(Scope scope, Map json) {
  if (json == null) return null;
  assert(json["type"] == "@Library" || json["type"] == "Library");
  return new VMLibraryRef._(scope, json);
}

/// A reference to a Dart library—that is, a single importable Dart file.
class VMLibraryRef implements VMObjectRef {
  final Scope _scope;

  /// The ID for this library, which is unique relative to its isolate.
  final String _id;

  /// Whether [_id] is guaranteed to be the same for different VM service
  /// library objects that refer to the same library.
  final bool _fixedId;

  /// The name of this library, derived from its library tag.
  final String name;

  /// The canonical URI for this library.
  final Uri uri;

  VMLibraryRef._(this._scope, Map json)
      : _id = json["id"],
        _fixedId = json["fixedId"] ?? false,
        name = json["name"],
        uri = Uri.parse(json["uri"]);

  Future<VMLibrary> load() async =>
      new VMLibrary._(_scope, await _scope.loadObject(_id));

  /// Enables breakpoints and stepping for this library.
  Future setDebuggable() async {
    await _scope.sendRequest("setLibraryDebuggable", {
      "libraryId": _id,
      "isDebuggable": true
    });
  }

  /// Disables breakpoints and stepping for this library.
  Future setNotDebuggable() async {
    await _scope.sendRequest("setLibraryDebuggable", {
      "libraryId": _id,
      "isDebuggable": false
    });
  }

  /// Evaluates [expression] in the context of this library.
  ///
  /// Throws a [VMErrorException] if evaluating the expression throws an error.
  Future<VMInstanceRef> evaluate(String expression) =>
      _scope.evaluate(_id, expression);

  bool operator ==(other) => other is VMLibraryRef &&
      (_fixedId ? _id == other._id : super == other);

  int get hashCode => _fixedId ? _id.hashCode : super.hashCode;

  String toString() => uri.toString();
}

/// A a Dart library—that is, a single importable Dart file.
class VMLibrary extends VMLibraryRef implements VMObject {
  final VMClassRef klass;

  final int size;

  /// Whether breakpoints and stepping are enabled for this library.
  final bool isDebuggable;

  /// The imports and exports for this library.
  final List<VMLibraryDependency> dependencies;

  /// The scripts that make up the library.
  ///
  /// Most libraries have only one script, but the `part` directive means that
  /// it can have multiple.
  final List<VMScriptRef> scripts;

  /// The fields defined in this library, indexed by name.
  final Map<String, VMFieldRef> fields;

  /// The top-level functions defined in this library, indexed by name.
  final Map<String, VMFunctionRef> functions;

  /// The classes defined in this library, indexed by name.
  final Map<String, VMClassRef> classes;

  VMLibrary._(Scope scope, Map json)
      : klass = newVMClassRef(scope, json["class"]),
        size = json["size"],
        isDebuggable = json["debuggable"],
        dependencies = new List.unmodifiable(json["dependencies"]
            .map((dependency) => new VMLibraryDependency._(scope, dependency))),
        scripts = new List.unmodifiable(json["scripts"]
            .map((script) => newVMScriptRef(scope, script))),
        fields = new UnmodifiableMapView(new Map.fromIterable(json["variables"],
            key: (field) => field["name"],
            value: (field) => newVMFieldRef(scope, field))),
        functions = new UnmodifiableMapView(
            new Map.fromIterable(json["functions"],
                key: (function) => function["name"],
                value: (function) => newVMFunctionRef(scope, function))),
        classes = new UnmodifiableMapView(new Map.fromIterable(json["classes"],
            key: (klass) => klass["name"],
            value: (klass) => newVMClassRef(scope, klass))),
        super._(scope, json);
}

/// A single dependency—that is, an import or an export.
class VMLibraryDependency {
  /// Whether this is an import.
  ///
  /// This is always the opposite of [isExport].
  final bool isImport;

  /// Whether this is an export.
  ///
  /// This is always the opposite of [isImport].
  bool get isExport => !isImport;

  /// Whether this is a deferred import.
  final bool isDeferred;

  /// The prefix for this import, or `null` if it's unprefixed or an export.
  final String prefix;

  /// The library that's imported or exported.
  final VMLibraryRef target;

  VMLibraryDependency._(Scope scope, Map json)
      : isImport = json["isImport"],
        isDeferred = json["isDeferred"],
        prefix = json["prefix"],
        target = new VMLibraryRef._(scope, json["target"]);

  String toString() {
    var buffer = new StringBuffer(isImport ? "import" : "export");
    buffer.write(' "${target.uri}"');
    if (isDeferred) buffer.write(" deferred");
    if (prefix != null) buffer.write(" as $prefix");
    return buffer.toString();
  }
}
