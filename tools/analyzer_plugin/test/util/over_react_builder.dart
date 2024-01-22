import 'dart:convert';

import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:logging/logging.dart';
import 'package:over_react/builder.dart';
import 'package:path/path.dart' as p;

/// Returns source for an `over_react.g.dart` part, generated in-memory by the over_react builder,
/// for a library with contents [librarySource] and path [libraryPath] .
///
/// [libraryPath] is only needed so the `part of` directive can point back to the right file, and
/// does not need to actually exist in the filesystem.
///
/// Throws if the builder emits any severe logs when [throwOnSevereLogs] is true (by default), since
/// severe errors likely mean something unexpected went wrong (e.g., Dart parse errors. bad boilerplate).
Future<String> generateOverReactPart({
  required String librarySource,
  required String libraryPath,
  bool throwOnSevereLogs = true,
}) async {
  const packageName = 'fake_package';
  final inputAsset = AssetId(packageName, libraryPath);
  final expectedOutputAssetId = AssetId(packageName, p.setExtension(libraryPath, '.over_react.g.dart'));

  final reader = InMemoryAssetReader(sourceAssets: <AssetId, String>{
    inputAsset: librarySource,
  });
  final writer = InMemoryAssetWriter();

  final builderLogger = Logger.detached('builderLogger');
  final recordedLogs = <LogRecord>[];
  final logSubscription = builderLogger.onRecord.listen(recordedLogs.add);

  await runBuilder(overReactBuilder(null), [inputAsset], reader, writer, null, logger: builderLogger);

  await logSubscription.cancel();

  String loggerOutputString() => '\nLogger output:\n${recordedLogs.join('\n')}';

  if (throwOnSevereLogs && recordedLogs.any((l) => l.level == Level.SEVERE)) {
    throw Exception('Build contained severe error logs, and throwOnSevereErrors is true.${loggerOutputString()}');
  }

  final output = writer.assets[expectedOutputAssetId];
  if (output == null || writer.assets.length != 1) {
    throw Exception('Expected a single output of $expectedOutputAssetId, but actual outputs were: ${writer.assets}.'
        '${loggerOutputString()}');
  }
  return utf8.decode(output);
}
