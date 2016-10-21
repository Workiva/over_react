// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:json_rpc_2/json_rpc_2.dart' as rpc;

/// A class that exposes the service protocol's event streams.
///
/// This ensures that the protocol only sends events for streams that have
/// listeners. It doesn't do any parsing of the events, and exposes them as raw
/// JSON maps.
///
/// All streams are exposed as broadcast streams.
class StreamManager {
  /// The underlying JSON-RPC 2.0 peer used to communicate with the VM service.
  final rpc.Peer _peer;

  /// Events related to the whole VM.
  Stream<Map> get vm => _vmController.stream;
  StreamController<Map> _vmController;

  /// Events related to isolate lifecycles.
  Stream<Map> get isolate => _isolateController.stream;
  StreamController<Map> _isolateController;

  /// Events related to debugging.
  Stream<Map> get debug => _debugController.stream;
  StreamController<Map> _debugController;

  /// Garbage collection events.
  Stream<Map> get gc => _gcController.stream;
  StreamController<Map> _gcController;

  /// Data written to standard output.
  Stream<Map> get stdout => _stdoutController.stream;
  StreamController<Map> _stdoutController;

  /// Data written to standard error.
  Stream<Map> get stderr => _stderrController.stream;
  StreamController<Map> _stderrController;

  /// Custom events posted using `postEvent` from `dart:developer`.
  Stream<Map> get extension => _extensionController.stream;
  StreamController<Map> _extensionController;

  /// A subscription to [debug].
  ///
  /// This subscription fires no events, but it exists as long as there's also a
  /// subscription to [stdout] or [stderr] to work around sdk#24350.
  StreamSubscription _debugSubscription;

  StreamManager(this._peer) {
    _isolateController = _controller("Isolate");
    _vmController = _controller("VM");
    _debugController = _controller("Debug");
    _gcController = _controller("GC");
    _stdoutController = _controller("Stdout");
    _stderrController = _controller("Stderr");
    _extensionController = _controller("Extension");

    _peer.registerMethod("streamNotify", (params) {
      switch (params["streamId"].asString) {
        case "VM":
          _vmController.add(params["event"].asMap);
          break;
        case "Isolate":
          _isolateController.add(params["event"].asMap);
          break;
        case "Debug":
          _debugController.add(params["event"].asMap);
          break;
        case "GC":
          _gcController.add(params["event"].asMap);
          break;
        case "Stdout":
          _stdoutController.add(params["event"].asMap);
          break;
        case "Stderr":
          _stderrController.add(params["event"].asMap);
          break;
        case "Extension":
          _extensionController.add(params["event"].asMap);
          break;
      }
    });

    _peer.done.then((_) {
      _vmController.close();
      _isolateController.close();
      _debugController.close();
      _gcController.close();
      _stderrController.close();
      _stdoutController.close();
      _extensionController.close();
    }, onError: (_) {});
  }

  /// Returns a broadcast [StreamController] for the stream with [streamID].
  ///
  /// This controller subscribes to the stream when it has a listener and
  /// unsubscribes once it has no listeners.
  StreamController<Map> _controller(String streamID) {
    var controller;
    controller = new StreamController.broadcast(sync: true, onListen: () {
      // Work around sdk#24350.
      if ((streamID == "Stdout" || streamID == "Stderr") &&
          _debugSubscription == null) {
        _debugSubscription = debug.listen(null);
      }

      _peer.sendRequest("streamListen", {
        "streamId": streamID
      }).catchError((error, stackTrace) {
        controller.addError(error, stackTrace);
      });
    }, onCancel: () {
      if (_peer.isClosed) return;

      // Work around sdk#24350.
      if (_debugSubscription != null &&
          !_stdoutController.hasListener &&
          !_stderrController.hasListener) {
        _debugSubscription.cancel();
        _debugSubscription = null;
      }

      _peer.sendRequest("streamCancel", {
        "streamId": streamID
      }).catchError((_) {
        // Do nothing if canceling the stream failed, since no one's listening
        // to it anyway.
      });
    });
    return controller;
  }
}
