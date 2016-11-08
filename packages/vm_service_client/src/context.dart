// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'class.dart';
import 'instance.dart';
import 'object.dart';
import 'scope.dart';

VMContextRef newVMContextRef(Scope scope, Map json) {
  if (json == null) return null;
  assert(json["type"] == "@Context" || json["type"] == "Context");
  return new VMContextRef._(scope, json);
}

/// A reference to the captured variables for a closure.
class VMContextRef implements VMObjectRef {
  final Scope _scope;

  /// The ID for this context, which is unique relative to its isolate.
  final String _id;

  /// Whether [_id] is guaranteed to be the same for different VM service
  /// context objects that refer to the same context.
  final bool _fixedId;

  /// The number of variables in this context.
  final int length;

  VMContextRef._(Scope scope, Map json)
      : _scope = scope,
        _id = json["id"],
        _fixedId = json["fixedId"] ?? false,
        length = json["length"];

  Future<VMContext> load() async =>
      new VMContext._(_scope, await _scope.loadObject(_id));

  bool operator ==(other) => other is VMContextRef &&
      (_fixedId ? _id == other._id : super == other);

  int get hashCode => _fixedId ? _id.hashCode : super.hashCode;
}

/// The captured variables for a closure.
class VMContext extends VMContextRef implements VMObject {
  final int size;

  final VMClassRef klass;

  /// The enclosing context, or `null`.
  final VMContextRef parent;

  /// The variables in this context.
  ///
  /// Each element is either a [VMInstanceRef] or a [VMSentinel].
  final List variables;

  VMContext._(Scope scope, Map json)
      : size = json["size"],
        klass = newVMClassRef(scope, json["class"]),
        parent = newVMContextRef(scope, json["parent"]),
        variables = new List.unmodifiable(json["variables"]
            .map((variable) =>
                newVMInstanceRefOrSentinel(scope, variable["value"]))),
        super._(scope, json);
}
