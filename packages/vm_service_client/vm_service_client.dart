// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:async/async.dart';
import 'package:json_rpc_2/json_rpc_2.dart' as rpc;
import 'package:stream_channel/stream_channel.dart';
import 'package:web_socket_channel/io.dart';

import 'src/exceptions.dart';
import 'src/flag.dart';
import 'src/isolate.dart';
import 'src/service_version.dart';
import 'src/stream_manager.dart';
import 'src/utils.dart';
import 'src/v1_compatibility.dart';
import 'src/vm.dart';

export 'src/bound_field.dart' hide newVMBoundField;
export 'src/breakpoint.dart' hide newVMBreakpoint;
export 'src/class.dart' hide newVMClassRef;
export 'src/code.dart' hide newVMCodeRef;
export 'src/context.dart' hide newVMContextRef;
export 'src/error.dart' hide newVMError, newVMErrorRef;
export 'src/exceptions.dart';
export 'src/field.dart' hide newVMFieldRef;
export 'src/flag.dart' hide newVMFlagList;
export 'src/frame.dart' hide newVMFrame;
export 'src/function.dart' hide newVMFunctionRef;
export 'src/instance.dart' hide newVMInstanceRef, newVMInstance,
    newVMTypeLikeInstanceRef, newVMTypeInstanceRef, newVMInstanceRefOrSentinel;
export 'src/isolate.dart' hide newVMIsolateRef;
export 'src/library.dart' hide newVMLibraryRef;
export 'src/message.dart' hide newVMMessage;
export 'src/object.dart';
export 'src/pause_event.dart' hide newVMPauseEvent;
export 'src/script.dart' hide newVMScriptRef, newVMScriptToken,
    newVMScriptTokenFromPosition;
export 'src/sentinel.dart' hide newVMSentinel;
export 'src/service_version.dart' hide newVMServiceVersion;
export 'src/source_location.dart' hide newVMSourceLocation,
    newVMSourceLocationFromPosition;
export 'src/source_report.dart' hide newSourceReport;
export 'src/stack.dart' hide newVMStack;
export 'src/type_arguments.dart' hide newVMTypeArgumentsRef;
export 'src/unresolved_source_location.dart' hide newVMUnresolvedSourceLocation;
export 'src/vm.dart' hide newVM;

/// A [StreamSinkTransformer] that converts encodes JSON messages.
///
/// We can't use fromStreamTransformer with JSON.encoder because it isn't
/// guaranteed to emit the entire object as a single message, and the WebSocket
/// protocol cares about that.
final _jsonSinkEncoder = new StreamSinkTransformer.fromHandlers(
    handleData: (data, sink) => sink.add(JSON.encode(data)));

/// A client for the [Dart VM service protocol][service api].
///
/// [service api]: https://github.com/dart-lang/sdk/blob/master/runtime/vm/service/service.md
///
/// Connect to a VM service endpoint using [connect], and use [getVM] to load
/// information about the VM itself.
///
/// The client supports VM service versions 1.x (which first shipped with Dart
/// 1.11), 2.x (which first shipped with Dart 1.12), and 3.x (which first
/// shipped with Dart 1.13). Some functionality may be unavailable in older VM
/// service versions; those places will be clearly documented. You can check the
/// version of the VM service you're connected to using [getVersion].
///
/// Because it takes an extra RPC call to verify compatibility with the protocol
/// version, the client doesn't do so by default. Users who want to be sure
/// they're talking to a supported protocol version can call [validateVersion].
class VMServiceClient {
  /// The underlying JSON-RPC peer used to communicate with the VM service.
  final rpc.Peer _peer;

  /// The streams shared among the entire service protocol client.
  final StreamManager _streams;

  /// A broadcast stream that emits every isolate as it starts.
  Stream<VMIsolateRef> get onIsolateStart => _onIsolateStart;
  Stream<VMIsolateRef> _onIsolateStart;

  /// A broadcast stream that emits every isolate as it becomes runnable.
  ///
  /// These isolates are guaranteed to return a [VMRunnableIsolate] from
  /// [VMIsolateRef.load].
  ///
  /// This is only supported on the VM service protocol version 3.0 and greater.
  Stream<VMIsolateRef> get onIsolateRunnable => _onIsolateRunnable;
  Stream<VMIsolateRef> _onIsolateRunnable;

  /// A future that fires when the underlying connection has been closed.
  ///
  /// Any connection-level errors will also be emitted through this future.
  final Future done;

