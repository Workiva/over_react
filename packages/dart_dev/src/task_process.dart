// Copyright 2015 Workiva Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

library dart_dev.src.task_process;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

class TaskProcess {
  Completer _donec = new Completer();
  Completer _errc = new Completer();
  Completer _outc = new Completer();
  Completer<int> _procExitCode = new Completer();
  Process _process;

  StreamController<String> _stdout = new StreamController();
  StreamController<String> _stderr = new StreamController();

  TaskProcess(String executable, List<String> arguments,
      {String workingDirectory}) {
    Process
        .start(executable, arguments, workingDirectory: workingDirectory)
        .then((process) {
      _process = process;
      process.stdout
          .transform(UTF8.decoder)
          .transform(new LineSplitter())
          .listen(_stdout.add, onDone: _outc.complete);
      process.stderr
          .transform(UTF8.decoder)
          .transform(new LineSplitter())
          .listen(_stderr.add, onDone: _errc.complete);
      _outc.future.then((_) => _stdout.close());
      _errc.future.then((_) => _stderr.close());
      process.exitCode.then(_procExitCode.complete);
      Future.wait([_outc.future, _errc.future, process.exitCode]).then(
          (_) => _donec.complete());
    });
  }

  Future get done => _donec.future;

  Future<int> get exitCode => _procExitCode.future;

  Stream<String> get stderr => _stderr.stream;
  Stream<String> get stdout => _stdout.stream;

  bool kill([ProcessSignal signal = ProcessSignal.SIGTERM]) =>
      _process.kill(signal);

  Future<bool> killAllChildren(
      [ProcessSignal signal = ProcessSignal.SIGTERM]) async {
    List<int> cpids = await _getChildPids();
    cpids.remove(_process.pid);
    bool killed = true;
    for (int i = 0; i < cpids.length; i++) {
      killed = killed && Process.killPid(cpids[i], signal);
    }
    return killed;
  }

  Future<List<int>> _getChildPids({List<int> pids}) async {
    pids = pids ?? [_process.pid];
    String executable = 'pgrep';
    List<TaskProcess> pgreps = [];
    var args = [];
    List<int> cpids = [];
    for (int pid in pids) {
      args = [];
      args.add('-P');
      args.add(pid.toString());
      var pgrep = new TaskProcess(executable, args);
      pgrep.stdout.listen((l) {
        cpids.add(int.parse(l));
      });
      pgreps.add(pgrep);
    }
    await Future.wait(pgreps.map((pgrep) => pgrep.done));

    if (cpids.isNotEmpty) {
      cpids.addAll(await _getChildPids(pids: cpids));
    }
    return cpids;
  }
}
