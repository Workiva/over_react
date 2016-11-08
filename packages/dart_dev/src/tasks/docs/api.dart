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

library dart_dev.src.tasks.docs.api;

import 'dart:async';
import 'dart:io';

import 'package:dart_dev/util.dart' show TaskProcess;

import 'package:dart_dev/src/tasks/task.dart';

class DocsFailure implements Exception {}

class DocsResult extends TaskResult {
  final Directory output;
  DocsResult()
      : super.success(),
        output = new Directory('doc/api/');
}

class DocsTask extends Task {
  static Future<DocsTask> start() async {
    DocsTask task = new DocsTask._();
    task._run();
    return task;
  }

  static Future<DocsResult> run() async {
    DocsTask task = new DocsTask._();
    return task._run();
  }

  static String _executable = 'pub';
  static List<String> _args = ['run', 'dartdoc'];

  Stream<String> _dartdocStderr;
  Stream<String> _dartdocStdout;

  Completer<DocsResult> _done = new Completer();

  DocsTask._();

  Future<DocsResult> get done => _done.future;
  Stream<String> get errorOutput => _dartdocStderr;
  Stream<String> get output => _dartdocStdout;
  String get pubCommand => '$_executable ${_args.join(' ')}';

  Future<DocsResult> _run() async {
    TaskProcess process = new TaskProcess(_executable, _args);
    _dartdocStderr = process.stderr;
    _dartdocStdout = process.stdout;
    await process.done;
    if (await process.exitCode > 0) {
      _done.completeError(new DocsFailure());
    } else {
      _done.complete(new DocsResult());
    }
    return _done.future;
  }
}
