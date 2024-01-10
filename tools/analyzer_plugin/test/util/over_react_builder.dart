import 'dart:convert';

import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:logging/logging.dart';
import 'package:over_react/builder.dart';
import 'package:path/path.dart' as p;

/// Uses the over_react builder to generate a part for a library with path [libraryPath] and contents [librarySource].
Future<String> generateOverReactPart({required String librarySource, required String libraryPath}) async {
  const packageName = 'fake_package';
  final inputAsset = AssetId(packageName, libraryPath);
  final expectedOutputAssetId = AssetId(packageName, p.setExtension(libraryPath, '.over_react.g.dart'));

  final reader = InMemoryAssetReader(sourceAssets: <AssetId, String>{
    inputAsset: librarySource,
  });
  final writer = InMemoryAssetWriter();
  final noopLogger = Logger.detached('');

  await runBuilder(overReactBuilder(null), [inputAsset], reader, writer, null, logger: noopLogger);

  final output = writer.assets[expectedOutputAssetId];
  if (output == null || writer.assets.length != 1) {
    throw Exception('Expected a single output of $expectedOutputAssetId, but actual outputs were: ${writer.assets}');
  }
  return utf8.decode(output);
}
