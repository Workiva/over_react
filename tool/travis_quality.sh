#!/usr/bin/env bash

set -e

pub run dart_dev format --check
pub run build_runner build --delete-conflicting-outputs -o ddc_precompiled
git diff --exit-code
pub run dart_dev analyze
pub run dependency_validator --no-fatal-pins -i analyzer,build_runner,build_web_compilers,built_value_generator
