// @dart=2.7
// ^ Do not remove until migrated to null safety. More info at https://wiki.atl.workiva.net/pages/viewpage.action?pageId=189370832
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
import 'dart:async';
import 'dart:io';

import 'package:build/build.dart';
import 'package:build_resolvers/build_resolvers.dart';
import 'package:build_test/build_test.dart';
import 'package:logging/logging.dart';
import 'package:over_react/src/builder/builder.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

main() {
  group('overReactBuilder', () {
    final builder = overReactBuilder(null);
    final logger = Logger('overReactBuilderTestLogger');

    AssetReader reader;
    InMemoryAssetWriter writer;
    AssetWriterSpy writerSpy;
    StreamSubscription logSub;
    List<LogRecord> logs = <LogRecord>[];

    setUp(() async {
      reader = await PackageAssetReader.currentIsolate(
        rootPackage: 'over_react',
      );

      writer = InMemoryAssetWriter();
      writerSpy = AssetWriterSpy(writer);

      logSub = logger.onRecord.listen(logs.add);
    });

    tearDown(() async {
      await logSub?.cancel();
      logs.clear();
      reader = null;
      writer = null;
      writerSpy = null;
    });

    void verifyNoErrorLogs() {
      expect(logs.where((log) => log.level >= Level.WARNING), isEmpty,
        reason: 'Expected no logs at WARNING or SEVERE level, but got:\n'
          '\t${logs.join('\n\t')}');
    }

    Future<Null> checkBuildForFile(String assetPath, String expectedOutputAssetPath,
        String pathToGoldFile) async {
      final inputAsset = makeAssetId(assetPath);
      final expectedContent = File(pathToGoldFile).readAsStringSync();

      final expected = {
        expectedOutputAssetPath : expectedContent
      };

      await runBuilder(builder, [inputAsset], reader, writerSpy, AnalyzerResolvers(), logger: logger);
      final actual = writerSpy.assetsWritten;

      checkOutputs(expected, actual, writer);
      verifyNoErrorLogs();
    }

    test('does not produce a build output for a file with no over_react annotations', () async {
      var basicAsset = makeAssetId('over_react|test_fixtures/source_files/no_annotations.dart');
      await runBuilder(builder, [basicAsset], reader, writerSpy, AnalyzerResolvers(), logger: logger);

      expect(writerSpy.assetsWritten, isEmpty);
      verifyNoErrorLogs();
    });

    test('warns if .over_react.g.dart part directive is present and no declarations are present, but no code is generated', () async {
      var libraryAsset = makeAssetId('over_react|test_fixtures/source_files/has_part_directive_missing_gen/no_declarations.dart');
      await runBuilder(builder, [libraryAsset], reader, writerSpy, AnalyzerResolvers(), logger: logger);
      final expectedWarning = logs.firstWhere((log) {
        return log.level == Level.WARNING && log.message == 'An over_react part directive was found in test_fixtures/source_files/has_part_directive_missing_gen/no_declarations.dart, but no code was generated. The part directive may be unnecessary if the file does not contain any concrete components or abstract state/props classes.';
      }, orElse: () => null);
      expect(expectedWarning, isNotNull,
        reason: 'Expected a WARNING log for a part directive being present in a file with no generated output.');
    });

    test('warns if .over_react.g.dart part directive is present and declarations are present, but no code is generated', () async {
      var libraryAsset = makeAssetId('over_react|test_fixtures/source_files/has_part_directive_missing_gen/with_declarations.dart');
      await runBuilder(builder, [libraryAsset], reader, writerSpy, AnalyzerResolvers(), logger: logger);
      final expectedWarning = logs.firstWhere((log) {
        return log.level == Level.WARNING && log.message == 'An over_react part directive was found in test_fixtures/source_files/has_part_directive_missing_gen/with_declarations.dart, but no code was generated. The part directive may be unnecessary if the file does not contain any concrete components or abstract state/props classes.';
      }, orElse: () => null);
      expect(expectedWarning, isNotNull,
        reason: 'Expected a WARNING log for a part directive being present in a file with no generated output.');
    });

    group('for backwards compatible boilerplate:', () {
      test('builds from basic component file', () async {
        await checkBuildForFile(
            'over_react|test_fixtures/source_files/backwards_compatible/basic.dart',
            'over_react|test_fixtures/source_files/backwards_compatible/basic.over_react.g.dart',
            '${p.absolute(p.current)}/test_fixtures/gold_output_files/backwards_compatible/basic.over_react.g.dart.goldFile');
      });

      test('builds from basic multi-part library', () async {
        await checkBuildForFile(
            'over_react|test_fixtures/source_files/backwards_compatible/basic_library.dart',
            'over_react|test_fixtures/source_files/backwards_compatible/basic_library.over_react.g.dart',
            '${p.absolute(p.current)}/test_fixtures/gold_output_files/backwards_compatible/basic_library.over_react.g.dart.goldFile');
      });
    });

    group('for Dart 2 only compatible boilerplate:', () {
      test('builds from basic component file', () async {
        await checkBuildForFile(
            'over_react|test_fixtures/source_files/dart2_only/basic.dart',
            'over_react|test_fixtures/source_files/dart2_only/basic.over_react.g.dart',
            '${p.absolute(p.current)}/test_fixtures/gold_output_files/basic.over_react.g.dart.goldFile');
      });

      test('builds from basic multi-part library', () async {
        await checkBuildForFile(
            'over_react|test_fixtures/source_files/dart2_only/basic_library.dart',
            'over_react|test_fixtures/source_files/dart2_only/basic_library.over_react.g.dart',
            '${p.absolute(p.current)}/test_fixtures/gold_output_files/basic_library.over_react.g.dart.goldFile');
      });

      test('builds for props mixins', () async {
        await checkBuildForFile(
            'over_react|test_fixtures/source_files/dart2_only/props_mixin.dart',
            'over_react|test_fixtures/source_files/dart2_only/props_mixin.over_react.g.dart',
            '${p.absolute(p.current)}/test_fixtures/gold_output_files/props_mixin.over_react.g.dart.goldFile');
      });

      test('builds for state mixins', () async {
        await checkBuildForFile(
            'over_react|test_fixtures/source_files/dart2_only/state_mixin.dart',
            'over_react|test_fixtures/source_files/dart2_only/state_mixin.over_react.g.dart',
            '${p.absolute(p.current)}/test_fixtures/gold_output_files/state_mixin.over_react.g.dart.goldFile');
      });

      test('does not produce a build output for just a part file', () async {
        var basicAsset = makeAssetId('over_react|test_fixtures/source_files/dart2_only/part_of_basic_library.dart');
        await runBuilder(builder, [basicAsset], reader, writerSpy, AnalyzerResolvers(), logger: logger);

        expect(writerSpy.assetsWritten, isEmpty);
        verifyNoErrorLogs();
      });

      test('fails if the .over_react.g.dart part directive is missing', () async {
        var libraryAsset = makeAssetId('over_react|test_fixtures/source_files/dart2_only/missing_over_react_g_part/library.dart');
        await runBuilder(builder, [libraryAsset], reader, writerSpy, AnalyzerResolvers(), logger: logger);
        final expectedLog = logs.firstWhere((log) {
          return log.level == Level.SEVERE && log.message == 'Missing "part \'library.over_react.g.dart\';".';
        }, orElse: () => null);
        expect(expectedLog, isNotNull,
            reason: 'Expected a SEVERE log for the missing over_react part.');
      });


      group('for Component2:', () {
        test('builds from basic component file', () async {
          await checkBuildForFile(
              'over_react|test_fixtures/source_files/dart2_only/component2/basic.dart',
              'over_react|test_fixtures/source_files/dart2_only/component2/basic.over_react.g.dart',
              '${p.absolute(p.current)}/test_fixtures/gold_output_files/component2/basic.over_react.g.dart.goldFile');
        });

        test('builds from basic multi-part library', () async {
          await checkBuildForFile(
              'over_react|test_fixtures/source_files/dart2_only/component2/basic_library.dart',
              'over_react|test_fixtures/source_files/dart2_only/component2/basic_library.over_react.g.dart',
              '${p.absolute(p.current)}/test_fixtures/gold_output_files/component2/basic_library.over_react.g.dart.goldFile');
        });
      });
    });

    group('for mixin based boilerplate:', () {
      test('builds from basic component file', () async {
        await checkBuildForFile(
            'over_react|test_fixtures/source_files/mixin_based/basic.dart',
            'over_react|test_fixtures/source_files/mixin_based/basic.over_react.g.dart',
            '${p.absolute(p.current)}/test_fixtures/gold_output_files/mixin_based/basic.over_react.g.dart.goldFile');
      });

      test('builds from basic component file using Dart >=2.9.0 syntax', () async {
        await checkBuildForFile(
            'over_react|test_fixtures/source_files/mixin_based/basic_two_nine.dart',
            'over_react|test_fixtures/source_files/mixin_based/basic_two_nine.over_react.g.dart',
            '${p.absolute(p.current)}/test_fixtures/gold_output_files/mixin_based/basic_two_nine.over_react.g.dart.goldFile');
      });

      test('builds from basic multi-part library', () async {
        await checkBuildForFile(
            'over_react|test_fixtures/source_files/mixin_based/basic_library.dart',
            'over_react|test_fixtures/source_files/mixin_based/basic_library.over_react.g.dart',
            '${p.absolute(p.current)}/test_fixtures/gold_output_files/mixin_based/basic_library.over_react.g.dart.goldFile');
      });

      test('builds when props mixins and classes have type parameters', () async {
        await checkBuildForFile(
            'over_react|test_fixtures/source_files/mixin_based/type_parameters.dart',
            'over_react|test_fixtures/source_files/mixin_based/type_parameters.over_react.g.dart',
            '${p.absolute(p.current)}/test_fixtures/gold_output_files/mixin_based/type_parameters.over_react.g.dart.goldFile');
      });

      test('builds for props mixins', () async {
        await checkBuildForFile(
            'over_react|test_fixtures/source_files/mixin_based/props_mixin.dart',
            'over_react|test_fixtures/source_files/mixin_based/props_mixin.over_react.g.dart',
            '${p.absolute(p.current)}/test_fixtures/gold_output_files/mixin_based/props_mixin.over_react.g.dart.goldFile');
      });

      test('builds for state mixins', () async {
        await checkBuildForFile(
            'over_react|test_fixtures/source_files/mixin_based/state_mixin.dart',
            'over_react|test_fixtures/source_files/mixin_based/state_mixin.over_react.g.dart',
            '${p.absolute(p.current)}/test_fixtures/gold_output_files/mixin_based/state_mixin.over_react.g.dart.goldFile');
      });

      test('does not produce a build output for just a part file', () async {
        var basicAsset = makeAssetId('over_react|test_fixtures/source_files/mixin_based/part_of_basic_library.dart');
        await runBuilder(builder, [basicAsset], reader, writerSpy, AnalyzerResolvers(), logger: logger);

        expect(writerSpy.assetsWritten, isEmpty);
        verifyNoErrorLogs();
      });

      test('fails if the .over_react.g.dart part directive is missing', () async {
        var libraryAsset = makeAssetId('over_react|test_fixtures/source_files/mixin_based/missing_over_react_g_part/library.dart');
        await runBuilder(builder, [libraryAsset], reader, writerSpy, AnalyzerResolvers(), logger: logger);
        final expectedLog = logs.firstWhere((log) {
          return log.level == Level.SEVERE && log.message == 'Missing "part \'library.over_react.g.dart\';".';
        }, orElse: () => null);
        expect(expectedLog, isNotNull,
            reason: 'Expected a SEVERE log for the missing over_react part.');
      });
    });
  });
}
