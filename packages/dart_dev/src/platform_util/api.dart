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

library dart_dev.src.platform_util.api;

import 'dart:async';

import 'package:dart_dev/src/platform_util/platform_util.dart';

/// Determines whether or not the project in the current working directory has
/// defined [packageName] as an immediate dependency. In other words, this
/// checks if [packageName] is in the project's pubspec.yaml.
bool hasImmediateDependency(String packageName) =>
    PlatformUtil.retrieve().hasImmediateDependency(packageName);

/// Determines whether or not [executable] is installed on this platform.
Future<bool> isExecutableInstalled(String executable) =>
    PlatformUtil.retrieve().isExecutableInstalled(executable);
