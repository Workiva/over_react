// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:json_rpc_2/json_rpc_2.dart' as rpc;

import 'error.dart';
import 'exceptions.dart';
import 'instance.dart';
import 'sentinel.dart';
import 'stream_manager.dart';

/// A class representing the state inherent in the scope of a single isolate and
/// the values available therein.
class Scope {
  /// The JSON-RPC 2.0 peer for communicating with the service protocol.
  final rpc.Peer peer;

  /// The streams shared among the entire service protocol client.
  final StreamManager streams;

  /// The ID of this scope's isolate.
  ///
  /// This is necessary for all isolate-scoped RPCs.
  final String isolateId;

  Scope(this.peer, this.streams, this.isolateId);

  /// Given the ID for a [VMObjectRef], loads the JSON for its corresponding
  /// [VMObject].
  ///
  /// If the `getObject` RPC returns a sentinel, this throws a
  /// [VMSentinelException].
  Future<Map> loadObject(String id) async {
    var result = await sendRequest("getObject", {"objectId": id});

    if (result["type"] == "Sentinel") {
      throw new VMSentinelException(newVMSentinel(result));
    }

    return result;
  }

  /// Calls an isolate-scoped RPC named [method] with [params].
  ///
  /// This always adds the `isolateId` parameter to the RPC.
  Future<Object> sendRequest(String method, [Map<String, Object> params]) async {
    var allParams = {"isolateId": isolateId}..addAll(params ?? {});
    return await peer.sendRequest(method, allParams);
  }

  /// Evaluates [expression] in the context of the object identified by [id].
  ///
  /// Throws a [VMErrorException] if evaluating the expression throws an error.
  /// Throws a [VMSentinelException] if the object has expired.
  Future<VMInstanceRef> evaluate(String id, String expression) async {
    var result = await sendRequest("evaluate", {
      "targetId": id,
      "expression": expression
    });

    switch (result["type"]) {
      case "Sentinel": throw new VMSentinelException(newVMSentinel(result));
      case "@Error": throw new VMErrorException(newVMErrorRef(this, result));
      case "@Instance": return newVMInstanceRef(this, result);
      default:
        throw new StateError('Unexpected Object type "${result["type"]}".');
    }
  }

  /// A race-condition-free way of getting an object in a particular state.
  ///
  /// This listens to a [stream] of events describing the state of an object at
  /// the same time as it checks if the current state of the object in the VM is
  /// acceptable (for example, if an Isolate is runnable). This ensures that if
  /// the object is already in the desired state, we know about it rather than
  /// waiting for an event that will never come.
  ///
  /// First, [immediate] is called to do an asynchronous load of the object to
  /// check its current state. If it's in the proper state, the returned Future
  /// should complete to that value; otherwise, it should complete to `null` or
  /// `false`.
  ///
  /// Meanwhile, [onEvent] is called with every event from [stream] that matches
  /// this scope's isolate. It should *synchronously* return `null` or `false`
  /// for irrelevant events; once it sees a relevant event, it should return a
  /// non-`null`, non-`false` value (which may be a Future).
  ///
  /// This returns the value returned by [immediate] if it's not `null` or
  /// `false`, or else the first non-`null`, non-`false` value returned by
  /// [onEvent].
  Future getInState(Stream<Map> stream, Future immediate(), onEvent(Map json))
      async {
    var completer = new Completer.sync();

    // Don't top-level errors from the completer. These may come in from the
    // stream subscription while we're still waiting for `load()` to complete.
    completer.future.catchError((_) {});

    // To avoid a race condition, we need to make sure we're listening to the
    // event stream before we load the current state, so that if the object
    // reaches the desired state during the load we'll see it.
    var subscription;
    subscription = stream.listen((json) {
      if (json["isolate"]["id"] != isolateId) return;

      try {
        var result = onEvent(json);
        if (result == null || result == false) return;
        subscription.cancel();
        completer.complete(result);
      } catch (error, stackTrace) {
        completer.completeError(error, stackTrace);
      }
    }, onError: (error, stackTrace) {
      subscription.cancel();
      completer.completeError(error, stackTrace);
    }, onDone: () {
      // Throw and catch so the completer has a stack trace.
      try {
        throw new StateError("No element");
      } catch (error, stackTrace) {
        completer.completeError(error, stackTrace);
      }
    });

    var result = await immediate();
    if (result != null && result != false) {
      subscription.cancel();
      return result;
    }

    return await completer.future;
  }
}
