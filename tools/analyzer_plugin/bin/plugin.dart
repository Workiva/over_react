// @dart=2.9
// ^ Without this version comment, the plugin will fail to start
// if it imports any non-null-safe code (e.g., from over_react).
//
// Before removing, ensure all import_of_legacy_library_into_null_safe
// analysis errors are fixed.

import 'dart:isolate';

import 'package:over_react_analyzer_plugin/plugin_starter.dart';

void main(List<String> args, SendPort sendPort) {
  start(args, sendPort);
}
