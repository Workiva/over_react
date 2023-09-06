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

import 'package:async/async.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/diagnostic/diagnostic.dart';
import 'package:analyzer/error/error.dart';
import 'package:path/path.dart' as p;
import 'package:source_span/source_span.dart';

// This isn't strictly required for anything, so if the import becomes invalid,
// just comment it and related code out.
import 'package:test_api/src/backend/invoker.dart' show Invoker;
import 'package:uuid/uuid.dart';

import 'package_util.dart';
import 'util.dart';

/// Provides a mechanism for getting resolved codemod [FileContext]s for test cases
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
  static final overReact = SharedAnalysisContext(p.join(
      findPackageRootFor(p.current), 'test/test_fixtures/over_react_project'));

  /// The path to the package root in which test files will be created
  /// and resolved.
  final String _path;

  /// The analysis context collection for files within [_path], initialized
  /// lazily.
  late final AnalysisContextCollection collection;

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
  final _testFileSubpath = 'lib/dynamic_test_files/${Uuid().v4()}';

  SharedAnalysisContext(this._path, {this.customPubGetErrorMessage}) {
    if (!p.isAbsolute(_path)) {
      throw ArgumentError.value(_path, 'projectRoot', 'must be absolute');
    }
  }

  // This ensures the _initIfNeeded logic is only ever run once, and prevents
  // race conditions if there are concurrent calls to it.
  final _initMemo = AsyncMemoizer<void>();

  Future<void> _initIfNeeded() => _initMemo.runOnce(() async {
        // Note that if tests are run concurrently, then concurrent pub gets will be run.
        // This is hard to avoid (trying to avoid it using a filesystem lock in
        // macOS/Linux doesn't work due to advisory lock behavior), but intermittently
        // causes issues, so message referencing exit code 66 and workaround below.
        try {
          await runPubGetIfNeeded(_path);
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

        collection = AnalysisContextCollection(
          includedPaths: [_path],
        );
      });

  /// Warms up the AnalysisContextCollection by running `pub get` (if needed) and
  /// initializing [collection] if that hasn't been done yet, and getting the
  /// resolved library for `lib/analysis_warmup.dart` in the project.
  ///
  /// This is useful to run in a `setUpAll` so that the first test resolving a file
  /// doesn't take abnormally long (e.g., if having consistent test times is
  /// important, or if the first test might have a short timeout).
  Future<void> warmUpAnalysis() async {
    await _initIfNeeded();
    final path = p.join(_path, 'lib/analysis_warmup.dart');
    await collection.contextFor(path).currentSession.getResolvedLibrary(path);
    _shouldPrintFirstFileWarning = false;
  }
  //
  // /// A convenience method that creates a codemod [FileContext],
  // /// run [suggestor] on it, and returns the patches yielded.
  // ///
  // /// Most arguments are forwarded to [resolvedFileContextForTest];
  // /// see that method for more details.
  // Future<List<Patch>> getPatches(
  //   Suggestor suggestor,
  //   String sourceText, {
  //   String? filename,
  //   bool preResolveLibrary = true,
  //   bool throwOnAnalysisErrors = true,
  // }) async {
  //   final context = await resolvedFileContextForTest(
  //     sourceText,
  //     preResolveLibrary: preResolveLibrary,
  //     throwOnAnalysisErrors: throwOnAnalysisErrors,
  //     filename: filename,
  //   );
  //   return await suggestor(context).toList();
  // }

  /// Creates a new file within [_testFileSubpath] with the name [filename]
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
  ///
  /// If [preResolveLibrary] is `true`, then the file will be resolved as a library
  /// and checked for errors (if [throwOnAnalysisErrors] is `true`) to help
  /// validate that there are no issues resolving the test file, which are likely
  /// the result of a bad test file that could result in false positives or
  /// confusing errors in your test.
  ///
  /// If you expect analysis errors in your test file, provide a [isExpectedError]
  /// so that those errors can be ignored while others can be filtered out.
  Future<FileContext> resolvedFileContextForTest(
    String sourceText, {
    String? filename,
    bool includeTestDescription = true,
    bool preResolveLibrary = true,
    bool throwOnAnalysisErrors = true,
    IsExpectedError? isExpectedError,
  }) async {
    await _initIfNeeded();

    filename ??= nextFilename();

    if (includeTestDescription) {
      // For convenience, include the current test description in the file as
      // a comment, so that:
      // - you can tell you're looking at the right file for a given test
      // - you can search for the test description to easily find the right file
      try {
        final testName = Invoker.current!.liveTest.test.name;
        sourceText =
            lineComment('Created within test with name:\n> $testName') +
                '\n' +
                sourceText;
      } catch (_) {}
    }

    final path = p.join(_path, _testFileSubpath, filename);
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

    final context = collection.contexts
        .singleWhere((c) => c.contextRoot.root.path == _path);

    if (throwOnAnalysisErrors && !preResolveLibrary) {
      throw ArgumentError(
          'If throwOnAnalysisErrors is true, preResolveFile must be false');
    }
    if (isExpectedError != null && !throwOnAnalysisErrors) {
      throw ArgumentError(
          'If isExpectedError is provided, throwOnAnalysisErrors must be true');
    }
    if (preResolveLibrary) {
      final result = await _printAboutFirstFile(
          () => context.currentSession.getResolvedLibrary(path));
      if (throwOnAnalysisErrors) {
        checkResolvedResultForErrors(result, isExpectedError: isExpectedError);
      }
    }

    // Assert that this doesn't throw a StateError due to this file not
    // existing in the context we've set up (which shouldn't ever happen).
    collection.contextFor(path);

    return FileContext(path, collection, root: _path);
  }

  int _fileNameCounter = 0;

  /// Returns a filename that hasn't been used before.
  String nextFilename() => 'test_${_fileNameCounter++}.dart';

  bool _shouldPrintFirstFileWarning = true;

  /// We can't intelligently warn only when this is taking too long since
  /// getResolvedLibrary2 blocks the main thread for a long period of time,
  /// making it so that timers don't fire until it's done.
  /// So, we'll just always print this.
  Future<T> _printAboutFirstFile<T>(Future<T> Function() callback) async {
    var shouldPrint = false;
    if (_shouldPrintFirstFileWarning) {
      _shouldPrintFirstFileWarning = false;
      shouldPrint = true;
    }

    if (shouldPrint) {
      final contextName = p.basename(_path);
      print('Resolving a file for the first time in context "$contextName";'
          ' this will take a few seconds...');
    }
    final result = await callback();
    if (shouldPrint) {
      print('Done resolving.');
    }
    return result;
  }
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
    throw ArgumentError([
      'Error resolving file; result was $result.',
      sharedMessage
    ].join(' '));
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

extension ParseHelpers on SharedAnalysisContext {
  /// Returns [expression] parsed as AST.
  ///
  /// This is accomplished it by including the [expression] as a statement within a wrapper function
  /// with any necessary [imports] at the top of the source. As a result, the offset of the
  /// returned expression will not be 0.
  ///
  /// To return resolved AST, set [isResolved] to true.
  Future<Expression> parseExpression(
    String expression, {
    String imports = '',
    String otherSource = '',
    bool isResolved = false,
  }) async {
    CompilationUnit unit;
    // Wrap the expression in parens to ensure this is interpreted as an expression
    // for ambiguous cases (e.g, a map literal that could be interpreted as an empty block).
    final source = '''
      $imports
      void wrapperFunction() {
        ($expression);
      }
      $otherSource
    ''';
    final fileContext = await resolvedFileContextForTest(source,
        // We don't want to get the resolved unit if `isResolve = false`,
        // since it may fail.
        preResolveLibrary: false,
        throwOnAnalysisErrors: false);
    if (isResolved) {
      final result = await fileContext.getResolvedUnit();
      unit = (result as ResolvedUnitResult).unit;
    } else {
      unit = fileContext.getUnresolvedUnit();
    }
    final parsedFunction = unit.childEntities
        .whereType<FunctionDeclaration>()
        .singleWhere((function) => function.name.lexeme == 'wrapperFunction');
    final body = parsedFunction.functionExpression.body as BlockFunctionBody;
    final statement = body.block.statements.single as ExpressionStatement;
    return (statement.expression as ParenthesizedExpression).expression;
  }
}


/// A helper class for a file located at [path] that provides access to its
/// contents and analyzed formats like [CompilationUnit] and [LibraryElement].
class FileContext {
  final AnalysisContextCollection _analysisContextCollection;

  /// This file's absolute path.
  final String path;

  /// This file's path relative to [root].
  final String relativePath;

  /// The path to the working directory from which this file was discovered.
  ///
  /// Defaults to current working directory.
  final String root;

  FileContext(this.path, this._analysisContextCollection, {String? root})
      : root = root ?? p.current,
        relativePath = p.relative(path, from: root) {
    if (!p.isAbsolute(path)) {
      throw ArgumentError.value(path, 'path', 'must be absolute.');
    }
  }

  /// A representation of this file that makes it easy to reference spans of
  /// text, which is useful for the creation of [SourcePatch]es.
  late final SourceFile sourceFile =
      SourceFile.fromString(sourceText, url: Uri.file(path));

  /// The contents of this file.
  late final String sourceText = File(path).readAsStringSync();

  /// Uses the analyzer to resolve and return the library result for this file,
  /// which includes the [LibraryElement].
  Future<ResolvedLibraryResult?> getResolvedLibrary() async {
    final result = await _analysisContextCollection
        .contextFor(path)
        .currentSession
        .getResolvedLibrary(path);
    return result is ResolvedLibraryResult ? result : null;
  }

  /// Uses the analyzer to resolve and return the AST result for this file,
  /// which includes the [CompilationUnit].
  ///
  /// If the fully resolved AST is not needed, use the much faster
  /// [getUnresolvedUnit].
  Future<SomeResolvedUnitResult> getResolvedUnit() async {
    return _analysisContextCollection
        .contextFor(path)
        .currentSession
        .getResolvedUnit(path);
  }

  /// Returns the unresolved AST for this file.
  ///
  /// If the fully resolved AST is needed, use [getResolvedUnit].
  CompilationUnit getUnresolvedUnit() {
    final result =
        parseString(content: sourceText, path: path, throwIfDiagnostics: false);
    if (result.errors.isEmpty) return result.unit;

    // Errors thrown by parseString don't include the filename, and result in
    // the codemod halting without indicating which file it failed on.
    // To aid in debugging, we'll construct the error message the same way
    // parseString does, but also include the path to the file.
    var buffer = StringBuffer();
    for (final error in result.errors) {
      var location = result.lineInfo.getLocation(error.offset);
      buffer.writeln('  ${error.errorCode.name}: ${error.message} - '
          '${location.lineNumber}:${location.columnNumber}');
    }
    throw ArgumentError(
        'File "$relativePath" produced diagnostics when parsed:\n$buffer');
  }
}
