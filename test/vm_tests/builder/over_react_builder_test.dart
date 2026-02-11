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

@TestOn('vm')
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';

main() {
  group('overReactBuilder', () {
    const testPackagePath = 'test_fixtures/test_packages/builder';
    late String testPackageName;

    late String outputDirectory;

    setUpAll(() {
      Process.runSync('dart', ['pub', 'get'], workingDirectory: testPackagePath);
      testPackageName =
          RegExp('name: (.+)').firstMatch(File(p.join(testPackagePath, 'pubspec.yaml')).readAsStringSync())!.group(1)!;
      outputDirectory = Directory.systemTemp.createTempSync().path;

      // Clean previous build
      Process.runSync('dart', ['run', 'build_runner', 'clean'], workingDirectory: testPackagePath);
    });

    /// Runs build_runner for a specific file, cleaning first.
    ProcessResult buildFile(String sourceFilePath) {
      // Build with filter for the specific file
      return Process.runSync(
          'dart',
          [
            'run',
            'build_runner',
            'build',
            '--verbose',
            '--build-filter=lib/${sourceFilePath.replaceAll('.dart', '*.g.dart')}',
            '--output=$outputDirectory'
          ],
          workingDirectory: testPackagePath);
    }

    String generatedOutputPath(String sourceFilePath) {
      return p.join(
        outputDirectory,
        'packages',
        testPackageName,
        sourceFilePath.replaceAll('.dart', '.over_react.g.dart'),
      );
    }

    /// Runs build_runner for a specific file and verifies the generated output matches the gold file.
    Future<void> checkBuildForFile(String sourceFilePath, String pathToGoldFile) async {
      final build = buildFile(sourceFilePath);

      expect(build.exitCode, 0,
          reason: 'build should have succeeded.'
              '\nstdout: ${build.stdout}'
              '\nstderr: ${build.stderr}');

      // Read generated file
      final expectedGeneratedFile = File(generatedOutputPath(sourceFilePath));
      expect(expectedGeneratedFile.existsSync(), isTrue,
          reason:
              'File should have been generated: ${expectedGeneratedFile.path}.\n\nBuild output:\n${build.stdout}\n${build.stderr}');

      // Compare with gold file
      final expectedContent = File(pathToGoldFile).readAsStringSync();
      final actualContent = expectedGeneratedFile.readAsStringSync();

      expect(actualContent, expectedContent, reason: 'Generated file should match gold file');
    }

    /// Runs build_runner for a specific file and verifies no output is generated.
    Future<void> checkNoOutputForFile(String sourceFilePath) async {
      final build = buildFile(sourceFilePath);

      expect(build.exitCode, 0,
          reason: 'build should have succeeded.'
              '\nstdout: ${build.stdout}'
              '\nstderr: ${build.stderr}');

      // Verify no generated file exists
      final expectedGeneratedFile = File(generatedOutputPath(sourceFilePath));
      expect(expectedGeneratedFile.existsSync(), isFalse,
          reason: 'File should not have been generated: ${expectedGeneratedFile.path}');
    }

    /// Runs build_runner for a specific file and verifies a warning appears in the output.
    Future<void> checkWarningForFile(String sourceFilePath, String expectedWarning) async {
      final build = buildFile(sourceFilePath);

      // Check for expected warning in output
      expect('${build.stdout}${build.stderr}', contains(expectedWarning),
          reason: 'Expected warning not found in build output');

      expect(build.exitCode, 0,
          reason: 'build should have succeeded.'
              '\nstdout: ${build.stdout}'
              '\nstderr: ${build.stderr}');
    }

    /// Runs build_runner for a specific file and verifies a severe error appears in the output.
    Future<void> checkSevereErrorForFile(String sourceFilePath, String expectedError) async {
      final build = buildFile(sourceFilePath);

      // Check for expected error in output
      expect('${build.stdout}${build.stderr}', contains(expectedError),
          reason: 'Expected error not found in build output');

      expect(build.exitCode, 1,
          reason: 'build should have failed.'
              '\nstdout: ${build.stdout}'
              '\nstderr: ${build.stderr}');
    }

    test('does not produce a build output for a file with no over_react annotations', () async {
      await checkNoOutputForFile('no_annotations.dart');
    });

    test(
        'warns if .over_react.g.dart part directive is present and no declarations are present, but no code is generated',
        () async {
      await checkWarningForFile('has_part_directive_missing_gen/no_declarations.dart',
          'An over_react part directive was found in lib/has_part_directive_missing_gen/no_declarations.dart, but no code was generated.');
    });

    test('warns if .over_react.g.dart part directive is present and declarations are present, but no code is generated',
        () async {
      await checkWarningForFile('has_part_directive_missing_gen/with_declarations.dart',
          'An over_react part directive was found in lib/has_part_directive_missing_gen/with_declarations.dart, but no code was generated.');
    });

    group('for backwards compatible boilerplate:', () {
      test('builds from basic component file', () async {
        await checkBuildForFile('backwards_compatible/basic.dart',
            '${p.absolute(p.current)}/test_fixtures/gold_output_files/backwards_compatible/basic.over_react.g.dart.goldFile');
      });

      test('builds from basic multi-part library', () async {
        await checkBuildForFile('backwards_compatible/basic_library.dart',
            '${p.absolute(p.current)}/test_fixtures/gold_output_files/backwards_compatible/basic_library.over_react.g.dart.goldFile');
      });

      test('builds for props mixins', () async {
        await checkBuildForFile('backwards_compatible/props_mixin.dart',
            '${p.absolute(p.current)}/test_fixtures/gold_output_files/backwards_compatible/props_mixin.over_react.g.dart.goldFile');
      });

      test('builds for state mixins', () async {
        await checkBuildForFile('backwards_compatible/state_mixin.dart',
            '${p.absolute(p.current)}/test_fixtures/gold_output_files/backwards_compatible/state_mixin.over_react.g.dart.goldFile');
      });

      test('does not produce a build output for just a part file', () async {
        await checkNoOutputForFile('backwards_compatible/part_of_basic_library.dart');
      });
    });

    group('for Dart 2 only compatible boilerplate:', () {
      test('builds from basic component file', () async {
        await checkBuildForFile('dart2_only/basic.dart',
            '${p.absolute(p.current)}/test_fixtures/gold_output_files/dart2_only/basic.over_react.g.dart.goldFile');
      });

      test('builds from basic multi-part library', () async {
        await checkBuildForFile('dart2_only/basic_library.dart',
            '${p.absolute(p.current)}/test_fixtures/gold_output_files/dart2_only/basic_library.over_react.g.dart.goldFile');
      });

      test('builds for props mixins', () async {
        await checkBuildForFile('dart2_only/props_mixin.dart',
            '${p.absolute(p.current)}/test_fixtures/gold_output_files/dart2_only/props_mixin.over_react.g.dart.goldFile');
      });

      test('builds for state mixins', () async {
        await checkBuildForFile('dart2_only/state_mixin.dart',
            '${p.absolute(p.current)}/test_fixtures/gold_output_files/dart2_only/state_mixin.over_react.g.dart.goldFile');
      });

      test('does not produce a build output for just a part file', () async {
        await checkNoOutputForFile('dart2_only/part_of_basic_library.dart');
      });

      test('fails if the .over_react.g.dart part directive is missing', () async {
        await checkSevereErrorForFile(
            'dart2_only/missing_over_react_g_part/library.dart', 'Missing "part \'library.over_react.g.dart\';".');
      });

      group('for Component2:', () {
        test('builds from basic component file', () async {
          await checkBuildForFile('dart2_only/component2/basic.dart',
              '${p.absolute(p.current)}/test_fixtures/gold_output_files/dart2_only/component2/basic.over_react.g.dart.goldFile');
        });

        test('builds from basic multi-part library', () async {
          await checkBuildForFile('dart2_only/component2/basic_library.dart',
              '${p.absolute(p.current)}/test_fixtures/gold_output_files/dart2_only/component2/basic_library.over_react.g.dart.goldFile');
        });
      });
    });

    group('for mixin based boilerplate:', () {
      test('builds from basic component file', () async {
        await checkBuildForFile('mixin_based/basic.dart',
            '${p.absolute(p.current)}/test_fixtures/gold_output_files/mixin_based/basic.over_react.g.dart.goldFile');
      });

      test('builds from basic component file using Dart >=2.9.0 syntax', () async {
        await checkBuildForFile('mixin_based/basic_two_nine.dart',
            '${p.absolute(p.current)}/test_fixtures/gold_output_files/mixin_based/basic_two_nine.over_react.g.dart.goldFile');
      });

      test('builds from basic multi-part library', () async {
        await checkBuildForFile('mixin_based/basic_library.dart',
            '${p.absolute(p.current)}/test_fixtures/gold_output_files/mixin_based/basic_library.over_react.g.dart.goldFile');
      });

      test('builds when props mixins and classes have type parameters', () async {
        await checkBuildForFile('mixin_based/type_parameters.dart',
            '${p.absolute(p.current)}/test_fixtures/gold_output_files/mixin_based/type_parameters.over_react.g.dart.goldFile');
      });

      test('builds for props mixins', () async {
        await checkBuildForFile('mixin_based/props_mixin.dart',
            '${p.absolute(p.current)}/test_fixtures/gold_output_files/mixin_based/props_mixin.over_react.g.dart.goldFile');
      });

      test('builds for state mixins', () async {
        await checkBuildForFile('mixin_based/state_mixin.dart',
            '${p.absolute(p.current)}/test_fixtures/gold_output_files/mixin_based/state_mixin.over_react.g.dart.goldFile');
      });

      test('does not produce a build output for just a part file', () async {
        await checkNoOutputForFile('mixin_based/part_of_basic_library.dart');
      });

      test('fails if the .over_react.g.dart part directive is missing', () async {
        await checkSevereErrorForFile(
            'mixin_based/missing_over_react_g_part/library.dart', 'Missing "part \'library.over_react.g.dart\';".');
      });
    });
  });
}
