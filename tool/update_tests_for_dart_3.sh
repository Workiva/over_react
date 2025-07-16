#!/usr/bin/env bash

#
# This script makes updates to tests to make them compatible with Dart 3.
# This is a last-resort workaround for cases that can't analyze cleanly in both versions.
#

set -e
set -x

# Update over_react_builder_test.dart by applying a patch in build_test 3 (Dart 3 only);
# see comment in test file for more details on the changes.
build_test_version=$(yq '.packages.build_test.version' pubspec.lock)
if [[ "$build_test_version" == "3."* ]]; then
  # This patch is derived from fixing tests in build_test 3 and getting the diff with:
  #    git diff test/vm_tests/builder/over_react_builder_test.dart > tool/update_tests_for_dart_3/build_test_3_updates.patch
  git apply tool/update_tests_for_dart_3/build_test_3_updates.patch
fi
