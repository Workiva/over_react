// From https://github.com/Workiva/over_react_codemod/blob/a14a4ef372a1b2c2a625755cec7a6f956a074650/test/resolved_file_context.dart

// ignore_for_file: comment_references

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

import 'dart:async';
import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/diagnostic/diagnostic.dart';
import 'package:analyzer/error/error.dart';
import 'package:io/io.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

import 'package_util.dart';
import 'util.dart';

/// Provides a mechanism for getting resolved codemod [TestFile]s for test cases
/// using a shared context root, allowing:
///
/// - the resolution of package imports (provided they're depended on in the context root's pubspec.yaml)
/// - multiple tests to run without `pub get`-ing in a new package or spinning up
///   a new same [AnalysisContextCollection], which dramatically improves test run times
///   if there are many tests that rely on a resolved context.
///
/// Also, re-using a fixed directory instead of a new temporary directory each time
/// means that `pub get`s from the previous run as well as any analysis cached
/// within `~/.dartServer` can be reused between test runs, which means faster
/// test runs during local development.
class SharedAnalysisContext {
  /// A context root located at `test/test_fixtures/over_react_project`
  /// that depends on the `over_react` package.
  static final overReact =
      SharedAnalysisContext(p.join(findPackageRootFor(p.current), 'test/test_fixtures/over_react_project'));

  /// Creates a temporary copy of the files in this context.
  ///
  /// Useful when you want mostly the same setup as an existing context,
  /// but need additional changes to pubspec.yaml or analysis_options.yaml.
  static SharedAnalysisContext createTemporaryCopy(SharedAnalysisContext other, String newParentDirectory) {
    final copyParentDir = Directory(p.join(findPackageRootFor(p.current), newParentDirectory));
    copyParentDir.createSync(recursive: true);
    final copyDir = copyParentDir.createTempSync().path;
    // Adapted from package:io 1.0.4 `copyPathSync`.
    // Permalink https://github.com/dart-lang/io/blob/0c6fa36867b64748639515d5ea37b99176772756/lib/src/copy_path.dart#L54
    //
    // Copyright 2017, the Dart project authors.
    //
    // Redistribution and use in source and binary forms, with or without
    // modification, are permitted provided that the following conditions are
    // met:
    //
    //     * Redistributions of source code must retain the above copyright
    //       notice, this list of conditions and the following disclaimer.
    //     * Redistributions in binary form must reproduce the above
    //       copyright notice, this list of conditions and the following
    //       disclaimer in the documentation and/or other materials provided
    //       with the distribution.
    //     * Neither the name of Google LLC nor the names of its
    //       contributors may be used to endorse or promote products derived
    //       from this software without specific prior written permission.
    //
    // THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
    // "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
    // LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
    // A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
    // OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
    // SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
    // LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
    // DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
    // THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
    // (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
    // OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
    for (final file in Directory(other.contextRootPath).listSync(recursive: false)) {
      if (const {'pubspec.lock', '.dart_tool'}.contains(p.basename(file.path))) {
        continue;
      }

      final copyTo = p.join(copyDir, p.relative(file.path, from: other.contextRootPath));
      if (file is Directory) {
        copyPathSync(file.path, copyTo);
      } else if (file is File) {
        File(file.path).copySync(copyTo);
      } else if (file is Link) {
        Link(copyTo).createSync(file.targetSync(), recursive: true);
      }
    }
    return SharedAnalysisContext._temporaryCopy(copyDir, customPubGetErrorMessage: other.customPubGetErrorMessage);
  }

  /// The path to the package root in which test files will be created
  /// and resolved.
  final String contextRootPath;

  /// Whether this is a temporary copy of another shared context that should be deleted after use.
  final bool isTemporaryCopy;

  /// The analysis context collection for files within [contextRootPath], initialized
  /// lazily.
  late final AnalysisContextCollection collection = _initCollection();

  /// A custom error message to display if `pub get` fails.
  final String? customPubGetErrorMessage;

  // Namespace the test path using a UUID so that concurrent runs
  // don't try to output the same filename, making it so that we can
  // easily create new filenames by counting synchronously [nextFilename]
  // without coordinating with other test processes.
  //
  // This also allows us to keep using the same project directory among concurrent tests
  // and across test runs, which means the Dart analysis server can use cached
  // analysis results (meaning faster test runs).
  final _testFileSubpath = 'dynamic_test_files/${Uuid().v4()}';

  SharedAnalysisContext._(
      {required this.contextRootPath, required this.isTemporaryCopy, this.customPubGetErrorMessage}) {
    if (!p.isAbsolute(contextRootPath)) {
      throw ArgumentError.value(contextRootPath, 'projectRoot', 'must be absolute');
    }
  }

  SharedAnalysisContext._temporaryCopy(String contextRootPath, {String? customPubGetErrorMessage})
      : this._(
          contextRootPath: contextRootPath,
          customPubGetErrorMessage: customPubGetErrorMessage,
          isTemporaryCopy: true,
        );

  SharedAnalysisContext(String contextRootPath, {String? customPubGetErrorMessage})
      : this._(
          contextRootPath: contextRootPath,
          customPubGetErrorMessage: customPubGetErrorMessage,
          isTemporaryCopy: false,
        );

