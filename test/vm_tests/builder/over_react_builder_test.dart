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

    test('does not produce a build output for just a part file', () async {
      var basicAsset = makeAssetId('over_react|test_fixtures/source_files/part_of_basic_library.dart');
      await runBuilder(builder, [basicAsset], reader, writerSpy, AnalyzerResolvers(), logger: logger);

      expect(writerSpy.assetsWritten, isEmpty);
      verifyNoErrorLogs();
    });

    test('fails if the .over_react.g.dart part directive is missing', () async {
      var libraryAsset = makeAssetId('over_react|test_fixtures/source_files/missing_over_react_g_part/library.dart');
      await runBuilder(builder, [libraryAsset], reader, writerSpy, AnalyzerResolvers(), logger: logger);
      final expectedLog = logs.firstWhere((log) {
        return log.level == Level.SEVERE && log.message == 'Missing "part \'library.over_react.g.dart\';".';
      }, orElse: () => null);
      expect(expectedLog, isNotNull,
        reason: 'Expected a SEVERE log for the missing over_react part.');
    });

    test('warns if .over_react.g.dart part directive is present and no declarations are present, but no code is generated', () async {
      var libraryAsset = makeAssetId('over_react|test_fixtures/source_files/has_part_directive_missing_gen/no_declarations.dart');
      await runBuilder(builder, [libraryAsset], reader, writerSpy, AnalyzerResolvers(), logger: logger);
      final expectedWarning = logs.firstWhere((log) {
        print('log.message: ${log.message}');
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
            'over_react|test_fixtures/source_files/basic.dart',
            'over_react|test_fixtures/source_files/basic.over_react.g.dart',
            '${p.absolute(p.current)}/test_fixtures/gold_output_files/basic.over_react.g.dart.goldFile');
      });

      test('builds from basic multi-part library', () async {
        await checkBuildForFile(
            'over_react|test_fixtures/source_files/basic_library.dart',
            'over_react|test_fixtures/source_files/basic_library.over_react.g.dart',
            '${p.absolute(p.current)}/test_fixtures/gold_output_files/basic_library.over_react.g.dart.goldFile');
      });
    });
  });
}
