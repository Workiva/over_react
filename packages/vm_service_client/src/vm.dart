// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:json_rpc_2/json_rpc_2.dart' as rpc;
import 'package:pub_semver/pub_semver.dart';

import 'isolate.dart';
import 'stream_manager.dart';
import 'utils.dart';

VM newVM(rpc.Peer peer, StreamManager streams, Map json) {
  if (json == null) return null;
  assert(json["type"] == "VM");
  return new VM._(peer, streams, json);
}

/// A reference to data the Dart VM as a whole.
///
/// The full VM with additional metadata can be loaded using [load].
class VMRef {
  /// The underlying JSON-RPC peer used to communicate with the VM service.
  final rpc.Peer _peer;

  /// The streams shared among the entire service protocol client.
  final StreamManager _streams;

  /// A name identifying this VM for debugging.
  ///
  /// This isn't guaranteed to be unique. It can be set using [setName]. This is
  /// only supported on the VM service protocol version 3.0 and greater.
  final String name;

  /// A broadcast stream that emits a new reference to the VM every time its
  /// metadata changes.
  ///
  /// This is only supported on the VM service protocol version 3.0 and greater.
  Stream<VMRef> get onUpdate => _onUpdate;
  Stream<VMRef> _onUpdate;

  VMRef._(rpc.Peer peer, StreamManager streams, Map json)
      : _peer = peer,
        _streams = streams,
        name = json["name"] {
    _onUpdate = transform(_streams.vm, (json, sink) {
      if (json["kind"] != "VMUpdate") return;
      sink.add(new VMRef._(peer, streams, json["vm"]));
    });
  }

  /// Sets the debugging [name] of the VM.
  ///
  /// Note that since this object is immutable, it needs to be reloaded to see
  /// the new name.
  Future setName(String name) =>
      _peer.sendRequest("setVMName", {"name": name});

  /// Loads the full representation of the VM.
  Future<VM> load() async =>
      new VM._(_peer, _streams, await _peer.sendRequest("getVM", {}));
}

/// Data about the Dart VM as a whole.
class VM extends VMRef {
  /// The word length of the target architecture, in bits.
  final int architectureBits;

  /// The name of the CPU for which the VM is generating code.
  final String targetCpu;

  /// The name of the CPU on which VM is actually running code.
  final String hostCpu;

  /// The semantic version of the Dart VM.
  ///
  /// Note that this is distinct from the VM service protocol version, which is
  /// accessible via [VMServiceClient.getVersion].
  final Version version;

  /// The full version string of the Dart VM.
  ///
  /// This includes more information than [version] alone.
  final String versionString;

  /// The process ID of the VM process.
  final int pid;

  /// The time at which the VM started running.
  final DateTime startTime;

  /// The currently-running isolates.
  final List<VMIsolateRef> isolates;

  VM._(rpc.Peer peer, StreamManager streams, Map json)
      : architectureBits = json["architectureBits"],
        targetCpu = json["targetCPU"],
        hostCpu = json["hostCPU"],
        version = new Version.parse(json["version"].split(" ").first),
        versionString = json["version"],
        // Prior to the service protocol v3.0, the pid was sent as a string.
        // Afterwards, it was sent as an int.
        pid = json["pid"] is String ? int.parse(json["pid"]) : json["pid"],
        startTime = new DateTime.fromMillisecondsSinceEpoch(
            // Prior to v3.0, this was emitted as a double rather than an int.
            json["startTime"].round()),
        isolates = new List.unmodifiable(json["isolates"]
            .map((isolate) => newVMIsolateRef(peer, streams, isolate))),
        super._(peer, streams, json);
}
