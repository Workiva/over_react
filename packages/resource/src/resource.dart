// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import "dart:core" hide Resource;
import "dart:async" show Future, Stream;
import "dart:convert" show Encoding;

import "resource_loader.dart";
import "resolve.dart";

/// Base resource implementation.
class Resource {
  // Default implementation of a generic `Resource` class.
  //
  // Actually exposed `Resource` interfaces uses this as implementation,
  // but expose a different `Resource` class with plaform-dependent statics.
  // Requires a loader to be provided.

  /// Loading strategy for the resource.
  final ResourceLoader _loader;

  /// The URI of the resource.
  final _uri;

  const Resource(uri, ResourceLoader loader)
      : _uri = uri, _loader = loader;

  /// The location URI of this resource.
  ///
  /// This is a [Uri] of the `uri` parameter given to the constructor.
  /// If the parameter was a string that did not contain a valid URI,
  /// reading `uri` will fail.
  Uri get uri => (_uri is String) ? Uri.parse(_uri) : (_uri as Uri);

  /// Reads the resource content as a stream of bytes.
  Stream<List<int>> openRead() async* {
    Uri uri = await resolveUri(this.uri);
    yield* _loader.openRead(uri);
  }

  /// Reads the resource content as a single list of bytes.
  Future<List<int>> readAsBytes() async {
    Uri uri = await resolveUri(this.uri);
    return _loader.readAsBytes(uri);
  }

  /// Reads the resource content as a string.
  ///
  /// The content is decoded into a string using an [Encoding].
  /// If no encoding is provided, an encoding is chosen depending on the
  /// protocol and/or available metadata.
  Future<String> readAsString({Encoding encoding}) async {
    Uri uri = await resolveUri(this.uri);
    return _loader.readAsString(uri, encoding: encoding);
  }
}
