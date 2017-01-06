#!/usr/bin/env bash

# Can't run tests in dart2js on Travis since the suite takes too long to load and times out.
# Run on Smithy instead.
# See https://github.com/Workiva/over_react/issues/36

set -e

# Trick the test package into using Chromium instead of Chrome
TMP_BIN=$(mktemp -d)
ln -s "$(which chromium-browser)" "$TMP_BIN/google-chrome"
export PATH="$PATH:$TMP_BIN"

# Run the tests
DART_FLAGS=--checked  xvfb-run -s '-screen 0 1024x768x24' pub run dart_dev test -p chrome

# Be sneaky and clean up our tricks
rm -rf "$TMP_BIN"