  /// Connects to the VM service protocol at [url].
  ///
  /// [url] may be a `ws://` or a `http://` URL. If it's `ws://`, it's
  /// interpreted as the URL to connect to directly. If it's `http://`, it's
  /// interpreted as the URL for the Dart observatory, and the corresponding
  /// WebSocket URL is determined based on that. It may be either a [String] or
  /// a [Uri].
  ///
  /// If this encounters a connection error, [done] will complete with a
  /// [WebSocketChannelException].
  factory VMServiceClient.connect(url) {
    if (url is! Uri && url is! String) {
      throw new ArgumentError.value(url, "url", "must be a String or a Uri");
    }

    var uri = url is String ? Uri.parse(url) : url;
    if (uri.scheme == 'http') uri = uri.replace(scheme: 'ws', path: '/ws');

    // TODO(nweiz): Just use [WebSocketChannel.connect] when cross-platform
    // libraries work.
    return new VMServiceClient(new IOWebSocketChannel.connect(uri).cast());
  }

  /// Creates a client that reads incoming messages from a [channel] which
  /// contains JSON-encoded [String] instances.
  ///
  /// This is useful when using the client over a pre-existing connection. To
  /// establish a connection from scratch, use [VMServiceClient.connect].
  factory VMServiceClient(StreamChannel<String> channel) =>
      new VMServiceClient.withoutJson(jsonDocument.bind(channel));

  /// Creates a client that reads incoming messages from a [channel] which
  /// contains decoded JSON maps and lists.
  ///
  /// This is useful when using the client over a pre-existing connection. To
  /// establish a connection from scratch, use [VMServiceClient.connect].
  factory VMServiceClient.withoutJson(StreamChannel channel) =>
      new VMServiceClient._(new rpc.Peer.withoutJson(
          channel.transformStream(v1CompatibilityTransformer)));

  VMServiceClient._(rpc.Peer peer)
      : _peer = peer,
        _streams = new StreamManager(peer),
        done = peer.listen() {
    _onIsolateStart = transform(_streams.isolate, (json, sink) {
      if (json["kind"] != "IsolateStart") return;
      sink.add(newVMIsolateRef(_peer, _streams, json["isolate"]));
    });

    _onIsolateRunnable = transform(_streams.isolate, (json, sink) {
      if (json["kind"] != "IsolateRunnable") return;
      sink.add(newVMIsolateRef(_peer, _streams, json["isolate"]));
    });
  }

  /// Checks the VM service protocol version and throws a
  /// [VMUnsupportedVersionException] if it's not a supported version.
  ///
  /// Because it's possible the VM service protocol doesn't speak JSON-RPC 2.0
  /// at all, by default this will also throw a [VMUnsupportedVersionException]
  /// if a reply isn't received within two seconds. This timeout can be
  /// controlled with [timeout], or `null` can be passed to use no timeout.
  Future validateVersion({Duration timeout: const Duration(seconds: 2)}) {
    var future = _peer.sendRequest("getVersion", {}).then((json) {
      var version;
      try {
        version = newVMServiceVersion(json);
      } catch (_) {
        throw new VMUnsupportedVersionException();
      }

      if (version.major < 2 || version.major > 3) {
        throw new VMUnsupportedVersionException(version);
      }
    });

    if (timeout == null) return future;

    return future.timeout(timeout, onTimeout: () {
      throw new VMUnsupportedVersionException();
    });
  }

  /// Closes the underlying connection to the VM service.
  ///
  /// Returns a [Future] that fires once the connection has been closed.
  Future close() => _peer.close();

  /// Returns a list of flags that were passed to the VM.
  ///
  /// As of VM service version 3.0, this only includes VM-internal flags.
  Future<List<VMFlag>> getFlags() async =>
      newVMFlagList(await _peer.sendRequest("getFlagList", {}));

  /// Returns the version of the VM service protocol that this client is
  /// communicating with.
  ///
  /// Note that this is distinct from the version of Dart, which is accessible
  /// via [VM.version]. Note also that this doesn't necessarily accurately
  /// reflect the available APIs; for example, VM service versions 3.1, 3.2, and
  /// 3.3 all reported themseves as version 3.0.
  Future<VMServiceVersion> getVersion() async =>
      newVMServiceVersion(await _peer.sendRequest("getVersion", {}));

  /// Returns information about the Dart VM.
  Future<VM> getVM() async =>
      newVM(_peer, _streams, await _peer.sendRequest("getVM", {}));
}
