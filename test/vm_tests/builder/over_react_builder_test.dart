@TestOn('vm')
import 'dart:io';

import 'package:build/build.dart';
import 'package:build_resolvers/build_resolvers.dart';
import 'package:build_test/build_test.dart';
import 'package:logging/logging.dart';
import 'package:over_react/src/builder/builder.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

typedef void LogRecordFunction(LogRecord record);

main() {
  group('overReactBuilder', () {
    final builder = overReactBuilder(null);

    AssetReader reader;
    InMemoryAssetWriter writer;
    AssetWriterSpy writerSpy;
    List<String> logMsgs = <String>[];
    List<Level> logLevels = <Level>[];
    setUp(() async {
      reader = await PackageAssetReader.currentIsolate(
        rootPackage: 'over_react',
      );

      writer = new InMemoryAssetWriter();
      writerSpy = AssetWriterSpy(writer);
    });

    tearDown(() {
      logMsgs.clear();
      reader = null;
      writer = null;
      writerSpy = null;
    });

    void verifyNoErrorLogs() {
      expect(logLevels, isNot(contains(Level.SEVERE)));
      expect(logLevels, isNot(contains(Level.WARNING)));
    }

    void recordLogs(LogRecord record) {
      logMsgs.add(record.message);
      logLevels.add(record.level);
    }

    void checkBuildForFile(String assetPath, String expectedOutputAssetPath,
        String pathToGoldFile) async {
      final inputAsset = makeAssetId(assetPath);
      final expectedContent = new File(pathToGoldFile).readAsStringSync();

      final expected = {
        expectedOutputAssetPath : expectedContent
      };

      final logger = Logger('overReactBuilderTestLogger');
      final sub = logger.onRecord.listen(recordLogs);
      await runBuilder(builder, [inputAsset], reader, writerSpy, AnalyzerResolvers(), logger: logger);
      final actual = writerSpy.assetsWritten;
      sub.cancel();

      checkOutputs(expected, actual, writer);
      verifyNoErrorLogs();
    }

    test('does not produce a build output for a file with no over_react annotations', () async {
      var basicAsset = makeAssetId('over_react|test_fixtures/source_files/no_annotations.dart');
      await runBuilder(builder, [basicAsset], reader, writerSpy, AnalyzerResolvers());

      expect(writerSpy.assetsWritten, isEmpty);
      verifyNoErrorLogs();
    });

    test('does not produce a build output for just a part file', () async {
      var basicAsset = makeAssetId('over_react|test_fixtures/source_files/part_of_basic_library.dart');
      await runBuilder(builder, [basicAsset], reader, writerSpy, AnalyzerResolvers());

      expect(writerSpy.assetsWritten, isEmpty);
      verifyNoErrorLogs();
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
