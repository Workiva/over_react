library css_value_util_test;

import 'package:test/test.dart';
import 'package:w_ui_platform/ui_core.dart';

/// Main entry point for  testing
main() {
  group('css_value_util part', () {
    group('stripCssUnit', () {
      test('strips all valid units', () {
        var units = ['em', 'ex', 'rem', 'vh', 'vw', 'vmin', 'vmax', '%', 'px', 'cm', 'mm', 'in', 'pt', 'pc', 'ch'];
        for (String unit in units) {
          expect(stripCssUnit('123' + unit), equals('123'));
        }
      });
    });

    group('isValueCssNumericValue', () {
      test('return true for double value 123.5', () {
        expect(isValueCssNumericValue(123.5), isTrue);
      });
      test('return true for string value "123"', () {
        expect(isValueCssNumericValue('123'), isTrue);
      });
      test('return true for string value "123.5"', () {
        expect(isValueCssNumericValue('123'), isTrue);
      });
      test('return true for string value "123px"', () {
        expect(isValueCssNumericValue('123px'), isTrue);
      });
      test('return false for string value "123blarb"', () {
        expect(isValueCssNumericValue('123blarb'), isFalse);
      });
      test('return false for non-string/non-num value', () {
        expect(isValueCssNumericValue({}), isFalse);
      });
    });
  });
}
