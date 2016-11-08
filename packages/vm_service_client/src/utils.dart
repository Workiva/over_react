// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:stack_trace/stack_trace.dart';

import 'class.dart';
import 'frame.dart';
import 'function.dart';
import 'script.dart';

/// A [Map] between whitespace characters and their escape sequences.
const _escapeMap = const {
  '\n': r'\n',
  '\r': r'\r',
  '\f': r'\f',
  '\b': r'\b',
  '\t': r'\t',
  '\v': r'\v',
  '\x7F': r'\x7F', // delete
};

/// A regular expression matching the Dart VM stack frame method name for an
/// asynchronous body.
final _asyncBody = new RegExp(r'<(<anonymous closure>|[^>]+)_async_body>');

/// Transforms [stream] with a [StreamTransformer] that transforms data events
/// using [handleData].
Stream transform(Stream stream, handleData(data, EventSink sink)) =>
    stream.transform(
        new StreamTransformer.fromHandlers(handleData: handleData));

/// Loads a `stack_trace` [Frame] for [frame].
///
/// If [scripts] is passed, it should be a map of [VMScript]s that have already
/// been loaded, indexed by [name]. This function modifys the map so that it can
/// be passed in to future invocations to avoid unnecessary loads.
Future<Frame> frameToFrame(VMFrame frame, [Map<String, VMScript> scripts])
    async {
  var scopes = [];
  var scope = frame.function;
  while (scope is VMFunctionRef) {
    scopes.add(scope.name.replaceAll(_asyncBody, "<fn>"));
    scope = scope.owner;
  }
  if (scope is VMClassRef) scopes.add(scope.name);
  var member = scopes.reversed.join(".");

  var uri = frame.location.script.uri;
  var script = scripts == null ? null : scripts[uri];
  if (script == null) {
    script = await frame.location.script.load();

    // The special "evaluate" scheme is used for evaluating code with the VM
    // service. Different scripts can have the same "evalute" scheme, so we
    // don't record them.
    if (scripts != null && uri.scheme != 'evaluate') scripts[uri] = script;
  }
  var location = await script.sourceLocation(frame.location.token);

  return new Frame(script.uri, location.line, location.column, member);
}

/// A [RegExp] that matches whitespace characters that should be escaped.
final _escapeRegExp = new RegExp(
    "[\\x00-\\x07\\x0E-\\x1F${_escapeMap.keys.map(_getHexLiteral).join()}]");

/// Returns [str] with all whitespace characters represented as their escape
/// sequences.
///
/// Backslash characters are escaped as `\\`
String escapeString(String str) {
  str = str.replaceAll('\\', r'\\');
  return str.replaceAllMapped(_escapeRegExp, (match) {
    var mapped = _escapeMap[match[0]];
    if (mapped != null) return mapped;
    return _getHexLiteral(match[0]);
  });
}

/// Given single-character string, return the hex-escaped equivalent.
String _getHexLiteral(String input) {
  int rune = input.runes.single;
  return r'\x' + rune.toRadixString(16).toUpperCase().padLeft(2, '0');
}
