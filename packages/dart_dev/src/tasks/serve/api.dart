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

library dart_dev.src.tasks.serve.api;

import 'dart:async';

import 'package:dart_dev/util.dart' show TaskProcess;

/// A regular expression that matches the output of "pub serve".
final RegExp _servingRegExp =
    new RegExp(r'^Serving [^ ]+ +([^ ]+) +on http://localhost:(\d+)$');

/// Starts a Pub server on the specified [port] and returns the associated
/// [PubServeTask].
///
/// If [port] is 0, `pub serve` will pick its own port automatically.
PubServeTask startPubServe({int port: 0, List additionalArgs}) {
  var pubServeExecutable = 'pub';
  var pubServeArgs = ['serve', '--port=$port'];
  if (additionalArgs != null) {
    pubServeArgs.addAll(additionalArgs);
  }

  TaskProcess pubServeProcess =
      new TaskProcess(pubServeExecutable, pubServeArgs);

  var pubServeInfos = new StreamController<PubServeInfo>();

  var task = new PubServeTask('$pubServeExecutable ${pubServeArgs.join(' ')}',
      pubServeInfos.stream, pubServeProcess.done, pubServeProcess.kill);

  pubServeProcess.stdout.listen((String line) {
    task._pubServeStdOut.add(line);

    var match = _servingRegExp.firstMatch(line);
    if (match != null) {
      var directory = match[1];
      var port = int.parse(match[2]);
      pubServeInfos.add(new PubServeInfo(directory, port));
    }
  });

  pubServeProcess.stderr.listen(task._pubServeStdErr.add);

  return task;
}

class PubServeInfo {
  final int port;
  final String directory;

  PubServeInfo(String this.directory, int this.port);
}

class PubServeTask {
  final String command;
  final Stream<PubServeInfo> serveInfos;
  final Future done;
  final Function _stop;

  StreamController<String> _pubServeStdOut = new StreamController.broadcast();
  StreamController<String> _pubServeStdErr = new StreamController.broadcast();

  PubServeTask(String this.command, Stream<PubServeInfo> this.serveInfos,
      Future this.done, void this._stop()) {
    done.then((_) {
      _pubServeStdOut.close();
      _pubServeStdErr.close();
    });
  }

  void stop() {
    _stop();
  }

  Stream<String> get stdOut => _pubServeStdOut.stream;
  Stream<String> get stdErr => _pubServeStdErr.stream;
}

/// Returns a Stream that proxies [stream] until [cancelled] completes or [stream] closes.
StreamTransformer<String, String> until(Future cancelled) {
  return new StreamTransformer((Stream<String> input, bool cancelOnError) {
    StreamController<String> controller;
    StreamSubscription<String> subscription;
    controller = new StreamController<String>(
        onListen: () {
          subscription = input.listen(controller.add,
              onError: controller.addError,
              onDone: controller.close,
              cancelOnError: cancelOnError);
        },
        onPause: () => subscription.pause(),
        onResume: () => subscription.resume(),
        onCancel: () => subscription.cancel(),
        sync: true);

    cancelled.then((_) {
      controller.close();
    });

    return controller.stream.listen(null);
  });
}
