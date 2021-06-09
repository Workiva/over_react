// @dart=2.7
// ^ Do not remove until migrated to null safety. More info at https://wiki.atl.workiva.net/pages/viewpage.action?pageId=189370832
// Copyright 2020 Workiva Inc.
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

@TestOn('vm')
import 'package:over_react/src/builder/parsing.dart';
import 'package:test/test.dart';

main() {
  group('parsing utils - ', () {
    group('Union', () {
      Union<String, int> unionA;
      Union<String, int> unionB;

      setUp(() {
        unionA = Union.a('test');
        unionB = Union.b(0);

        // Set up sanity checks
        expect(unionA.b, isNull);
        expect(unionA.a, isA<String>());
        expect(unionB.a, isNull);
        expect(unionB.b, isA<int>());
      });

      test('asserts that args are non-null', () {
        expect(() => Union.a(null), throwsA(isA<AssertionError>()));
        expect(() => Union.b(null), throwsA(isA<AssertionError>()));
      });

      test('either will return the non-null field', () {
        expect(unionA.either, isA<String>());
        expect(unionA.either, 'test');
        expect(unionB.either, isA<int>());
        expect(unionB.either, 0);
      });

      test(
          'switchCase calls the corresponding function based on the value and returns the result', () {
        final calls = [];

        getResult(Union union) {
          return union.switchCase((a) {
            calls.add(['a', a]);
            return 'a return';
          }, (b) {
            calls.add(['b', b]);
            return 'b return';
          });
        }

        expect(getResult(unionA), 'a return');
        expect(calls, [
          ['a', 'test'],
        ]);

        calls.clear();
        expect(getResult(unionB), 'b return');
        expect(calls, [
          ['b', 0],
        ]);
      });
    });

    group('IterableUtil', () {
      group('firstOrNull', () {
        test('returns null if the iterable is empty', () {
          expect([].firstOrNull, isNull);
        });

        test('returns the first element when the iterable is not empty', () {
          expect([true, false, true].firstOrNull, isTrue);
        });
      });

      group('firstWhereType', () {
        var iterable = [0, true, false, 1, 'bye'];

        tearDownAll(() {
          iterable = null;
        });

        test('returns the first of the given type', () {
          expect(iterable.firstWhereType<bool>(), true);
          expect(iterable.firstWhereType<String>(), 'bye');
          expect(iterable.firstWhereType<int>(), 0);
        });

        test('calls the provided callback if nothing is found', () {
          expect(iterable.firstWhereType<Union>(orElse: () => Union<String, dynamic>.a('Nothing there!')), isA<Union<String, dynamic>>());
        });

        test('throws an error if no callback is specified and nothing is found', () {
          expect(() => iterable.firstWhereType<Union>(), throwsStateError);
        });
      });

      group('whereNotNull', () {
        test('returns an empty list of all element are null', () {
          expect([null, null, null].whereNotNull(), []);
        });

        test('returns elements that are not null', () {
          final union = Union.a(0);
          expect([union.b, union.a, 1, null, 2].whereNotNull(), containsAllInOrder([0, 1, 2]));
        });
      });
    });

    group('TryCast', () {
      group('tryCast', () {
        test('returns a child instance or the cast parent class', () {
          B childClass = B();
          A childWrapper = childClass;
          expect(childWrapper.tryCast<B>(), isNotNull);
          expect(childWrapper.tryCast<B>(), isA<B>());
        });

        test('returns null if the instance is not able to be cast', () {
          A childWrapper = A();
          expect(childWrapper.tryCast<B>(), isNull);
        });
      });
    });
  });
}

class A {}

class B extends A {}

class C {}
