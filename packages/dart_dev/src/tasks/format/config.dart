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

library dart_dev.src.tasks.format.config;

import 'package:dart_dev/src/tasks/config.dart';

const bool defaultCheck = false;
const List<String> defaultDirectories = const ['lib/'];
const List<String> defaultExclude = const [];
const int defaultLineLength = 80;

class FormatConfig extends TaskConfig {
  bool check = defaultCheck;
  List<String> directories = defaultDirectories;
  List<String> exclude = defaultExclude;
  int lineLength = defaultLineLength;
}
