#!/usr/bin/env bash

# ##################################################################################
#
# Runs all analyzer plugin tasks that should be run in the parent over_react CI
#
# ##################################################################################

# Fail any script if any unexpected errors occur in the subsequent commands
set -e

pub get
dart tool/add_over_react_override.dart
pub get
pub run dart_dev format --check
pub run dart_dev analyze
pub run dependency_validator --no-fatal-pins
