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

library dart_dev.src.version;

import 'dart:io';

import 'package:yaml/yaml.dart';

/// Copied from "test" package.
///
/// Attempts to parse the version number of the `dart_dev` package
/// from the pubspec.lock file. This will not work if run within
/// the `dart_dev` package or if `dart_dev` is activated as a global
/// package.
bool printVersion() {
  var lockfile;
  try {
    lockfile = loadYaml(new File('pubspec.lock').readAsStringSync());
  } on FormatException catch (_) {
    return false;
  } on IOException catch (_) {
    return false;
  }

  if (lockfile is! Map) return false;
  var packages = lockfile['packages'];
  if (packages is! Map) return false;
  var package = packages['dart_dev'];
  if (package is! Map) return false;

  var source = package['source'];
  if (source is! String) return false;

  switch (source) {
    case 'hosted':
      var version = package['version'];
      if (version is! String) return false;

      stdout.writeln(version);
      return true;

    case 'git':
      var version = package['version'];
      if (version is! String) return false;
      var description = package['description'];
      if (description is! Map) return false;
      var ref = description['resolved-ref'];
      if (ref is! String) return false;

      stdout.writeln('$version (${ref.substring(0, 7)})');
      return true;

    case 'path':
      var version = package['version'];
      if (version is! String) return false;
      var description = package['description'];
      if (description is! Map) return false;
      var path = description['path'];
      if (path is! String) return false;

      stdout.writeln('$version (from $path)');
      return true;

    default:
      return false;
  }
}
