// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:collection/collection.dart';

List<VMFlag> newVMFlagList(Map json) {
  if (json == null) return null;
  return new _FlagList(json);
}

/// A delegating list that improves the `toString()` to only include modified
/// flags.
class _FlagList extends DelegatingList<VMFlag> {
  _FlagList(Map json)
      : super(json["flags"].map((flag) => new VMFlag._(flag)).toList());

  String toString() {
    return "[" + super.where((flag) => flag.modified).join(", ") + ", ...]";
  }
}

/// A flag passed to the VM.
class VMFlag {
  /// The name of the flag.
  final String name;

  /// A short description of the flag.
  final String comment;

  /// Whether the flag has been modified from its default setting.
  ///
  /// As of VM service version 3.0, this reflects the VM's internal notion of
  /// whether the flag has been set, which may be different than whether the
  /// user set them explicitly.
  final bool modified;

  /// The value passed to the flag, or `null` if it has no value.
  final String value;

  VMFlag._(Map json)
      : name = json["name"],
        comment = json["comment"],
        modified = json["modified"],
        value = json["valueAsString"];

  String toString() {
    var result = "--$name";
    if (value != null) result += "=$value";
    return result;
  }
}
