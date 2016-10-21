// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:async/async.dart';
import 'package:json_rpc_2/json_rpc_2.dart' as rpc;

import 'breakpoint.dart';
import 'error.dart';
import 'exceptions.dart';
import 'library.dart';
import 'pause_event.dart';
import 'scope.dart';
import 'sentinel.dart';
import 'source_report.dart';
import 'stack.dart';
import 'stream_manager.dart';
import 'utils.dart';

VMIsolateRef newVMIsolateRef(rpc.Peer peer, StreamManager streams, Map json) {
  if (json == null) return null;
  assert(json["type"] == "@Isolate" || json["type"] == "Isolate");
  var scope = new Scope(peer, streams, json["id"]);
  return new VMIsolateRef._(scope, json);
}

/// A reference to an isolate on the remote VM.
///
/// The full isolate with additional metadata can be loaded using [load].
class VMIsolateRef {
  final Scope _scope;

  /// A unique numeric ID for this isolate.
  ///
  /// Note that this may be larger than can be represented in Dart
  /// implementations that compile to JS; it's generally safer to use
  /// [numberAsString] instead.
  final int number;

  /// The string representation of [number].
  final String numberAsString;

  /// A name identifying this isolate for debugging.
  ///
  /// This isn't guaranteed to be unique. It can be set using [setName].
  final String name;

  /// A broadcast stream that emits a `null` value every time a garbage
  /// collection occurs in this isolate.
  Stream get onGC => _onGC;
  Stream _onGC;

  /// A broadcast stream that emits a new reference to this isolate every time
  /// its metadata changes.
  Stream<VMIsolateRef> get onUpdate => _onUpdate;
  Stream<VMIsolateRef> _onUpdate;

  /// A broadcast stream that emits a [VMPauseEvent] whenever this isolate is
  /// paused or resumed.
  Stream<VMPauseEvent> get onPauseOrResume => _onPauseOrResume;
  Stream<VMPauseEvent> _onPauseOrResume;

  /// A broadcast stream that emits a [VMBreakpoint] whenever a breakpoint is
  /// added.
  Stream<VMBreakpoint> get onBreakpointAdded => _onBreakpointAdded;
  Stream<VMBreakpoint> _onBreakpointAdded;

  /// A broadcast stream that emits custom events posted using `postEvent` from
  /// `dart:developer`.
  ///
  /// This is supported as of VM service version 3.1, or Dart SDK version 1.14.
  Stream<VMExtensionEvent> get onExtensionEvent => _onExtensionEvent;
  Stream<VMExtensionEvent> _onExtensionEvent;

  /// A broadcast stream that emits this isolate's standard output.
  ///
  /// This is only usable for embedders that provide access to `dart:io`.
  ///
  /// Note that as of the VM service version 3.0, this stream doesn't emit
  /// strings passed to the `print()` function unless the host process's
  /// standard output is actively being drained (see [sdk#24351][]).
  ///
  /// [sdk#24351]: https://github.com/dart-lang/sdk/issues/24351
  Stream<List<int>> get stdout => _stdout;
  Stream<List<int>> _stdout;

  /// A broadcast stream that emits this isolate's standard error.
  ///
  /// This is only usable for embedders that provide access to `dart:io`.
  Stream<List<int>> get stderr => _stderr;
  Stream<List<int>> _stderr;

  /// A broadcast stream that emits an event whenever a new VM service extension
  /// RPC is registered.
  ///
  /// Each event is the name of a registered RPC.
  ///
  /// This is supported as of VM service version 3.1, or Dart SDK version 1.14.
  Stream<String> get onExtensionAdded => _onExtensionAdded;
  Stream<String> _onExtensionAdded;

  /// A future that fires when the isolate exits.
  ///
  /// If the isolate has already exited, this will complete immediately.
  Future get onExit => _onExitMemo.runOnce(() async {
    try {
      await _scope.getInState(_scope.streams.isolate, () async {
        try {
          await load();
          return null;
        } on VMSentinelException catch (_) {
          // Return a non-null value to indicate that the breakpoint is in the
          // expected state—that is, it no longer exists.
          return true;
        }
      }, (json) {
        if (json["isolate"]["id"] != _scope.isolateId) return null;
        if (json["kind"] != "IsolateExit") return null;
        return true;
      });
    } on StateError catch (_) {
      // Ignore state errors. They indicate that the underlying stream closed
      // before an exit event was fired, which means that the process and thus
      // this isolate is dead.
    }
  });
  final _onExitMemo = new AsyncMemoizer();

