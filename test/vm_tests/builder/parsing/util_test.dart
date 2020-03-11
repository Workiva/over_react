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
import 'package:over_react/src/builder/generation/parsing.dart';
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

      test('either will return the non-null field', () {
        expect(unionA.either, isA<String>());
        expect(unionA.either, 'test');
        expect(unionB.either, isA<int>());
        expect(unionB.either, 0);
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
