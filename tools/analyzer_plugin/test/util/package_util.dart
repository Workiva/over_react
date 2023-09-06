// From https://github.com/Workiva/over_react_codemod/blob/a14a4ef372a1b2c2a625755cec7a6f956a074650/lib/src/util/package_util.dart

// Copyright 2021 Workiva Inc.
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

import 'dart:io';

import 'package:collection/collection.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;

final _logger = Logger('orcm.pubspec');

bool _isPubGetNecessary(String packageRoot) {
  final packageConfig =
      File(p.join(packageRoot, '.dart_tool', 'package_config.json'));
  final pubspec = File(p.join(packageRoot, 'pubspec.yaml'));
  final pubspecLock = File(p.join(packageRoot, 'pubspec.lock'));

  if (!pubspec.existsSync()) {
    throw ArgumentError('pubspec.yaml not found in directory: $packageRoot');
  }

  if (packageConfig.existsSync() && pubspecLock.existsSync()) {
    return !pubspecLock.lastModifiedSync().isAfter(pubspec.lastModifiedSync());
  }

  return true;
}

/// Runs `pub get` in [packageRoot] unless running `pub get` would have no effect.
void runPubGetIfNeeded(String packageRoot) {
  if (_isPubGetNecessary(packageRoot)) {
    runPubGet(packageRoot);
  } else {
    _logger.info(
        'Skipping `pub get`, which has already been run, in `$packageRoot`');
  }
}

/// Runs `pub get` in [workingDirectory], and throws if the command completed
/// with a non-zero exit code.
///
/// For convenience, tries running with `pub get --offline` if `pub get` fails,
/// for a better experience when not authenticated to private pub servers.
void runPubGet(String workingDirectory) {
  _logger.info('Running `pub get` in `$workingDirectory`...');

  final result = Process.runSync('pub', ['get'],
      workingDirectory: workingDirectory,
      runInShell: true
  );
  final exitCode = result.exitCode;

  if (exitCode == 69) {
    _logger.info(
        'Re-running `pub get` but with `--offline`, to hopefully fix the above error.');
    final retryResult = Process.runSync('pub', ['get', '--offline'],
        workingDirectory: workingDirectory,
        runInShell: true);
    final exitCode = retryResult.exitCode;
    if (exitCode != 0) {
      throw Exception('pub get failed with exit code: $exitCode');
    }
  } else if (exitCode != 0) {
    throw Exception('pub get failed with exit code: $exitCode');
  }
}

/// Returns a path to the closest Dart package root (i.e., a directory with a
/// pubspec.yaml file) to [path], throwing if no package root can be found.
///
/// If [path] is itself a package root, it will be returned.
///
/// Example:
///
/// ```dart
/// // All of these return a path to 'some_package'
/// findPackageRootFor('some_package/lib/src/file.dart');
/// findPackageRootFor('some_package/lib/');
/// findPackageRootFor('some_package');
///
/// // Returns a path to 'some_package/subpackages/some_nested_package'
/// findPackageRootFor('some_package/some_nested_package/lib/file.dart');
/// ```
String findPackageRootFor(String path) {
  final packageRoot = [
    path,
    ...ancestorsOfPath(path)
  ].firstWhereOrNull((path) => File(p.join(path, 'pubspec.yaml')).existsSync());

  if (packageRoot == null) {
    throw Exception('Could not find package root for file `$path`');
  }

  return packageRoot;
}

/// Returns canonicalized paths for all the the ancestor directories of [path],
/// starting with its parent and working upwards.
Iterable<String> ancestorsOfPath(String path) sync* {
  path = p.canonicalize(path);

  // p.dirname of the root directory is the root directory, so if they're the same, stop.
  final parent = p.dirname(path);
  if (p.equals(path, parent)) return;

  yield parent;
  yield* ancestorsOfPath(parent);
}

/// Returns whether [file] is within a top-level `build` directory of a package root.
bool isNotWithinTopLevelBuildOutputDir(File file) =>
    !isWithinTopLevelDir(file, 'build');

/// Returns whether [file] is within a top-level `tool` directory of a package root.
bool isNotWithinTopLevelToolDir(File file) =>
    !isWithinTopLevelDir(file, 'tool');

/// Returns whether [file] is within a top-level [topLevelDir] directory
/// (e.g., `bin`, `lib`, `web`) of a package root.
bool isWithinTopLevelDir(File file, String topLevelDir) =>
    ancestorsOfPath(file.path).any((ancestor) =>
        p.basename(ancestor) == topLevelDir &&
        File(p.join(p.dirname(ancestor), 'pubspec.yaml')).existsSync());
