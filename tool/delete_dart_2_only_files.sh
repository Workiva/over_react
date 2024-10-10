#!/usr/bin/env bash

#
# This script deletes files that can only be run in Dart 2 (ones not using null-safety),
# and need to be deleted for analysis and compilation to work in Dart 3.
#

set -e

rm -rf test/over_react/component_declaration/non_null_safe_builder_integration_tests
rm test/over_react/component_declaration/flux_component_test/component2/unsound_flux_component_test.dart
rm test/over_react/component_declaration/flux_component_test/unsound_flux_component_test.dart
rm test/over_react_component_declaration_non_null_safe_test.dart

rm -rf tools/analyzer_plugin/test/unit/util/non_null_safe
rm -rf tools/analyzer_plugin/test/integration/assists/non_null_safe
rm -rf tools/analyzer_plugin/test/integration/diagnostics/non_null_safe