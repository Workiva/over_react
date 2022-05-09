#!/usr/bin/env bash

# Fail this script if any command fails
set -e
# Print commands as they run
set -x

analyzer_constraint="$1"

echo "Validating analyzer version constraint: $analyzer_constraint"

# sed -i is not portable, so we write to a separate file: https://unix.stackexchange.com/a/92907
dart tool/set_analyzer_constraint.dart "$analyzer_constraint"

pub get

dart analyze .

# Verify the over_react builder runs without errors, since the builder itself isn't fully covered by tests.
dart run build_runner build --build-filter='**.dart' --delete-conflicting-outputs

dart run test -p vm -- test/vm_tests/builder
