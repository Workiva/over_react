// Copyright 2023 Workiva Inc.
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

@TestOn('vm')
import 'dart:io';

import 'package:test/test.dart';

main() {
  group('conditionally null safe builder', () {
    group('on package-level Dart language version that is not null safe', () {
      setUpAll(() {
        const nonNullSafePackagePath =
            'test_fixtures/test_packages/non_null_safe';
        Process.runSync('dart', ['pub', 'get'],
            workingDirectory: nonNullSafePackagePath);
        final build = Process.runSync(
            'dart', ['pub', 'run', 'build_runner', 'build'],
            workingDirectory: nonNullSafePackagePath);

        expect(build.exitCode, 0,
            reason: 'build should have succeeded.'
                '\nstdout: ${build.stdout}'
                '\nstderr: ${build.stderr}');
      });

      test('', () {
        final expectedGeneratedFile = File(
            'test_fixtures/test_packages/non_null_safe/.dart_tool/build/generated/over_react__test__non_null_safe/lib/test.over_react.g.dart');
        expect(expectedGeneratedFile.existsSync(), isTrue,
            reason:
                'File should have been generated: ${expectedGeneratedFile.path}');
        expect(
            expectedGeneratedFile.readAsStringSync(),
            contains(
                'Using nullSafety: false. {languageVersion: 2.11, source: packageConfig, package: over_react__test__non_null_safe}'));
      });

      test('but has a null safe language version comment', () {
        final expectedGeneratedFile = File(
            'test_fixtures/test_packages/non_null_safe/.dart_tool/build/generated/over_react__test__non_null_safe/lib/test_language_version_comment.over_react.g.dart');
        expect(expectedGeneratedFile.existsSync(), isTrue,
            reason:
                'File should have been generated: ${expectedGeneratedFile.path}');
        expect(
            expectedGeneratedFile.readAsStringSync(),
            contains(
                'Using nullSafety: true.  {languageVersion: 2.13, source: libraryVersionComment}'));
      });

      group('for null safe dependency', () {
        test('', () {
          final expectedGeneratedFile = File(
              'test_fixtures/test_packages/non_null_safe/.dart_tool/build/generated/over_react__test__null_safe/lib/test.over_react.g.dart');
          expect(expectedGeneratedFile.existsSync(), isTrue,
              reason:
              'File should have been generated: ${expectedGeneratedFile.path}');
          expect(
              expectedGeneratedFile.readAsStringSync(),
              contains(
                  'Using nullSafety: true.  {languageVersion: 2.12, source: packageConfig, package: over_react__test__null_safe}'));
        });

        test('but has a non-null safe language version comment', () {
          final expectedGeneratedFile = File(
              'test_fixtures/test_packages/non_null_safe/.dart_tool/build/generated/over_react__test__null_safe/lib/test_language_version_comment.over_react.g.dart');
          expect(expectedGeneratedFile.existsSync(), isTrue,
              reason:
              'File should have been generated: ${expectedGeneratedFile.path}');
          expect(
              expectedGeneratedFile.readAsStringSync(),
              contains(
                  'Using nullSafety: false. {languageVersion: 2.11, source: libraryVersionComment}'));
        });
      });
    }, tags: 'dart-2-only');

    group('on package-level Dart language version that is null safe', () {
      setUpAll(() {
        const nonNullSafePackagePath = 'test_fixtures/test_packages/null_safe';
        Process.runSync('dart', ['pub', 'get'],
            workingDirectory: nonNullSafePackagePath);
        final build = Process.runSync(
            'dart', ['pub', 'run', 'build_runner', 'build'],
            workingDirectory: nonNullSafePackagePath);

        expect(build.exitCode, 0,
            reason: 'build should have succeeded.'
                '\nstdout: ${build.stdout}'
                '\nstderr: ${build.stderr}');
      });

      test('', () {
        final expectedGeneratedFile = File(
            'test_fixtures/test_packages/null_safe/.dart_tool/build/generated/over_react__test__null_safe/lib/test.over_react.g.dart');
        expect(expectedGeneratedFile.existsSync(), isTrue,
            reason:
                'File should have been generated: ${expectedGeneratedFile.path}');
        expect(
            expectedGeneratedFile.readAsStringSync(),
            contains(
                'Using nullSafety: true.  {languageVersion: 2.12, source: packageConfig, package: over_react__test__null_safe}'));
      });

      test('but has a non-null safe language version comment', () {
        final expectedGeneratedFile = File(
            'test_fixtures/test_packages/null_safe/.dart_tool/build/generated/over_react__test__null_safe/lib/test_language_version_comment.over_react.g.dart');
        expect(expectedGeneratedFile.existsSync(), isTrue,
            reason:
                'File should have been generated: ${expectedGeneratedFile.path}');
        expect(
            expectedGeneratedFile.readAsStringSync(),
            contains(
                'Using nullSafety: false. {languageVersion: 2.11, source: libraryVersionComment}'));
      });
    });
  });
}
