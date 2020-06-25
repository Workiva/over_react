#!/usr/bin/env bash

set -e

pub run dart_dev test -P vm
pub run test --precompiled ddc_precompiled -P dartdevc
pub run dart_dev test --build-args="-r" -P dart2js
