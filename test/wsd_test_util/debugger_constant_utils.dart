library debugger_constant_utils;

import 'package:test/test.dart';
import 'package:web_skin_dart/ui_core.dart';

/// Common tests that verify the values of `degbugDescription`s of [DebugFriendlyConstant]s.
void sharedDebugConstTest(String constName, Map<DebugFriendlyConstant, String> constToDebugDesc) {
  group(constName, () {
    constToDebugDesc.forEach((DebugFriendlyConstant key, String value) {
      test('has the correct debugDescription for $key', () {
        expect(key.debugDescription, value);
      });
    });
  });
}
