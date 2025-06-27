#!/usr/bin/env bash

#
# This script makes updates to tests to make them compatible with Dart 3.
# This is a last-resort workaround for cases that can't analyze cleanly in both versions.
#

set -e

# Update over_react_builder_test.dart by applying a patch in build_test_version v3 (Dart 3 only);
# see comment in test file for more details on the changes.
build_test_version=$(yq '.packages.build_test.version' pubspec.lock)
if [[ "$build_test_version" == "3."* ]]; then
  # This patch is derived from fixing tests  and getting the diff with:
  #    git diff test/vm_tests/builder/over_react_builder_test.dart | pbcopy
  git apply << EndOfMessage
diff --git a/test/vm_tests/builder/over_react_builder_test.dart b/test/vm_tests/builder/over_react_builder_test.dart
index 48c96b62..b9b60b55 100644
--- a/test/vm_tests/builder/over_react_builder_test.dart
+++ b/test/vm_tests/builder/over_react_builder_test.dart
@@ -20,6 +20,8 @@ import 'package:build/build.dart';
 import 'package:build_resolvers/build_resolvers.dart';
 import 'package:build_test/build_test.dart';
 import 'package:collection/collection.dart' show IterableExtension;
+import 'package:glob/glob.dart';
+import 'package:glob/list_local_fs.dart';
 import 'package:logging/logging.dart';
 import 'package:over_react/src/builder/builder.dart';
 import 'package:path/path.dart' as p;
@@ -40,18 +42,27 @@ main() {
     //     test 2.x and 3.x at the same time, and Dart 2 not being compatible with
     //     build_test 3.x.

-    late AssetReader reader;
-    late InMemoryAssetWriter writer; // [1]
+    late TestReaderWriter reader;
+    late TestReaderWriter writer; // [1]
     late AssetWriterSpy writerSpy;
     late List<LogRecord> logs;

     setUp(() async {
       // [1]
-      reader = await PackageAssetReader.currentIsolate(
+      reader = TestReaderWriter(
         rootPackage: 'over_react',
       );

-      writer = InMemoryAssetWriter(); // [1]
+      // Load test fixture assets from the filesystem into the test reader.
+      for (final file in Glob('test_fixtures/**').listSync().whereType<File>()) {
+        // Write via `testing` so it's not tracked as a builder output.
+        reader.testing.writeBytes(
+          makeAssetId('over_react|${file.path}'),
+          file.readAsBytesSync(),
+        );
+      }
+
+      writer = TestReaderWriter(); // [1]
       writerSpy = AssetWriterSpy(writer);

       logs = [];
EndOfMessage
fi
