//@TestOn('vm')
import 'dart:io';

import 'package:build_resolvers/build_resolvers.dart';
import 'package:build_test/build_test.dart';
import 'package:logging/logging.dart';
import 'package:package_resolver/package_resolver.dart';
import 'package:test/test.dart';
import 'package:build/build.dart'; // TODO: Maybe use runBuilder?
import 'package:build_runner_core/build_runner_core.dart';

import 'package:path/path.dart' as p;

import 'package:over_react/src/builder/builder.dart';

final PackageGraph packageGraph = PackageGraph.forPath(p.absolute(p.current));

main() {
  group('OverReactBuilder', () {
    final builder = new OverReactBuilder();

    void onLog(LogRecord log) {
      print(log.message);
    }

    AssetReader reader;
//    SyncPackageResolver resolver;
    InMemoryAssetWriter writer;
    AssetWriterSpy writerSpy;
    setUp(() async {
//      resolver = await SyncPackageResolver.loadConfig(p.toUri(p.join(p.current, '.packages')));
      reader = await PackageAssetReader.currentIsolate(rootPackage: 'over_react');
//      var packageGraph = new PackageGraph.forPath(p.absolute(p.current));
//      print(packageGraph.allPackages.toString());
//      reader = MultiAssetReader(
//          [new PackageAssetReader(resolver),
//          new FileBasedAssetReader(packageGraph),
//          ]);

      writer = new InMemoryAssetWriter();
      writerSpy = AssetWriterSpy(writer);
    });

    test('builds basic file', () async {
//      var basicAsset = makeAssetId('over_react|lib/src/example_files/basic.dart');
      var basicAsset = makeAssetId('over_react|test/component_files/basic.dart');
//      print(await reader.readAsString(basicAsset));

//      print(resolver.packageConfigMap);
//      print(await reader.readAsString(basicAsset));

//      var sourceAssets = {
//        'some_pkg|lib/basic.dart' : basic_component_file_contents
//      };

      var expectedContent = new File('${p.absolute(p.current)}/test/gold_files/basic.overReactBuilder.g.dart').readAsStringSync();
      var outputs = {
        'over_react|test/component_files/basic.overReactBuilder.g.dart': expectedContent
      };

      var logger = Logger('testBuilder');
      var logSubscription = logger.onRecord.listen(onLog);
      await runBuilder(builder, [basicAsset], reader, writerSpy, AnalyzerResolvers(), logger: logger);
      await logSubscription.cancel();

      var actualOutputs = writerSpy.assetsWritten;
      checkOutputs(outputs, actualOutputs, writer);
    });
  });
}


//
//void main() {
//  group('FileBasedAssetReader', () {
//    final reader = FileBasedAssetReader(packageGraph);
//
//    test('can read any application package files', () async {
//      print(await reader.readAsString(makeAssetId('over_react|test/over_react_builder_test.dart')));
//    });
//  });
//}
