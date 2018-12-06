import 'dart:io';

import 'package:build_resolvers/build_resolvers.dart';
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';
import 'package:build/build.dart';
import 'package:logging/logging.dart';

import 'package:path/path.dart' as p;

import 'package:over_react/src/builder/builder.dart';

main() {
  group('OverReactBuilder', () {
    final builder = new OverReactBuilder();

    AssetReader reader;
    InMemoryAssetWriter writer;
    AssetWriterSpy writerSpy;
    setUp(() async {
      reader = await PackageAssetReader.currentIsolate(
        rootPackage: 'over_react',
      );

      writer = new InMemoryAssetWriter();
      writerSpy = AssetWriterSpy(writer);
    });

    tearDown(() {
      reader = null;
      writer = null;
      writerSpy = null;
    });

    void onLog(LogRecord log) {
      // uncomment to print debug logs from the builder
//      print(log.message);
    }

    void checkBuildForFile(String assetPath, String expectedOutputAssetPath,
        String expectedContentFileLocation) async {
      var basicAsset = makeAssetId(assetPath);
      var expectedContent = new File(expectedContentFileLocation).readAsStringSync();
      var outputs = {
        expectedOutputAssetPath : expectedContent
      };

      var logger = Logger('overReactLogger');
      var logSubscription = logger.onRecord.listen(onLog);
      await runBuilder(builder, [basicAsset], reader, writerSpy, AnalyzerResolvers(), logger: logger);
      var actualOutputs = writerSpy.assetsWritten;
      checkOutputs(outputs, actualOutputs, writer);
      await logSubscription.cancel();
    }

    test('builds from basic component file with props mixin', () async {
      await checkBuildForFile('over_react|test/builder/component_files/basic.dart', 'over_react|test/builder/component_files/basic.over_react.g.dart', '${p.absolute(p.current)}/test/builder/gold_output_files/basic.g.dart');
    });

    test('builds from abstract_inheritance component file', () async {
      await checkBuildForFile('over_react|test/builder/component_files/abstract_inheritance.dart', 'over_react|test/builder/component_files/abstract_inheritance.over_react.g.dart', '${p.absolute(p.current)}/test/builder/gold_output_files/abstract_inheritance.g.dart');
    });

    test('builds from generic_inheritance_sub component file', () async {
      await checkBuildForFile('over_react|test/builder/component_files/generic_inheritance_sub.dart', 'over_react|test/builder/component_files/generic_inheritance_sub.over_react.g.dart', '${p.absolute(p.current)}/test/builder/gold_output_files/generic_inheritance_sub.g.dart');
    });

    test('builds from generic_inheritance_super component file', () async {
      await checkBuildForFile('over_react|test/builder/component_files/generic_inheritance_super.dart', 'over_react|test/builder/component_files/generic_inheritance_super.over_react.g.dart', '${p.absolute(p.current)}/test/builder/gold_output_files/generic_inheritance_super.g.dart');
    });

    test('builds from basic library files', () async {
      await checkBuildForFile('over_react|test/builder/component_files/basic_library.dart', 'over_react|test/builder/component_files/basic_library.over_react.g.dart', '${p.absolute(p.current)}/test/builder/gold_output_files/basic_library.g.dart');
    });

    test('builds from prop_mixin file', () async {
      await checkBuildForFile('over_react|test/builder/component_files/props_mixin.dart', 'over_react|test/builder/component_files/props_mixin.over_react.g.dart', '${p.absolute(p.current)}/test/builder/gold_output_files/props_mixin.g.dart');
    });

    test('builds from basic_with_state file', () async {
      await checkBuildForFile('over_react|test/builder/component_files/basic_with_state.dart', 'over_react|test/builder/component_files/basic_with_state.over_react.g.dart', '${p.absolute(p.current)}/test/builder/gold_output_files/basic_with_state.g.dart');
    });

    test('builds from state_mixin file', () async {
      await checkBuildForFile('over_react|test/builder/component_files/state_mixin.dart', 'over_react|test/builder/component_files/state_mixin.over_react.g.dart', '${p.absolute(p.current)}/test/builder/gold_output_files/state_mixin.g.dart');
    });

    test('does not have a build output for a file with no over_react annotations', () async {
      var basicAsset = makeAssetId('over_react|test/builder/component_files/no_annoations.dart');
      await runBuilder(builder, [basicAsset], reader, writerSpy, AnalyzerResolvers());
      expect(writerSpy.assetsWritten.isEmpty, isTrue);
    });
  });
}
