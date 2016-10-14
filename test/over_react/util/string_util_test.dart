library string_util_test;

import 'package:over_react/over_react.dart';
import 'package:test/test.dart';

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
