import 'dart:io';

import 'package:build_resolvers/build_resolvers.dart';
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';
import 'package:build/build.dart';

import 'package:path/path.dart' as p;

import 'package:over_react/src/builder/builder.dart';

main() {
  group('OverReactBuilder', () {
    final builder = new OverReactBuilder();

    AssetReader reader;
    final InMemoryAssetWriter writer = new InMemoryAssetWriter();
    final AssetWriterSpy writerSpy = AssetWriterSpy(writer);

    setUp(() async {
      reader = await PackageAssetReader.currentIsolate(
        rootPackage: 'over_react',
      );
    });

    void checkBuildForFile(String assetPath, String expectedOutputAssetPath, String expectedContentFileLocation) async {
      var basicAsset = makeAssetId(assetPath);
      var expectedContent = new File(expectedContentFileLocation).readAsStringSync();
      var outputs = {
        expectedOutputAssetPath : expectedContent
      };

      await runBuilder(builder, [basicAsset], reader, writerSpy, AnalyzerResolvers());
      var actualOutputs = writerSpy.assetsWritten;
      checkOutputs(outputs, actualOutputs, writer);
    }

    test('builds basic component file', () async {
      checkBuildForFile('over_react|test/component_files/basic.dart', 'over_react|test/component_files/basic.overReactBuilder.g.dart', '${p.absolute(p.current)}/test/gold_files/basic.overReactBuilder.g.dart');
    });

    test('builds generic_inheritance_sub component file', () async {
      checkBuildForFile('over_react|test/component_files/abstract_inheritance.dart', 'over_react|test/component_files/abstract_inheritance.overReactBuilder.g.dart', '${p.absolute(p.current)}/test/gold_files/abstract_inheritance.overReactBuilder.g.dart');
    });

    test('builds generic_inheritance_sub component file', () async {
      checkBuildForFile('over_react|test/component_files/generic_inheritance_sub.dart', 'over_react|test/component_files/generic_inheritance_sub.overReactBuilder.g.dart', '${p.absolute(p.current)}/test/gold_files/generic_inheritance_sub.overReactBuilder.g.dart');
    });

    test('builds generic_inheritance_super component file', () async {
      checkBuildForFile('over_react|test/component_files/generic_inheritance_super.dart', 'over_react|test/component_files/generic_inheritance_super.overReactBuilder.g.dart', '${p.absolute(p.current)}/test/gold_files/generic_inheritance_super.overReactBuilder.g.dart');
    });

    test('builds over_react component files', () async {
      checkBuildForFile('over_react|lib/src/component/prop_mixins.dart', 'over_react|test/component_files/generic_inheritance_super.overReactBuilder.g.dart', '${p.absolute(p.current)}/test/gold_files/generic_inheritance_super.overReactBuilder.g.dart');
    });
  });
}
