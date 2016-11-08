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

library dart_dev.src.platform_util.mock_platform_util;

import 'dart:async';

import 'package:dart_dev/src/platform_util/platform_util.dart';
import 'package:dart_dev/src/platform_util/standard_platform_util.dart';

const List<String> _defaultInstalledExecutables = const ['lcov'];

const Map<String, dynamic> _defaultProjectDependencies = const {
  'coverage': '^0.7.2',
  'dart_style': '^0.2.0',
  'test': '^0.12.0'
};

class MockPlatformUtil implements PlatformUtil {
  /// List of executables installed on this platform. Does not actually need
  /// to be exhaustive, only needs to cover the executables that may be checked
  /// by a dart_dev task.
  static List<String> installedExecutables =
      _defaultInstalledExecutables.toList();

  /// Map of dependencies that are defined by the current project. This
  /// effectively mocks out any platform util that checks the pubspec.yaml
  /// for dependencies.
  static Map<String, dynamic> projectDependencies =
      new Map.from(_defaultProjectDependencies);

  static void install() {
    platformUtil = new MockPlatformUtil();
  }

  static void uninstall() {
    platformUtil = new StandardPlatformUtil();
    installedExecutables = _defaultInstalledExecutables.toList();
    projectDependencies = new Map.from(_defaultProjectDependencies);
  }

  bool hasImmediateDependency(String packageName) =>
      projectDependencies.containsKey(packageName);

  Future<bool> isExecutableInstalled(String executable) async =>
      installedExecutables.contains(executable);
}
