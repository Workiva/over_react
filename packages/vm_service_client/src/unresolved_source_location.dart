// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'breakpoint.dart';
import 'scope.dart';
import 'script.dart';

VMUnresolvedSourceLocation newVMUnresolvedSourceLocation(Scope scope,
    Map json) {
  if (json == null) return null;
  assert(json["type"] == "UnresolvedSourceLocation");
  return new VMUnresolvedSourceLocation._(scope, json);
}

/// The location of an unresolved breakpoint.
class VMUnresolvedSourceLocation implements VMBreakpointLocation {
  final VMScriptRef script;

  final Uri uri;

  /// If this is `null`, [line] and [column] are guaranteed to be non-`null`.
  final VMScriptToken token;

  /// The line specified by the user when they created the breakpoint.
  ///
  /// This is 1-based. It's `null` if and only if [token] is non-`null`.
  final int line;

  /// The column specified by the user when they created the breakpoint.
  ///
  /// This is 1-based. It's `null` if [token] is non-`null` or if the user
  /// didn't specify a column.
  final int column;

  VMUnresolvedSourceLocation._(Scope scope, Map json)
      : script = newVMScriptRef(scope, json["script"]),
        uri = Uri.parse(
            json["scriptUri"] == null
                ? json["script"]["uri"]
                : json["scriptUri"]),
        token = json["tokenPos"] == null
            ? null
            : newVMScriptToken(
                scope.isolateId, json["script"]["id"], json["tokenPos"]),
        line = json["line"],
        column = json["column"];

  String toString() {
    if (token != null) return "$uri at $token";
    return column == null ? "$uri at $line" : "$uri at $line:$column";
  }
}
