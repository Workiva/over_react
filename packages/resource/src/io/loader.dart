// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import "dart:async" show Future, Stream;
import "dart:convert" show Encoding;

import "../resource_loader.dart" as base;
import "../package_loader.dart"as base;
import "io.dart" as io;

/// Resource loading strategy.
///
/// An abstraction of the functionality needed to load resources.
///
/// Implementations of this interface decide which URI schemes they support.
abstract class ResourceLoader implements base.ResourceLoader {
  /// A resource loader that can load as many of the following URI
  /// schemes as are supported by the platform:
  /// * file
  /// * http
  /// * https
  /// * data
  /// * package
  ///
  /// (For example, file: URIs are not supported in the browser).
  /// Relative URI references are accepted - they are resolved against
  /// [Uri.base] before being loaded.
  static ResourceLoader get defaultLoader =>
      const PackageLoader(const DefaultLoader());
}

/// Default implementation of [ResourceLoader]..
///
/// Uses the system's available loading functionality to implement the
/// loading functions.
///
/// Supports as many of `http:`, `https:`, `file:` and `data:` URIs as
/// possible.
class DefaultLoader implements ResourceLoader {
  const DefaultLoader();

  Stream<List<int>> openRead(Uri uri) => io.readAsStream(uri);

  Future<List<int>> readAsBytes(Uri uri) => io.readAsBytes(uri);

  Future<String> readAsString(Uri uri, {Encoding encoding}) =>
      io.readAsString(uri, encoding);
}

// A loader that implements base.PackageLoader *and* ResourceLoader from this
// file.
class PackageLoader extends base.PackageLoader implements ResourceLoader {
  const PackageLoader(ResourceLoader loader) : super(loader);
}
