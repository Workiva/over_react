// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'class.dart';

/// A reference to persistent service-protocol object that's local to an
/// isolate.
///
/// Protocol objects include but are not limited to instances of Dart classes.
/// Equality for an object is based on the identity of the remote object where
/// that's available. Otherwise, it's based on local Dart object identity.
///
/// Most objects will have only a subset of their information available as a
/// reference, and must be [load]ed to retrieve their full information.
abstract class VMObjectRef {
  /// Loads a full version of this object.
  ///
  /// This will throw a [VMSentinelException] if this object is no longer
  /// available. This will contain [VMSentinel.expired] if this object was
  /// temporary and has expired, and [VMSentinel.collected] if this was a heap
  /// object that has been collected or a non-heap object that has been
  /// deleted.
  Future<VMObject> load();
}

/// A persistent service-protocol object that's local to an isolate.
abstract class VMObject implements VMObjectRef {
  /// This object's class, or `null` if this object wasn't allocated on the Dart
  /// heap.
  ///
  /// Objects that aren't [VMInstance]s will have internal VM classes.
  ///
  /// Moving an object onto or off of the heap is considered an implementation
  /// detail for objects other than instances.
  VMClassRef get klass;

  /// The size (in bytes) of this object on the heap.
  ///
  /// If an object is not heap-allocated, this will be `null`.
  ///
  /// Note that the size can be zero for some objects. In the current VM
  /// implementation, this occurs for small integers, which are stored entirely
  /// within their object pointers.
  int get size;
}
