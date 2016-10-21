// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

const v1CompatibilityTransformer = const _V1CompatibilityTransformer();

class _V1CompatibilityTransformer implements StreamTransformer {
  const _V1CompatibilityTransformer();

  Stream bind(Stream stream) {
    return stream.map((event) {
      // The V1 protocol didn't support batching.
      if (event is! Map) return event;

      // The V1 protocol never included the proper "jsonrpc" key.
      if (event.containsKey("jsonrpc")) return event;

      event = new Map.from(event);

      // Some V1 protocol events did include an incorrect "json-rpc" key.
      event.remove("jsonrpc");
      event["json-rpc"] = "2.0";

      // The V1 protocol used a non-standard event format.
      if (event.containsKey("event")) {
        event["method"] = "streamNotify";
        event["params"] = {
          "streamId": event.remove("streamId"),
          "event": event.remove("event")
        };
      }

      // The V1 protocol converted ints to strings. The json_rpc_2 package
      // always uses int IDs.
      event["id"] = int.parse(event["id"]);

      return event;
    });
  }
}
