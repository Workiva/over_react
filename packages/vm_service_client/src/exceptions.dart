// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'error.dart';
import 'sentinel.dart';
import 'service_version.dart';

/// An exception thrown when the client attempts to load a remote object that's
/// no longer available.
class VMSentinelException implements Exception {
  /// The sentinel indicating what happened to the remote object.
  final VMSentinel sentinel;

  VMSentinelException(this.sentinel);

  String toString() => "Unexpected $sentinel sentinel.";
}

/// An exception that represents a Dart exception in the remote VM.
class VMErrorException implements Exception {
  /// The error in the remote VM.
  final VMErrorRef error;

  VMErrorException(this.error);

  String toString() => "Remote VM ${error.kind}: ${error.message}";
}

/// An exception indicating that the VM service client doesn't support the
/// current protocol version.
class VMUnsupportedVersionException implements Exception {
  /// The version reported by the VM service protocol.
  ///
  /// This may be `null` if the reported version isn't in a format the client
  /// understands.
  final VMServiceVersion version;

  VMUnsupportedVersionException([this.version]);

  String toString() => version == null
      ? "The VM service protocol is an unsupported version."
      : "The VM service protocol is unsupported version $version.";
}
