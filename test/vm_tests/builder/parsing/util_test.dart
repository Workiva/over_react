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
      late Union<String, int> unionA;
      late Union<String, int> unionB;

      setUp(() {
        unionA = Union.a('test');
        unionB = Union.b(0);

        // Set up sanity checks
        expect(unionA.b, isNull);
        expect(unionA.a, isA<String>());
        expect(unionB.a, isNull);
        expect(unionB.b, isA<int>());
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
      group('firstWhereType', () {
        const iterable = [0, true, false, 1, 'bye'];

        test('returns the first of the given type', () {
          expect(iterable.firstWhereType<bool>(), true);
          expect(iterable.firstWhereType<String>(), 'bye');
          expect(iterable.firstWhereType<int>(), 0);
        });

        test('calls the provided callback if nothing is found', () {
          expect(iterable.firstWhereType<Map>(orElse: () => {}), isA<Map>());
        });

        test('throws an error if no callback is specified and nothing is found', () {
          expect(() => iterable.firstWhereType<Map>(), throwsStateError);
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
