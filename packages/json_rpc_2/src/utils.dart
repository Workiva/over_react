// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:stream_channel/stream_channel.dart';

import '../error_code.dart' as error_code;
import 'exception.dart';

typedef ZeroArgumentFunction();

/// Returns a sentence fragment listing the elements of [iter].
///
/// This converts each element of [iter] to a string and separates them with
/// commas and/or "and" where appropriate.
String toSentence(Iterable iter) {
  if (iter.length == 1) return iter.first.toString();
  return iter.take(iter.length - 1).join(", ") + " and ${iter.last}";
}

/// Returns [name] if [number] is 1, or the plural of [name] otherwise.
///
/// By default, this just adds "s" to the end of [name] to get the plural. If
/// [plural] is passed, that's used instead.
String pluralize(String name, int number, {String plural}) {
  if (number == 1) return name;
  if (plural != null) return plural;
  return '${name}s';
}

/// A regular expression to match the exception prefix that some exceptions'
/// [Object.toString] values contain.
final _exceptionPrefix = new RegExp(r'^([A-Z][a-zA-Z]*)?(Exception|Error): ');

/// Get a string description of an exception.
///
/// Many exceptions include the exception class name at the beginning of their
/// [toString], so we remove that if it exists.
String getErrorMessage(error) =>
    error.toString().replaceFirst(_exceptionPrefix, '');

/// Like `try`/`finally`, run [body] and ensure that [whenComplete] runs
/// afterwards, regardless of whether [body] succeeded.
///
/// This is synchronicity-agnostic relative to [body]. If [body] returns a
/// [Future], this wil run asynchronously; otherwise it will run synchronously.
tryFinally(body(), whenComplete()) {
  var result;
  try {
    result = body();
  } catch (_) {
    whenComplete();
    rethrow;
  }

  if (result is! Future) {
    whenComplete();
    return result;
  } else {
    return result.whenComplete(whenComplete);
  }
}

/// A transformer that silently drops [FormatException]s.
final ignoreFormatExceptions =
    new StreamTransformer<Object, Object>.fromHandlers(
        handleError: (error, stackTrace, sink) {
  if (error is FormatException) return;
  sink.addError(error, stackTrace);
});

/// A transformer that sends error responses on [FormatException]s.
final StreamChannelTransformer respondToFormatExceptions =
    new _RespondToFormatExceptionsTransformer();

/// The implementation of [respondToFormatExceptions].
class _RespondToFormatExceptionsTransformer
    implements StreamChannelTransformer {
  StreamChannel bind(StreamChannel channel) {
    var transformed;
    transformed = channel.changeStream((stream) {
      return stream.handleError((error) {
        if (error is! FormatException) throw error;

        var exception = new RpcException(
            error_code.PARSE_ERROR, 'Invalid JSON: ${error.message}');
        transformed.sink.add(exception.serialize(error.source));
      });
    });
    return transformed;
  }
}

/// Returns a [StreamSink] that wraps [sink] and maps each event added using
/// [callback].
StreamSink mapStreamSink(StreamSink sink, callback(event)) =>
    new _MappedStreamSink(sink, callback);

/// A [StreamSink] wrapper that maps each event added to the sink.
class _MappedStreamSink implements StreamSink {
  final StreamSink _inner;
  final Function _callback;

  Future get done => _inner.done;

  _MappedStreamSink(this._inner, this._callback);

  void add(event) => _inner.add(_callback(event));
  void addError(error, [StackTrace stackTrace]) =>
      _inner.addError(error, stackTrace);
  Future addStream(Stream stream) => _inner.addStream(stream.map(_callback));
  Future close() => _inner.close();
}