  VMIsolateRef._(this._scope, Map json)
      : number = int.parse(json["number"]),
        numberAsString = json["number"],
        name = json["name"] {
    _onGC = _transform(_scope.streams.gc, (json, sink) {
      if (json["kind"] == "GC") sink.add(null);
    });

    _onUpdate = _transform(_scope.streams.isolate, (json, sink) {
      if (json["kind"] != "IsolateUpdate") return;
      sink.add(new VMIsolateRef._(_scope, json["isolate"]));
    });

    _onExtensionAdded = _transform(_scope.streams.isolate, (json, sink) {
      if (json["kind"] != "ServiceExtensionAdded") return;
      sink.add(json["extensionRPC"]);
    });

    _onPauseOrResume = _transform(_scope.streams.debug, (json, sink) {
      var event = newVMPauseEvent(_scope, json);
      if (event != null) sink.add(event);
    });

    _onBreakpointAdded = _transform(_scope.streams.debug, (json, sink) {
      if (json["kind"] != "BreakpointAdded") return;
      sink.add(newVMBreakpoint(_scope, json["breakpoint"]));
    });

    _stdout = _transform(_scope.streams.stdout, (json, sink) {
      if (json["kind"] != "WriteEvent") return;
      var bytes = BASE64.decode(json["bytes"]);
      sink.add(bytes);
    });

    _stderr = _transform(_scope.streams.stderr, (json, sink) {
      if (json["kind"] != "WriteEvent") return;
      sink.add(BASE64.decode(json["bytes"]));
    });

    _onExtensionEvent = _transform(_scope.streams.extension, (json, sink) {
      sink.add(new VMExtensionEvent._(json));
    });
  }

  /// Like [transform], but only calls [handleData] for events related to this
  /// isolate.
  Stream _transform(Stream<Map> stream, handleData(Map json, StreamSink sink)) {
    return transform(stream, (json, sink) {
      if (json["isolate"]["id"] != _scope.isolateId) return;
      handleData(json, sink);
    });
  }

  /// Loads the full representation of this isolate once it becomes runnable.
  ///
  /// This will work whether this isolate is already runnable or has yet to
  /// become runnable.
  ///
  /// This is only supported on the VM service protocol version 3.0 and greater.
  Future<VMRunnableIsolate> loadRunnable() {
    return _scope.getInState(_scope.streams.isolate, () async {
      var isolate = await load();
      return isolate is VMRunnableIsolate ? isolate : null;
    }, (json) {
      if (json["kind"] != "IsolateRunnable") return null;
      return load();
    });
  }

  // Note that if anyone else is using the VM service, the VM may be unpaused by
  // the time this fires.

  /// Returns a future that completes once this isolate is paused.
  ///
  /// This works whether the isolate is already paused or has yet to be paused.
  /// Note that if any other code (other VM service clients or other isolates)
  /// unpauses the isolate, it may be unpaused by the time the returned future
  /// fires.
  Future waitUntilPaused() {
    return _scope.getInState(_scope.streams.debug, () async {
      return (await load()).isPaused;
    }, (json) {
      return json["kind"] == "PauseStart" || json["kind"] == "PauseException" ||
          json["kind"] == "PauseExit" || json["kind"] == "PauseInterrupted" ||
          json["kind"] == "PauseBreakpoint";
    });
  }

  /// Loads the full representation of this isolate.
  ///
  /// Throws a [VMSentinelException] if this isolate is no longer available.
  Future<VMIsolate> load() async {
    var response = await _scope.sendRequest("getIsolate");

    // Work around sdk#24142.
    if (response["type"] == "Error") {
      throw new VMSentinelException(VMSentinel.collected);
    } else if (response["type"] == "Sentinel") {
      throw new VMSentinelException(newVMSentinel(response));
    } else {
      return response["rootLib"] == null ||
             // Work around sdk#24140
             response["rootLib"]["type"] == "@Instance"
          ? new VMIsolate._(_scope, response)
          : new VMRunnableIsolate._(_scope, response);
    }
  }

  /// Returns a broadcast stream that emits custom events posted via `postEvent`
  /// from the `dart:developer` package.
  ///
  /// Unlike [onExtensionEvent], this only emits events for which
  /// [VMExtensionEvent.kind] is [kind]. If [prefix] is `true`, it also emits
  /// events for which [VMExtensionEvent.kind] starts with [kind].
  ///
  /// This is supported as of VM service version 3.1, or Dart SDK version 1.14.
  Stream<VMExtensionEvent> selectExtensionEvents(String kind,
          {bool prefix: false}) {
    return transform(_onExtensionEvent, (event, sink) {
      if (prefix == null ? event.kind == kind : event.kind.startsWith(kind)) {
        sink.add(event);
      }
    });
  }

