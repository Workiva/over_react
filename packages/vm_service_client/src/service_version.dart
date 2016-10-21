// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

VMServiceVersion newVMServiceVersion(Map json) {
  if (json == null) return null;
  assert(json["type"] == "Version");
  return new VMServiceVersion._(json);
}

/// The version of the VM service protocol (*not* the Dart VM itself).
class VMServiceVersion {
  /// The major version.
  ///
  /// This is incremented when the protocol is changed in a potentially-breaking
  /// way.
  final int major;

  /// The minor version.
  ///
  /// This is incremented when the protocol is changed in a backwards-compatible
  /// way.
  final int minor;

  VMServiceVersion._(Map json)
      : major = json["major"],
        minor = json["minor"];

  String toString() => "$major.$minor";
}
