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
index 48c96b62..749db6e9 100644
--- a/test/vm_tests/builder/over_react_builder_test.dart
+++ b/test/vm_tests/builder/over_react_builder_test.dart
@@ -41,17 +41,17 @@ main() {
     //     build_test 3.x.

     late AssetReader reader;
-    late InMemoryAssetWriter writer; // [1]
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
+      writer = TestReaderWriter(); // [1]
       writerSpy = AssetWriterSpy(writer);

       logs = [];
EndOfMessage
fi
