library css_value_util_test;

import 'package:test/test.dart';
import 'package:w_ui_platform/ui_core.dart';

/// Main entry point for  testing
main() {
  group('css_value_util part - CssValue class', () {
    group('parse', () {
      test('all valid units', () {
        double value = 34.0;
        var units = ['em', 'ex', 'rem', 'vh', 'vw', 'vmin', 'vmax', '%', 'px', 'cm', 'mm', 'in', 'pt', 'pc', 'ch'];
        for (String unit in units) {
          expect(new CssValue.parse(value.toString() + unit).number, equals(value));
        }
      });

      test('invalid unit', () {
        expect(new CssValue.parse('123blarb', onError: (source) => null), isNull);
      });

      test('no unit', () {
        var cssValue = new CssValue.parse('123');
        expect(cssValue.number, equals(double.parse('123')));
        expect(cssValue.unit, equals('px'));
      });
    });

    group('checkMatchingUnits', () {
      test('same units', () {
        var val1 = new CssValue(123, '%');
        var val2 = new CssValue(456, '%');
        try {
          val1.checkMatchingUnits(val2);
        } catch (exception) {
          fail('unit were the same and should not have caused an error to be thrown');
        }
      });

      test('different units', () {
        var val1 = new CssValue(123, '%');
        var val2 = new CssValue(456, 'em');
        try {
          val1.checkMatchingUnits(val2);
        } catch (exception) {
          return;
        }
        fail('unit were different and should have caused an error to be thrown');
      });
    });

    group('compare', () {
      test('less than', () {
        var val1 = new CssValue(123);
        var val2 = new CssValue(456);
        expect(val1 < val2, isTrue);
        expect(val2 < val1, isFalse);
      });
      test('less than or equal', () {
        var val1 = new CssValue(123);
        var val2 = new CssValue(456);
        var val3 = new CssValue(123);
        expect(val1 <= val2, isTrue);
        expect(val1 <= val3, isTrue);
        expect(val2 <= val1, isFalse);
      });
      test('greater than', () {
        var val1 = new CssValue(123);
        var val2 = new CssValue(456);
        expect(val1 > val2, isFalse);
        expect(val2 > val1, isTrue);
      });
      test('greater than or equal', () {
        var val1 = new CssValue(123);
        var val2 = new CssValue(456);
        var val3 = new CssValue(123);
        expect(val1 >= val2, isFalse);
        expect(val1 >= val3, isTrue);
        expect(val2 >= val1, isTrue);
      });
      test('equal', () {
        var val1 = new CssValue(123);
        var val2 = new CssValue(456);
        var val3 = new CssValue(123);
        expect(val1 == val2, isFalse);
        expect(val1 == val3, isTrue);
        expect(val2 == val1, isFalse);
      });
      test('negation', () {
        var val1 = new CssValue(123);
        expect(-val1.number, equals(-123));
      });
    });

    group('operator', () {
      test('addition', () {
        var val1 = new CssValue(25);
        expect(val1 + 5, equals(new CssValue(30)));
      });
      test('subtraction', () {
        var val1 = new CssValue(25);
        expect(val1 - 5, equals(new CssValue(20)));
      });
      test('division', () {
        var val1 = new CssValue(25);
        expect(val1 / 5, equals(new CssValue(5)));
      });
      test('multiplication', () {
        var val1 = new CssValue(25);
        expect(val1 * 5, equals(new CssValue(125)));
      });
      test('modulo', () {
        var val1 = new CssValue(25);
        expect(val1 % 4, equals(new CssValue(1)));
      });

    });

  });
}
