// Copyright 2020 Workiva Inc.
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

/// A very basic library to test generation on files which are part of a library
library basic.library;

import 'package:over_react/over_react.dart';
import 'props_mixin.dart';
import 'state_mixin.dart';

part 'basic_library.over_react.g.dart';

part 'part_of_basic_library.dart';
part 'part_of_basic_library_2.dart';
