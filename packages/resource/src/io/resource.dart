// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import "dart:core" hide Resource;

import "loader.dart" show ResourceLoader, DefaultLoader;

// TODO(lrn): Merge with implementation when configured imports removes
// the need to share code.
import "../resource.dart" as base show Resource;

class Resource extends base.Resource {
  /// Creates a resource object with the given [uri] as location.
  ///
  /// The [uri] must be either a [Uri] or a string containing a valid URI.
  /// If the string is not a valid URI, using any of the functions on
  /// the resource object will fail.
  ///
  /// The URI may be relative, in which case it will be resolved
  /// against [Uri.base] before being used.
  ///
  /// The URI may use the `package` scheme, which is always supported.
  /// Other schemes may also be supported where possible.
  ///
  /// If [loader] is provided, it is used to load absolute non-package URIs.
  /// Package: URIs are resolved to a non-package URI before being loaded, so
  /// the loader doesn't have to support package: URIs, nor does it need to
  /// support relative URI references.
  /// If [loader] is omitted, a default implementation is used which supports
  /// as many of `http`, `https`, `file` and `data` as are available on the
  /// current platform.
  const Resource(uri, {ResourceLoader loader})
      : super(uri, (loader != null) ? loader : const DefaultLoader());
}