  /// Returns the isolate's current execution stack and message queue.
  Future<VMStack> getStack() async =>
      newVMStack(_scope, await _scope.sendRequest("getStack"));

  /// Pauses this isolate.
  ///
  /// The returned future may complete before the isolate is paused.
  Future pause() async {
    await _scope.sendRequest("pause");
  }

  /// Resumes execution of this isolate, if it's paused.
  ///
  /// [step] controls how execution proceeds; it defaults to [VMStep.resume].
  ///
  /// Throws an [rpc.RpcException] if the isolate isn't paused.
  Future resume({VMStep step}) {
    if (step == null) step = VMStep.resume;
    return _scope.sendRequest("resume",
        step == VMStep.resume ? {} : {"step": step._value});
  }

  /// Sets the [name] of the isolate.
  ///
  /// Note that since this object is immutable, it needs to be reloaded to see
  /// the new name.
  Future setName(String name) => _scope.sendRequest("setName", {"name": name});

  /// Adds a breakpoint at [line] (and optionally [column]) in the script with
  /// the given canonical [uri].
  ///
  /// Both [line] and [column] are 1-based. The [uri] may be a [String] or a
  /// [Uri].
  Future<VMBreakpoint> addBreakpoint(uri, int line, {int column}) async {
    if (uri is! String && uri is! Uri) {
      throw new ArgumentError("Invalid uri '$uri', must be a Uri or a String.");
    }

    var params = {"scriptUri": uri.toString(), "line": line};
    if (column != null) params["column"] = column;

    try {
      var response = await _scope.sendRequest(
          "addBreakpointWithScriptUri", params);
      return newVMBreakpoint(_scope, response);
    } on rpc.RpcException catch (error) {
      // Error 102 indicates that the breakpoint couldn't be created.
      if (error.code == 102) return null;
      rethrow;
    }
  }

  /// Returns a future that completes once the VM service extension RPC with the
  /// given [name] is available.
  ///
  /// This works whether the extension is already registered or has yet to be
  /// registered.
  ///
  /// This is supported as of VM service version 3.1, or Dart SDK version 1.14.
  Future waitForExtension(String name) async {
    return _scope.getInState(_scope.streams.isolate, () async {
      var extensions = (await load()).extensionRpcs;
      return extensions.contains(name);
    }, (Map json) {
      return json["kind"] == "ServiceExtensionAdded" &&
          json["extensionRPC"] == name;
    }).then((_) => null);
  }

  /// Invokes the VM service extension RPC named [method] registered in this
  /// isolate.
  ///
  /// VM service extensions are registered using the `registerExtension` method
  /// in `dart:developer`. The [method] name must be the same as the name passed
  /// to `registerExtension`, which means it must begin with "ext.".
  ///
  /// The [params] are passed to the extension handler.
  ///
  /// Returns the extension handler's decoded response.
  ///
  /// This is supported as of VM service version 3.1, or Dart SDK version 1.14.
  Future<Object> invokeExtension(String method, [Map<String, String> params]) {
    if (!method.startsWith('ext.')) {
      throw new ArgumentError.value(method, 'method',
          'must begin with "ext." prefix');
    }
    return _scope.sendRequest(method, params);
  }

  /// Generates a report of code coverage information and possible break points
  /// for the scripts in this isolate.
  ///
  /// If [includeCoverageReport] is `true`, the report includes code coverage
  /// information via [VMSourceReportRange.hits] and
  /// [VMSourceReportRange.misses] in [VMSourceReport.ranges]. Otherwise,
  /// these properties are `null`.
  ///
  /// If [includePossibleBreakpoints] is `true`, the report includes a list of
  /// token positions which correspond to possible breakpoints via
  /// [VMSourceReportRange.possibleBreakpoints] in [VMSourceReport.ranges].
  /// Otherwise, [VMSourceReportRange.possibleBreakpoints] is `null`.
  ///
  /// If [forceCompile] is `true`, all functions in the range of the report
  /// will be compiled. If `false`, functions that are never used may not appear
  /// in [VMSourceReportRange.misses]. Forcing compilation can cause a
  /// compilation error, which could terminate the running Dart program.
  Future<VMSourceReport> getSourceReport(
      {bool includeCoverageReport: true,
      bool includePossibleBreakpoints: true,
      bool forceCompile: false}) async {
    var reports = <String>[];
    if (includeCoverageReport) reports.add('Coverage');
    if (includePossibleBreakpoints) reports.add('PossibleBreakpoints');

    var params = {'reports': reports};
    if (forceCompile) params['forceCompile'] = true;

    var json = await _scope.sendRequest('getSourceReport', params);
    return newSourceReport(_scope, json);
  }

