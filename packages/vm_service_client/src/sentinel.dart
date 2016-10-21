// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

VMSentinel newVMSentinel(Map json) {
  assert(json["type"] == "Sentinel");
  switch (json["kind"]) {
    case "Collected": return VMSentinel.collected;
    case "Expired": return VMSentinel.expired;
    case "NotInitialized": return VMSentinel.notInitialized;
    case "BeingInitialized": return VMSentinel.beingInitialized;
    case "OptimizedOut": return VMSentinel.optimizedOut;
    case "Free": return VMSentinel.free;
    default: throw new StateError('Unknown Sentinel kind "${json["kind"]}".');
  }
}

/// A value that indicates that an object on the remote VM is no longer
/// available.
class VMSentinel {
  /// The object has been collected by the GC.
  static const collected = const VMSentinel._("collected");

  /// The object's ID has expired.
  static const expired = const VMSentinel._("expired");

  /// The variable or field hasn't been initialized.
  static const notInitialized = const VMSentinel._("not initialized");

  /// The variable or field is in the process of being initialized.
  static const beingInitialized = const VMSentinel._("being initialized");

  /// The variable has been eliminated by the optimizing compiler.
  static const optimizedOut = const VMSentinel._("optimized out");

  /// Reserved for future use.
  static const free = const VMSentinel._("free");

  /// The human-readable name of the sentinel.
  final String _name;

  const VMSentinel._(this._name);

  String toString() => "<$_name>";
}