  AnalysisContextCollection _initCollection() {
    // Note that if tests are run concurrently, then concurrent pub gets will be run.
    // This is hard to avoid (trying to avoid it using a filesystem lock in
    // macOS/Linux doesn't work due to advisory lock behavior), but intermittently
    // causes issues, so message referencing exit code 66 and workaround below.
    try {
      runPubGetIfNeeded(contextRootPath);
    } catch (e, st) {
      var message = [
        // ignore: no_adjacent_strings_in_list
        'If the exit code is 66, the issue is likely concurrent `pub get`s on'
            ' this directory from concurrent test entrypoints.'
            ' Regardless of the exit code, if in CI, try running `pub get`'
            ' in this directory before running any tests.',
        if (customPubGetErrorMessage != null) customPubGetErrorMessage,
      ].join(' ');
      throw Exception('$message\nOriginal exception: $e$st');
    }

    return AnalysisContextCollection(
      includedPaths: [contextRootPath],
    );
  }

  /// Warms up the AnalysisContextCollection by running `pub get` (if needed) and
  /// initializing [collection] if that hasn't been done yet, and getting the
  /// resolved library for `lib/analysis_warmup.dart` in the project.
  ///
  /// This is useful to run in a `setUpAll` so that the first test resolving a file
  /// doesn't take abnormally long (e.g., if having consistent test times is
  /// important, or if the first test might have a short timeout).
  Future<void> warmUpAnalysis() async {
    final path = p.join(contextRootPath, 'lib/analysis_warmup.dart');
    await collection.contextFor(path).currentSession.getResolvedLibrary(path);
  }

  /// Creates a new file within [topLevelDirectory]/[_testFileSubpath] with the name [filename]
  /// (or a generated filename if not specified) and the given [sourceText]
  /// and returns a codemod FileContext for that file.
  ///
  /// Throws if [filename] has already been used before in this instance,
  /// to prevent the wrong results from being returned.
  /// Since there's no public analyzer API to get an updated result for a file
  /// that has been modified, reusing a file name means that [collection] or
  /// the returned context backed by [collection] could return results for a previous
  /// call to this method, and not results containing the updated [sourceText].
  /// And, even if there were a way to update it, reusing file names would be prone
  /// to race conditions, so this restriction will likely never be removed.
  String createTestFile(
    String sourceText, {
    String? filename,
    String topLevelDirectory = 'lib',
  }) {
    if (topLevelDirectory != p.basename(topLevelDirectory)) {
      throw ArgumentError.value(topLevelDirectory, 'topLevelDirectory', 'must be a directory name and not a path');
    }

    filename ??= nextFilename();
    final path = p.join(contextRootPath, topLevelDirectory, _testFileSubpath, filename);
    final file = File(path);
    if (file.existsSync()) {
      throw StateError('File already exists: $filename.'
          ' Cannot use an existing file, since there is no public API'
          ' to update a file within a AnalysisContextCollection.'
          ' Make sure you\'re using a unique filename each time.'
          ' This error can also occur if there are concurrent test runs'
          ' and `_testFileSubpath` is not namespaced.');
    }
    file.parent.createSync(recursive: true);
    file.writeAsStringSync(sourceText);

    // Assert that this doesn't throw a StateError due to this file not
    // existing in the context we've set up (which shouldn't ever happen).
    collection.contextFor(path);

    return path;
  }

  int _fileNameCounter = 0;

  /// Returns a filename that hasn't been used before.
  String nextFilename() => 'test_${_fileNameCounter++}.dart';
}

/// A function that returns whether an error is expected and thus should be ignored
typedef IsExpectedError = bool Function(AnalysisError);

/// Checks [result] (usually the return value of a call to `AnalysisSession.getResolvedLibrary2`)
/// and throws if:
///
/// - there were any issues getting the resolved result
/// - there are analysis errors (other than those for which [isExpectedError] returns `true`)
///   that are either have an `error` severity or are otherwise potentially problematic
///   (e.g., unused members, which may mean there's a typo in the test)
void checkResolvedResultForErrors(
  SomeResolvedLibraryResult result, {
  IsExpectedError? isExpectedError,
}) {
  isExpectedError ??= (_) => false;

  const sharedMessage = 'If analysis errors are expected for this test, either:'
      '\n1. specify `isExpectedError` with a function that returns true'
      ' only for your expected error'
      '\n2. use an `ignore:` comment to silence them'
      '\n3. set `throwOnAnalysisErrors: false`,'
      ' and use `checkResolvedResultForErrors` with `isExpectedError`'
      ' to verify that only the expected errors are present.';

  if (result is! ResolvedLibraryResult) {
    throw ArgumentError(['Error resolving file; result was $result.', sharedMessage].join(' '));
  }

  final unexpectedErrors = result.units
      .expand((unit) => unit.errors)
      .where((error) =>
          error.severity == Severity.error ||
          const {
            'unused_element',
            'unused_local_variable',
          }.contains(error.errorCode.name.toLowerCase()))
      // We need a non-null-assertion here due to https://github.com/dart-lang/sdk/issues/40790
      .where((error) => !isExpectedError!(error))
      .toList();
  if (unexpectedErrors.isNotEmpty) {
    throw ArgumentError([
      // ignore: no_adjacent_strings_in_list
      'File had analysis errors or unused element hints,'
          ' which likely indicate that the test file is set up improperly,'
          ' potentially resulting in false positives in your test.',
      sharedMessage,
      'Errors:\n${prettyPrintErrors(unexpectedErrors)}.'
    ].join(' '));
  }
}

extension FileSystemDeleteIfExistExtension on FileSystemEntity {
  void deleteSyncIfExists({bool recursive = false}) {
    if (existsSync()) {
      deleteSync(recursive: recursive);
    }
  }

  Future<void> deleteIfExists({bool recursive = false}) async {
    if (existsSync()) {
      await delete(recursive: recursive);
    }
  }
}
