// From https://github.com/Workiva/over_react_codemod/blob/a14a4ef372a1b2c2a625755cec7a6f956a074650/test/util/package_util_test.dart
//
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


import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import './package_util.dart';

void main() {
  group('Package Utilities', () {
    // Use a utility to determine the path to the root directory since it will
    // be different when run locally or in CI.
    final currentPathFromRoot = p.canonicalize('.');

    group('findPackageRootFor', () {
      test('on the current directory', () {
        expect(findPackageRootFor('.'), equals('.'));
      });

      test('on a nested file', () {
        expect(
          findPackageRootFor('./test/util/package_util_test.dart'),
          equals(currentPathFromRoot),
        );
      });

      test('with a nested pubspec', () {
        expect(
          findPackageRootFor(
              'test/test_fixtures/over_react_project/lib/analysis_warmup.dart'),
          equals('$currentPathFromRoot/test/test_fixtures/over_react_project'),
        );
      });

      test('on a pubspec file', () {
        expect(
          findPackageRootFor('$currentPathFromRoot/pubspec.yaml'),
          equals(currentPathFromRoot),
        );
      });

      test('when a pubspec cannot be found', () {
        final tmpDir = Directory.systemTemp.createTempSync();
        addTearDown(tmpDir.deleteSync);
        expect(
          () => findPackageRootFor(tmpDir.path),
          throwsA(isA<Exception>()
              .havingToStringValue(contains('Could not find package root'))),
        );
      });
    });

    group('ancestorsOfPath', () {
      final ancestorsOfPathFromRoot = <String>[];

      setUpAll(() {
        // Determine the expected ancestors of the current path from root.
        final segments = p.split(currentPathFromRoot);
        for (var i = 1; i < segments.length; i++) {
          ancestorsOfPathFromRoot
              .add(p.joinAll(segments.sublist(0, segments.length - i)));
        }
      });

      test('for a nested file', () {
        expect(
          ancestorsOfPath(
              'test/test_fixtures/over_react_project/lib/analysis_warmup.dart'),
          orderedEquals(<String>[
            '$currentPathFromRoot/test/test_fixtures/over_react_project/lib',
            '$currentPathFromRoot/test/test_fixtures/over_react_project',
            '$currentPathFromRoot/test/test_fixtures',
            '$currentPathFromRoot/test',
            currentPathFromRoot,
            ...ancestorsOfPathFromRoot,
          ]),
        );
      });

      test('for a nested directory', () {
        expect(
          ancestorsOfPath('lib/src/util'),
          orderedEquals(<String>[
            '$currentPathFromRoot/lib/src',
            '$currentPathFromRoot/lib',
            currentPathFromRoot,
            ...ancestorsOfPathFromRoot,
          ]),
        );
      });

      test('on the current directory', () {
        expect(
          ancestorsOfPath('.'),
          orderedEquals(ancestorsOfPathFromRoot),
        );
      });
    });

    group('top-level directory checking utilities', () {
      List<File>? filesInTopLevelDir;
      List<File>? filesNotInTopLevelBuildDir;

      // Set the top level directory that the test cases use for verifying output.
      void _initializeTestCases(String directory) {
        filesInTopLevelDir = [
          File('$directory/some_place/some_file.dart'),
          File(
              'test/test_fixtures/over_react_project/$directory/lib/analysis_warmup.dart'),
        ];
        filesNotInTopLevelBuildDir = [
          File('test/$directory/some_place/some_file.dart'),
          File('some_file.dart'),
          File(
              'test/test_fixtures/$directory/over_react_project/lib/analysis_warmup.dart'),
          File(
              'test/test_fixtures/over_react_project/lib/$directory/analysis_warmup.dart'),
        ];
      }

      tearDown(() {
        filesInTopLevelDir = null;
        filesNotInTopLevelBuildDir = null;
      });

      group('isWithinTopLevelDir', () {
        const testDirectory = 'some_directory';

        test('for files in top-level dir input', () {
          _initializeTestCases(testDirectory);
          for (final file in filesInTopLevelDir!) {
            expect(
              isWithinTopLevelDir(file, testDirectory),
              isTrue,
              reason: '${file.path} is in a top-level $testDirectory directory',
            );
          }
        });

        test('for files not in top-level dir input', () {
          _initializeTestCases(testDirectory);
          for (final file in filesNotInTopLevelBuildDir!) {
            expect(
              isWithinTopLevelDir(file, testDirectory),
              isFalse,
              reason:
                  '${file.path} is not in a top-level $testDirectory directory',
            );
          }
        });
      });

      group('isNotWithinTopLevelBuildOutputDir', () {
        test('for files in top-level build dir', () {
          _initializeTestCases('build');
          for (final file in filesInTopLevelDir!) {
            expect(
              isNotWithinTopLevelBuildOutputDir(file),
              isFalse,
              reason: '${file.path} is in a top-level build directory',
            );
          }
        });

        test('for files not in top-level build dir', () {
          _initializeTestCases('build');
          for (final file in filesNotInTopLevelBuildDir!) {
            expect(
              isNotWithinTopLevelBuildOutputDir(file),
              isTrue,
              reason: '${file.path} is not in a top-level build directory',
            );
          }
        });
      });

      group('isNotWithinTopLevelToolDir', () {
        test('for files in top-level tool dir', () {
          _initializeTestCases('tool');
          for (final file in filesInTopLevelDir!) {
            expect(
              isNotWithinTopLevelToolDir(file),
              isFalse,
              reason: '${file.path} is in a top-level tool directory',
            );
          }
        });

        test('for files not in top-level tool dir', () {
          _initializeTestCases('tool');
          for (final file in filesNotInTopLevelBuildDir!) {
            expect(
              isNotWithinTopLevelToolDir(file),
              isTrue,
              reason: '${file.path} is not in a top-level tool directory',
            );
          }
        });
      });
    });
  });
}

extension ObjectMatchers on TypeMatcher<Object> {
  Matcher havingToStringValue(dynamic matcher) =>
      having((p) => p.toString(), 'toString() value', matcher);
}
