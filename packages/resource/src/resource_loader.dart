// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import "dart:async" show Future, Stream;
import "dart:convert" show Encoding;

/// Resource loading strategy.
///
/// An abstraction of the functionality needed to load resources.
///
/// Implementations of this interface decide which URI schemes they support.
abstract class ResourceLoader {
  /// Reads the file located by [uri] as a stream of bytes.
  Stream<List<int>> openRead(Uri uri);

  /// Reads the file located by [uri] as a list of bytes.
  Future<List<int>> readAsBytes(Uri uri);

  /// Reads the file located by [uri] as a [String].
  ///
  /// The file bytes are decoded using [encoding], if provided.
  ///
  /// If [encoding] is omitted, the default for the `file:` scheme is UTF-8.
  /// For `http`, `https` and `data` URIs, the Content-Type header's charset
  /// is used, if available and recognized by [Encoding.getByName],
  /// otherwise it defaults to Latin-1 for `http` and `https`
  /// and to ASCII for `data` URIs.
  Future<String> readAsString(Uri uri, {Encoding encoding});
}

