// Copyright 2016 Workiva Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

@TestOn('browser')
library css_value_util_test;

import 'package:dart2_constant/core.dart' as d2c;
import 'package:over_react/over_react.dart';
import 'package:test/test.dart';

/// Main entry point for  testing
main() {
  group('css_value_util part', () {
    group('CssValue', () {
      group('returns the parsed value for', () {
        test('each and every valid unit', () {
          double value = 34.0;
          var units = ['em', 'ex', 'rem', 'vh', 'vw', 'vmin', 'vmax', '%', 'px', 'cm', 'mm', 'in', 'pt', 'pc', 'ch'];
          for (String unit in units) {
            expect(CssValue.parse('$value$unit').number, equals(value));
          }
        });

        test('numbers without units, defaulting to `px`', () {
          var cssValue = CssValue.parse('123');
          expect(cssValue.number, equals(double.parse('123')));
          expect(cssValue.unit, equals('px'));
        });

        group('invalid values, such as', () {
          group('values with invalid units', () {
            test('and returns the result of calling the `onError` callback with the provided value and corresponding error', () {
              var retValue = CssValue(34, '%');
              var val = CssValue.parse('123blarb', onError: (source, error) => retValue);
              expect(val, same(retValue));
            });

            test('and returns no when no `onError` callback is specified', () {
              var val = CssValue.parse('123blarb');
              expect(val, isNull);
            });
          });

          test('`null`', () {
            ArgumentError error;
            CssValue.parse(null, onError: (value, e) {
              error = e;
              return null;
            });

            expect(error, isNotNull);
            expect(error.message, equals('Must not be null'));
          });

          group('non-finite numbers:', () {
            void testValue(value) {
              ArgumentError error;
              CssValue.parse(value, onError: (val, err) {
                error = err;
                return null;
              });
              expect(error, isNotNull);
              expect(error.message, endsWith('must be finite'));
            }

            test('infinity', () {
              testValue(d2c.double.infinity);
              testValue(d2c.double.infinity.toString());
            });

            test('negative infinity', () {
              testValue(d2c.double.negativeInfinity);
              testValue(d2c.double.negativeInfinity.toString());
            });

            test('NaN', () {
              testValue(d2c.double.nan);
              testValue(d2c.double.nan.toString());
            });
          });

          test('invalid numbers', () {
            ArgumentError error;
            CssValue.parse('aa123px', onError: (value, e) {
              error = e;
              return null;
            });

            expect(error, isNotNull);
            expect(error.message, endsWith('Invalid number/unit for CSS value'));
          });
        });
      });

      group('comparison:', () {
        group('for values of the same unit, returns the expected result for', () {
          test('the "less than" operator', () {
            var val1 = CssValue(123);
            var val2 = CssValue(456);
            expect(val1 < val2, isTrue);
            expect(val2 < val1, isFalse);
          });

          test('the "less than or equal" operator', () {
            var val1 = CssValue(123);
            var val2 = CssValue(456);
            var val3 = CssValue(123);
            expect(val1 <= val2, isTrue);
            expect(val1 <= val3, isTrue);
            expect(val2 <= val1, isFalse);
          });

          test('the "greater than" operator', () {
            var val1 = CssValue(123);
            var val2 = CssValue(456);
            expect(val1 > val2, isFalse);
            expect(val2 > val1, isTrue);
          });

          test('the "greater than or equal" operator', () {
            var val1 = CssValue(123);
            var val2 = CssValue(456);
            var val3 = CssValue(123);
            expect(val1 >= val2, isFalse);
            expect(val1 >= val3, isTrue);
            expect(val2 >= val1, isTrue);
          });

          group('the "equal" operator', () {
            test('when the other object is a CssValue', () {
              var val1 = CssValue(123);
              var val2 = CssValue(456);
              var val3 = CssValue(123);
              expect(val1 == val2, isFalse);
              expect(val1 == val3, isTrue);
              expect(val2 == val1, isFalse);
            });

            test('when the other object is not a CssValue', () {
              var val1 = CssValue(123);
              expect(val1 == null, isFalse);
              expect(val1 == Object(), isFalse);
            });
          });

          test('the compare() function', () {
            var sortedValues = [
              const CssValue(2),
              const CssValue(0),
              const CssValue(-1),
              const CssValue(-2),
              const CssValue(1),
            ]..sort();

            var expectedValues =[
              const CssValue(-2),
              const CssValue(-1),
              const CssValue(0),
              const CssValue(1),
              const CssValue(2),
            ];

            expect(sortedValues, equals(expectedValues));
          });
        });

        group('for values of non-matching units,', () {
          group('for values of non-matching units, throws an error for', () {
            test('the "less than" operator', () {
              expect(() => (CssValue.parse('10px') < CssValue.parse('10%')), throwsArgumentError);
            });

            test('the "less than or equal" operator', () {
              expect(() => (CssValue.parse('10px') <= CssValue.parse('10%')), throwsArgumentError);
            });

            test('the "greater than" operator', () {
              expect(() => (CssValue.parse('10px') > CssValue.parse('10%')), throwsArgumentError);
            });

            test('the "greater than or equal" operator', () {
              expect(() => (CssValue.parse('10px') >= CssValue.parse('10%')), throwsArgumentError);
            });

            test('the compare() function', () {
              expect(() => Comparable.compare(CssValue.parse('10px'), CssValue.parse('10%')), throwsArgumentError);
            });
          });

          test('returns the expected result for the "equal" operator', () {
            expect((CssValue.parse('10px') == CssValue.parse('10%')), isFalse);
          });
        });
      });

      group('returns the expected result for', () {
        test('the "addition" operator', () {
          var val1 = CssValue(25);
          var val2 = CssValue(5);
          expect(val1 + val2, equals(CssValue(30)));
        });

        test('the "subtraction" operator', () {
          var val1 = CssValue(25);
          var val2 = CssValue(5);
          expect(val1 - val2, equals(CssValue(20)));
        });

        test('the "division" operator', () {
          var val1 = CssValue(25);
          expect(val1 / 5, equals(CssValue(5)));
        });

        test('the "multiplication" operator', () {
          var val1 = CssValue(25);
          expect(val1 * 5, equals(CssValue(125)));
        });

        test('the "modulo" operator', () {
          var val1 = CssValue(25);
          expect(val1 % 4, equals(CssValue(1)));
        });

        test('the "negation" operator', () {
          var val1 = CssValue(123);
          expect(-(val1.number), equals(-123));
        });
      });

      group('toString', () {
        test('returns the number without unnecessary decimals', () {
          expect(CssValue(123).toString(), '123px');
        });

        test('returns the number with decimals if necessary', () {
          expect(CssValue(1.23).toString(), '1.23px');
        });

        test('doesn\'t add a unit to zero', () {
          expect(CssValue(0).toString(), '0');
        });
      });
    });
  });
}
