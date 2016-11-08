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

import 'dart:async';
import 'dart:convert';

import 'package:resource/resource.dart' as resource;

import 'package:dart_dev/src/tasks/task.dart';

BashCompletionTask bashCompletion() {
  Completer done = new Completer();
  BashCompletionTask task = new BashCompletionTask(done.future);

  var script = new resource.Resource('package:dart_dev/bash-completion.sh');
  script.readAsString(encoding: UTF8).then((content) {
    task
      ..completionScript = content
      ..successful = true;
    done.complete();
  }).catchError((error) {
    done.complete();
  });

  return task;
}

class BashCompletionTask extends Task {
  final Future done;
  String completionScript;
  BashCompletionTask(Future this.done);
}
