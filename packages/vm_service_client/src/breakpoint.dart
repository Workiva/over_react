// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:async/async.dart';
import 'package:json_rpc_2/error_code.dart' as rpc_error;
import 'package:json_rpc_2/json_rpc_2.dart' as rpc;

import 'class.dart';
import 'exceptions.dart';
import 'object.dart';
import 'scope.dart';
import 'script.dart';
import 'sentinel.dart';
import 'source_location.dart';
import 'unresolved_source_location.dart';
import 'utils.dart';

VMBreakpoint newVMBreakpoint(Scope scope, Map json) {
  if (json == null) return null;
  assert(json["type"] == "Breakpoint");
  return json["resolved"]
      ? new VMResolvedBreakpoint._(scope, json)
      : new VMBreakpoint._(scope, json);
}

/// A debugger breakpoint.
///
/// A breakpoint corresponds to a location in the source file. Before the
/// isolate would execute that location, it pauses.
///
/// A breakpoint starts out unresolved, meaning that the exact location of the
/// breakpoint is imprecisely known because its script has not yet been fully
/// loaded. Once that script is fully loaded, the breakpoint is resolved and its
/// location is fully avaiable. A resolved breakpoint is always represented as a
/// [VMResolvedBreakpoint], no matter how it was loaded. The easiest way to wait
/// for a breakpoint to be resolved is by calling [loadResolved].
///
/// Unlike most [VMObject]s, this has no corresponding [VMObjectRef] type. The
/// full metadata is always available.
class VMBreakpoint extends VMObject {
  final Scope _scope;

  /// The ID for this breakpoint, which is unique relative to its isolate.
  final String _id;

  /// Whether [_id] is guaranteed to be the same for different VM service
  /// instance objects that refer to the same breakpoint.
  final bool _fixedId;

  final int size;

  final VMClassRef klass;

  /// The number of this breakpoint.
  ///
  /// This number is user-visible.
  final int number;

  /// The location of the breakpoint in the isolate's Dart source.
  ///
  /// If this breakpoint is unresolved, this will be a
  /// [VMUnresolvedSourceLocation]. Otherwise, it will be a [VMSourceLocation].
  final VMBreakpointLocation location;

  /// A stream that emits a copy of [this] each time it causes the isolate to
  /// become paused.
  Stream<VMBreakpoint> get onPause => _onPause;
  Stream<VMBreakpoint> _onPause;

  /// A future that fires when this breakpoint is removed.
  ///
  /// If the breakpoint is already removed, this will complete immediately.
  Future get onRemove => _onRemoveMemo.runOnce(() async {
    await _scope.getInState(_scope.streams.debug, () async {
      try {
        await load();
        return false;
      } on VMSentinelException catch (_) {
        return true;
      }
    }, (json) {
      return json["kind"] == "BreakpointRemoved" &&
          json["breakpoint"]["id"] == _id;
    });
  });
  final _onRemoveMemo = new AsyncMemoizer();

  VMBreakpoint._(Scope scope, Map json)
      : _scope = scope,
        _id = json["id"],
        _fixedId = json["fixedId"] ?? false,
        size = json["size"],
        klass = newVMClassRef(scope, json["class"]),
        number = json["breakpointNumber"],
        location = _newVMBreakpointLocation(scope, json["location"]) {
    _onPause = transform(_scope.streams.debug, (json, sink) {
      if (json["isolate"]["id"] != _scope.isolateId) return;
      if (json["kind"] != "PauseBreakpoint") return;

      for (var breakpoint in json["pauseBreakpoints"]) {
        if (breakpoint["id"] != _id) continue;
        sink.add(newVMBreakpoint(_scope, breakpoint));
        break;
      }
    });
  }

  static VMBreakpointLocation _newVMBreakpointLocation(Scope scope, Map json) {
    if (json == null) return null;
    switch (json["type"]) {
      case "SourceLocation": return newVMSourceLocation(scope, json);
      case "UnresolvedSourceLocation":
        return newVMUnresolvedSourceLocation(scope, json);
      default:
        throw new StateError(
            'Unknown breakpoint location type ${json['type']}.');
    }
  }

  Future<VMBreakpoint> load() async {
    try {
      return newVMBreakpoint(_scope, await _scope.loadObject(_id));
    } on rpc.RpcException catch (error) {
      if (error.code != rpc_error.INVALID_PARAMS) rethrow;

      // Work around sdk#24247.
      throw new VMSentinelException(VMSentinel.expired);
    }
  }

  /// Reloads this breakpoint once it's resolved.
  ///
  /// This will work whether this breakpoint is already resolved or has yet to
  /// be resolved. However, it doesn't cause the breakpoint to be resolved.
  Future<VMBreakpoint> loadResolved() {
    return _scope.getInState(_scope.streams.debug, () async {
      var breakpoint = await load();
      return breakpoint is VMResolvedBreakpoint ? breakpoint : null;
    }, (json) {
      if (json["kind"] != "BreakpointResolved") return null;
      if (json["breakpoint"]["id"] != _id) return null;
      return newVMBreakpoint(_scope, json["breakpoint"]);
    });
  }

  /// Removes this breakpoint.
  Future remove() =>
      _scope.sendRequest("removeBreakpoint", {"breakpointId": _id});

  bool operator ==(other) => other is VMBreakpoint &&
      (_fixedId ? _id == other._id : super == other);

  int get hashCode => _fixedId ? _id.hashCode : super.hashCode;

  String toString() => "breakpoint #$number in ${location.uri}";
}

/// A resolved breakpoint with a precise source location.
class VMResolvedBreakpoint extends VMBreakpoint {
  VMSourceLocation get location => super.location as VMSourceLocation;

  VMResolvedBreakpoint._(Scope scope, Map json)
      : super._(scope, json) {
    assert(super.location is VMSourceLocation);
  }

  Future<VMBreakpoint> loadResolved() => load();
}

/// The location of a breakpoint, whether or not it's resolved.
abstract class VMBreakpointLocation {
  /// The URI of the script in which the breakpoint exists.
  ///
  /// This is always set regardless of how resolved the breakpoint is.
  Uri get uri;

  /// The script the breakpoint is located in.
  ///
  /// This may be `null` if the breakpoint is unresolved and the script hasn't
  /// been loaded.
  VMScriptRef get script;

  /// The location of the breakpoint in [script].
  ///
  /// This will be `null` if [script] is `null`. If the breakpoint is unresolved
  /// but the script has been loaded, this will be the VM's best guess of the
  /// correct token. If the breakpoint is resolved, it will be an exact
  /// location.
  VMScriptToken get token;
}
