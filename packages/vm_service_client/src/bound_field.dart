// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'field.dart';
import 'instance.dart';
import 'scope.dart';

VMBoundField newVMBoundField(Scope scope, Map json) {
  if (json == null) return null;
  return new VMBoundField._(scope, json);
}

/// An instance field bound to a particular value.
class VMBoundField {
  /// The declaration of this field.
  final VMFieldRef declaration;

  /// The value that the field is bound to.
  ///
  /// If this field is uninitialized, this will be [VMSentinel.notInitialized].
  /// If it's currently being initialized, it will be
  /// [VMSentinel.beingInitialized]. Otherwise, it will be a [VMInstanceRef].
  final value;

  VMBoundField._(Scope scope, Map json)
      : declaration = newVMFieldRef(scope, json["decl"]),
        value = newVMInstanceRefOrSentinel(scope, json["value"]);

  String toString() => "${declaration.description} = $value";
}
