@TestOn('browser || vm')
import 'package:over_react/src/util/equality.dart';
import 'package:test/test.dart';

main() {
  group('propsOrStateMapsEqual', () {
    /// Expect that `propsOrStateMapsEqual(a, b)` and `propsOrStateMapsEqual(b, a)`
    /// have the same result (represented by [matcher]).
    void expectAreMapsShallowIdenticalCommutatively(Map a, Map b, matcher) {
      final abResult = propsOrStateMapsEqual(a, b);
      final baResult = propsOrStateMapsEqual(b, a);
      expect([abResult, baResult], everyElement(matcher));
    }

    group('returns true for', () {
      test('different maps that are equal', () {
        final a = {
          1: 'one',
          2: 'two',
        };
        final b = {
          1: 'one',
          2: 'two',
        };
        expectAreMapsShallowIdenticalCommutatively(a, b, isTrue);
      });

      test('different maps that are equal with keys in different orders', () {
        final a = {
          1: 'one',
          2: 'two',
        };
        final b = {
          2: 'two',
          1: 'one',
        };
        expectAreMapsShallowIdenticalCommutatively(a, b, isTrue);
      });

      test('different empty maps', () {
        final a = {};
        final b = {};
        expectAreMapsShallowIdenticalCommutatively(a, b, isTrue);
      });

      test('the same map instance', () {
        final a = {1: 'one', 2: 'two'};
        final b = a;
        expectAreMapsShallowIdenticalCommutatively(a, b, isTrue);
      });
    });

    group('returns false for', () {
      test('maps of different length', () {
        final a = {
          1: 'one',
        };
        final b = {
          1: 'one',
          2: 'two',
        };
        expectAreMapsShallowIdenticalCommutatively(a, b, isFalse);
      });

      test('maps with some differing keys and a common set of equal pairs', () {
        final a = {
          1: 'one',
          2: 'two',
        };
        final b = {
          2: 'two',
          3: 'three',
        };
        expectAreMapsShallowIdenticalCommutatively(a, b, isFalse);
      });

      test('maps with different keys but equal values', () {
        final a = {
          1: 'foo',
          2: 'bar',
        };
        final b = {
          3: 'foo',
          4: 'bar',
        };
        expectAreMapsShallowIdenticalCommutatively(a, b, isFalse);
      });

      test('maps with different values but equal keys', () {
        final a = {
          1: 'one',
          2: 'two',
        };
        final b = {
          1: 'one',
          2: 'not two',
        };
        expectAreMapsShallowIdenticalCommutatively(a, b, isFalse);
      });

      test('maps with equal but not identical values', () {
        final valueA = EqualHelper('foo');
        final valueB = EqualHelper('foo');
        expect(valueA, allOf(equals(valueB), isNot(same(valueB))),
            reason: 'test setup check');

        final a = {1: valueA};
        final b = {1: valueB};
        expectAreMapsShallowIdenticalCommutatively(a, b, isFalse);
      });
    });

    test('gracefully handles maps of different types', () {
      final a = <String, int>{'1': 1};
      final b = <bool, String>{true: 'true'};
      expect(b, hasLength(a.length),
          reason: 'test setup check; we want the to get further than'
              ' the length short circuit in the function');

      expect(() => propsOrStateMapsEqual(a, b), returnsNormally);
      expectAreMapsShallowIdenticalCommutatively(a, b, isFalse);
    });
  });
}

class EqualHelper {
  final String value;

  EqualHelper(this.value);

  @override
  int get hashCode => value.hashCode;

  @override
  bool operator ==(Object other) =>
      other is EqualHelper && other.value == value;
}