  bool operator ==(other) => other is VMIsolateRef &&
      other._scope.isolateId == _scope.isolateId;

  int get hashCode => _scope.isolateId.hashCode;

  String toString() => name;
}

/// A full isolate on the remote VM.
class VMIsolate extends VMIsolateRef {
  /// The time that the isolate started running.
  final DateTime startTime;

  /// The number of live ports on this isolate.
  final int livePorts;

  /// Whether this isolate will pause before it exits.
  final bool pauseOnExit;

  /// The last pause event delivered to this isolate.
  ///
  /// If the isolate is running, this will be a [VMResumeEvent].
  ///
  /// As of VM service version 3.4, this will be a [VMNoneEvent] before the
  /// isolate is runnable.
  final VMPauseEvent pauseEvent;

  /// Whether this isolate is paused.
  bool get isPaused =>
      pauseEvent is! VMNoneEvent && pauseEvent is! VMResumeEvent;

  /// The error that's causing the isolate to exit or `null`.
  final VMError error;

  /// All breakpoints currently registered for this isolate.
  final List<VMBreakpoint> breakpoints;

  /// The VM service extension RPCs that are currently registered for this
  /// isolate.
  ///
  /// This is supported as of VM service version 3.1, or Dart SDK version 1.14.
  final List<String> extensionRpcs;

  VMIsolate._(Scope scope, Map json)
      : startTime = new DateTime.fromMillisecondsSinceEpoch(
            // Prior to v3.0, this was emitted as a double rather than an int.
            json["startTime"].round()),
        livePorts = json["livePorts"],
        pauseOnExit = json["pauseOnExit"],
        pauseEvent = newVMPauseEvent(scope, json["pauseEvent"]),
        error = newVMError(scope, json["error"]),
        breakpoints = new List.unmodifiable(json["breakpoints"]
            .map((breakpoint) => newVMBreakpoint(scope, breakpoint))),
        extensionRpcs = new UnmodifiableListView(json["extensionRPCs"] ?? []),
        super._(scope, json);
}

/// A full isolate on the remote VM that's ready to run code.
///
/// The VM service exposes isolates very early, before their contents are
/// fully-loaded. These in-progress isolates, represented by plain [VMIsolate]
/// instances, have limited amounts of metadata available. Only once they're
/// runnable is the full suite of metadata available.
///
/// A [VMRunnableIsolate] can always be retrieved using
/// [VMIsolateRef.loadRunnable]. In addition, one will be returned by
/// [VMIsolate.load] if the remote isolate is runnable.
class VMRunnableIsolate extends VMIsolate {
  /// The root library for this isolate.
  final VMLibraryRef rootLibrary;

  /// All the libraries (transitively) loaded in this isolate, indexed by their
  /// canonical URIs.
  final Map<Uri, VMLibraryRef> libraries;

  VMRunnableIsolate._(Scope scope, Map json)
      : rootLibrary = newVMLibraryRef(scope, json["rootLib"]),
        libraries = new UnmodifiableMapView(
            new Map.fromIterable(json["libraries"],
                key: (library) => Uri.parse(library["uri"]),
                value: (library) => newVMLibraryRef(scope, library))),
        super._(scope, json);

  Future<VMRunnableIsolate> loadRunnable() => load();

  Future<VMRunnableIsolate> load() => super.load();

  String toString() => "Isolate running $rootLibrary";
}

/// An enum of ways to resume an isolate's execution using
/// [VMIsolateRef.resume].
class VMStep {
  /// The isolate resumes regular execution.
  static const resume = const VMStep._("Resume");

  /// The isolate takes a single step into a function call.
  static const into = const VMStep._("Into");

  /// The isolate takes a single step, skipping over function calls.
  static const over = const VMStep._("Over");

  /// The isolate continues until it exits the current function.
  static const out = const VMStep._("Out");

  /// The string name of the step type.
  final String _value;

  const VMStep._(this._value);

  String toString() => _value;
}

/// An event posted via `postEvent` from the `dart:developer` package.
class VMExtensionEvent {
  /// The kind, which identifies the type of event and its source.
  final String kind;

  /// The event's payload.
  final Map data;

  VMExtensionEvent._(Map json)
      : kind = json['extensionKind'],
        data = json['extensionData'];
}
