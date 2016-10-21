// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:stream_channel/stream_channel.dart';

/// Wraps a [StreamChannel] and handles logic that's shared between [Server],
/// [Client], and [Peer].
///
/// These classes don't provide the user direct access to a
/// [StreamSubscription]. Instead, they use the future returned by [listen] to
/// notify the user of the remote endpoint closing or producing an error.
class ChannelManager {
  /// The name of the component whose channel is wrapped (e.g. "Server").
  ///
  /// Used for error reporting.
  final String _name;

  /// The underlying channel.
  final StreamChannel _channel;

  /// Returns a [Future] that completes when the connection is closed.
  ///
  /// This is the same future that's returned by [listen].
  Future get done => _doneCompleter.future;
  final _doneCompleter = new Completer();

  /// Whether the underlying communication channel is closed.
  bool get isClosed => _doneCompleter.isCompleted;

  /// Whether [listen] has been called.
  bool _listenCalled = false;

  /// Whether [close] has been called.
  ///
  /// Note that [isClosed] tracks whether the underlying connection is closed,
  /// whereas this tracks only whether it was explicitly closed from this end.
  bool _closeCalled = false;

  ChannelManager(this._name, this._channel);

  /// Starts listening to the channel.
  ///
  /// The returned Future will complete when the input stream is closed. If the
  /// input stream emits an error, that will be piped to the returned Future.
  Future listen(void handleInput(input)) {
    if (_listenCalled) {
      throw new StateError("Can only call $_name.listen() once.");
    }
    _listenCalled = true;

    _channel.stream.listen(handleInput,
        onError: (error, stackTrace) {
          _doneCompleter.completeError(error, stackTrace);
          _channel.sink.close();
        },
        onDone: () {
          if (!_doneCompleter.isCompleted) _doneCompleter.complete();
        },
        cancelOnError: true);

    return done;
  }

  /// Emit [event].
  void add(event) {
    if (isClosed && !_closeCalled) return;
    _channel.sink.add(event);
  }

  /// Closes the channel.
  Future close() {
    _closeCalled = true;
    if (!_doneCompleter.isCompleted) {
      _doneCompleter.complete(_channel.sink.close());
    }
    return done;
  }
}
