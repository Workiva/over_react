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

library dart_dev.api;

export 'package:dart_dev/src/tasks/analyze/api.dart' show AnalyzeTask, analyze;
export 'package:dart_dev/src/tasks/examples/api.dart'
    show ExamplesTask, serveExamples;
export 'package:dart_dev/src/tasks/format/api.dart' show FormatTask, format;
export 'package:dart_dev/src/tasks/init/api.dart' show InitTask, init;
export 'package:dart_dev/src/tasks/test/api.dart' show TestTask, test;
