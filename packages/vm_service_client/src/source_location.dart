// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'breakpoint.dart';
import 'scope.dart';
import 'script.dart';

VMSourceLocation newVMSourceLocation(Scope scope, Map json) {
  if (json == null) return null;
  assert(json["type"] == "SourceLocation");
  return new VMSourceLocation._(scope, json);
}

VMSourceLocation newVMSourceLocationFromPosition(
        VMScriptRef script, int tokenPos, int endTokenPos) =>
    new VMSourceLocation._fromPositions(script, tokenPos, endTokenPos);

/// A location or span of code in a Dart script.
class VMSourceLocation implements VMBreakpointLocation {
  /// The script containing the source location.
  final VMScriptRef script;

  /// The canonical source URI of [script].
  Uri get uri => script.uri;

  /// If this is a span, this represents the start of that span.
  final VMScriptToken token;

  /// The final token of the location, or `null` if this is not a span.
  final VMScriptToken end;

  VMSourceLocation._(Scope scope, Map json)
      : script = newVMScriptRef(scope, json["script"]),
        token = newVMScriptToken(
            scope.isolateId, json["script"]["id"], json["tokenPos"]),
        end = newVMScriptToken(
            scope.isolateId, json["script"]["id"], json["endTokenPos"]);

  VMSourceLocation._fromPositions(
      VMScriptRef script, int tokenPos, int endTokenPos)
      : this.script = script,
        token = newVMScriptTokenFromPosition(script, tokenPos),
        end = newVMScriptTokenFromPosition(script, endTokenPos);

  String toString() =>
      end == null ? "$script at $token" : "$script from $token to $end";
}
