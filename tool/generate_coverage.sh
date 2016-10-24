#!/usr/bin/env bash

# DART_FLAGS has to be set to `--checked` because dart_dev does not run tests in checked mode.
DART_FLAGS=--checked pub run dart_dev coverage --no-html --no-open
