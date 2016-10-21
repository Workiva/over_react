// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:stream_channel/stream_channel.dart';

import 'channel_manager.dart';
import 'client.dart';
import 'parameters.dart';
import 'server.dart';
import 'utils.dart';

/// A JSON-RPC 2.0 client *and* server.
///
/// This supports bidirectional peer-to-peer communication with another JSON-RPC
/// 2.0 endpoint. It sends both requests and responses across the same
/// communication channel and expects to connect to a peer that does the same.
class Peer implements Client, Server {
  final ChannelManager _manager;

  /// The underlying client that handles request-sending and response-receiving
  /// logic.
  Client _client;

  /// The underlying server that handles request-receiving and response-sending
  /// logic.
  Server _server;

  /// A stream controller that forwards incoming messages to [_server] if
  /// they're requests.
  final _serverIncomingForwarder = new StreamController(sync: true);

  /// A stream controller that forwards incoming messages to [_client] if
  /// they're responses.
  final _clientIncomingForwarder = new StreamController(sync: true);

  Future get done => _manager.done;
  bool get isClosed => _manager.isClosed;

  /// Creates a [Peer] that communicates over [channel].
  ///
  /// Note that the peer won't begin listening to [channel] until [Peer.listen]
  /// is called.
  Peer(StreamChannel<String> channel)
      : this.withoutJson(channel
            .transform(jsonDocument)
            .transform(respondToFormatExceptions));

  /// Creates a [Peer] that communicates using decoded messages over [channel].
  ///
  /// Unlike [new Peer], this doesn't read or write JSON strings. Instead, it
  /// reads and writes decoded maps or lists.
  ///
  /// Note that the peer won't begin listening to [channel] until
  /// [Peer.listen] is called.
  Peer.withoutJson(StreamChannel channel)
      : _manager = new ChannelManager("Peer", channel) {
    _server = new Server.withoutJson(new StreamChannel(
        _serverIncomingForwarder.stream, channel.sink));
    _client = new Client.withoutJson(new StreamChannel(
        _clientIncomingForwarder.stream, channel.sink));
  }

  // Client methods.

  Future sendRequest(String method, [parameters]) =>
      _client.sendRequest(method, parameters);

  void sendNotification(String method, [parameters]) =>
      _client.sendNotification(method, parameters);

  withBatch(callback()) => _client.withBatch(callback);

  // Server methods.

  void registerMethod(String name, Function callback) =>
      _server.registerMethod(name, callback);

  void registerFallback(callback(Parameters parameters)) =>
      _server.registerFallback(callback);

  // Shared methods.

  Future listen() {
    _client.listen();
    _server.listen();
    return _manager.listen((message) {
      if (message is Map) {
        if (message.containsKey('result') || message.containsKey('error')) {
          _clientIncomingForwarder.add(message);
        } else {
          _serverIncomingForwarder.add(message);
        }
      } else if (message is List && message.isNotEmpty &&
                 message.first is Map) {
        if (message.first.containsKey('result') ||
            message.first.containsKey('error')) {
          _clientIncomingForwarder.add(message);
        } else {
          _serverIncomingForwarder.add(message);
        }
      } else {
        // Non-Map and -List messages are ill-formed, so we pass them to the
        // server since it knows how to send error responses.
        _serverIncomingForwarder.add(message);
      }
    });
  }

  Future close() =>
      Future.wait([_client.close(), _server.close(), _manager.close()]);
}
