library string_util_test;

import 'package:test/test.dart';
import 'package:over_react/ui_core.dart';

/// Main entry point for StringUtil testing
main() {
  group('unindent', () {
    test('unindents a multiline string correctly', () {
      String testStr =
          '''
          Yo
            How u doin'?
          ''';

      String expectedResult =
'''
Yo
  How u doin'?''';

      expect(unindent(testStr), expectedResult);
    });
  });
}
