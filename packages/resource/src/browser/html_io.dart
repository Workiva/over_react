// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import "dart:async" show Future, Stream;
import "dart:convert" show Encoding, LATIN1, UTF8;
import "dart:html";
import "dart:typed_data" show Uint8List, ByteBuffer;

/// Reads the bytes of a URI as a stream of bytes.
Stream<List<int>> readAsStream(Uri uri) async* {
  // TODO(lrn): Should file be run through XmlHTTPRequest too?
  if (uri.scheme == "http" || uri.scheme == "https") {
    // TODO: Stream in chunks if DOM has a way to do so.
    List<int> response = await _httpGetBytes(uri);
    yield response;
    return;
  }
  if (uri.scheme == "data") {
    yield uri.data.contentAsBytes();
    return;
  }
  throw new UnsupportedError("Unsupported scheme: $uri");
}

/// Reads the bytes of a URI as a list of bytes.
Future<List<int>> readAsBytes(Uri uri) async {
  if (uri.scheme == "http" || uri.scheme == "https") {
    return _httpGetBytes(uri);
  }
  if (uri.scheme == "data") {
    return uri.data.contentAsBytes();
  }
  throw new UnsupportedError("Unsupported scheme: $uri");
}

/// Reads the bytes of a URI as a string.
Future<String> readAsString(Uri uri, Encoding encoding) async {
  if (uri.scheme == "http" || uri.scheme == "https") {
    // Fetch as string if the encoding is expected to be understood,
    // otherwise fetch as bytes and do decoding using the encoding.
    if (encoding != null) {
      return encoding.decode(await _httpGetBytes(uri));
    }
    return HttpRequest.getString(uri.toString());
  }
  if (uri.scheme == "data") {
    return uri.data.contentAsString(encoding: encoding);
  }
  throw new UnsupportedError("Unsupported scheme: $uri");
}

Future<List<int>> _httpGetBytes(Uri uri) {
  return HttpRequest
      .request(uri.toString(), responseType: "arraybuffer")
      .then((request) {
    ByteBuffer data = request.response;
    return data.asUint8List();
  });
}
