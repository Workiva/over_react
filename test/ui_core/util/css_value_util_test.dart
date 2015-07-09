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

      group('invalid unit', () {
        test('with an onError function specified', () {
          var retValue = new CssValue(34, '%');
          var val = new CssValue.parse('123blarb', onError: (source, error) => retValue);
          expect(val, equals(retValue));
        });

        test('without an onError function specified', () {
          var val = new CssValue.parse('123blarb');
          expect(val, isNull);
        });
      });

      test('no unit', () {
        var cssValue = new CssValue.parse('123');
        expect(cssValue.number, equals(double.parse('123')));
        expect(cssValue.unit, equals('px'));
      });

      test('null value', () {
        ArgumentError error = null;
        new CssValue.parse(null, onError: (value, e) {
          error = e;
        });

        expect(error, isNotNull);
        expect(error.message, equals('Must not be null'));
      });

      test('infinte values', () {
        var invalidValues = [
          double.INFINITY, double.NEGATIVE_INFINITY, double.NAN,
          double.INFINITY.toString(), double.NEGATIVE_INFINITY.toString(), double.NAN.toString()
        ];

        for (var value in invalidValues) {
          ArgumentError error = null;
          new CssValue.parse(value, onError: (val, err) {
            error = err;
          });
          expect(error, isNotNull);
          expect(error.message, endsWith('must be finite'));
        }
      });

      test('invalid string "aa123px"', () {
        ArgumentError error = null;
        new CssValue.parse('aa123px', onError: (value, e) {
          error = e;
        });

        expect(error, isNotNull);
        expect(error.message, endsWith('Invalid number/unit for CSS value'));
      });
    });

    group('compare', () {
      group('with matching units', () {
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
      });
      group('with non-matching units', () {
        test('less than', () {
          expect(() => (new CssValue.parse('10px') < new CssValue.parse('10%')), throwsArgumentError);
        });
        test('less than or equal', () {
          expect(() => (new CssValue.parse('10px') <= new CssValue.parse('10%')), throwsArgumentError);
        });
        test('greater than', () {
          expect(() => (new CssValue.parse('10px') > new CssValue.parse('10%')), throwsArgumentError);
        });
        test('greater than or equal', () {
          expect(() => (new CssValue.parse('10px') >= new CssValue.parse('10%')), throwsArgumentError);
        });
        test('equal', () {
          expect((new CssValue.parse('10px') == new CssValue.parse('10%')), isFalse);
        });
      });
    });

    group('math operations', () {
      test('addition', () {
        var val1 = new CssValue(25);
        var val2 = new CssValue(5);
        expect(val1 + val2, equals(new CssValue(30)));
      });
      test('subtraction', () {
        var val1 = new CssValue(25);
        var val2 = new CssValue(5);
        expect(val1 - val2, equals(new CssValue(20)));
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
      test('negation', () {
        var val1 = new CssValue(123);
        expect(-(val1.number), equals(-123));
      });
    });
  });
}
