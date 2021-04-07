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

import 'package:mockito/mockito.dart';
import 'package:over_react/over_react.dart';
import 'package:over_react/src/over_react_redux/value_mutation_checker.dart';
import 'package:react/react.dart' as react;
import 'package:test/test.dart';

// ignore_for_file: invalid_use_of_protected_member
main() {
  group('Value Mutation Checker:', () {
    group('CollectionLengthHasher', () {
      sharedHashTests(() => CollectionLengthHasher());

      group('hash', () {
        CollectionLengthHasher hasher;

        setUp(() {
          hasher = CollectionLengthHasher();
        });

        test('returns the correct value for a map', () {
          final map = {'a': 1, 'b': '2'};
          final domProps = DomProps(react.a as ReactComponentFactoryProxy);
          expect(hasher.hash(map), 2);
          expect(hasher.hash(domProps.props), 0);

          map['c'] = 3;
          domProps.addProps({'href': 'google.com'});
          expect(hasher.hash(map), 3);
          expect(hasher.hash(domProps.props), 1);
        });

        test('returns the correct value for an iterable', () {
          final list = [1, 2, 3];
          final set = {1, 2, 3};
          expect(hasher.hash(list), 3);
          expect(hasher.hash(set), 3);

          list.add(4);
          set.add(4);
          expect(hasher.hash(list), 4);
          expect(hasher.hash(set), 4);
        });
      });
    });

    group('CollectionShallowHasher', () {
      sharedHashTests(() => CollectionShallowHasher());

      group('hash', () {
        CollectionShallowHasher hasher;

        setUp(() {
          hasher = CollectionShallowHasher();
        });

        test('is not affected by order for sets and maps', () {
          final set1 = {1, 2, 3};
          final set2 = {2, 3, 1};

          final map1 = {'a': 1, 'b': 2, 'c': 3};
          final map2 = {'b': 2, 'a': 1, 'c': 3};

          expect(hasher.hash(set1), hasher.hash(set2));
          expect(hasher.hash(map1), hasher.hash(map2));
        });

        test('is affected by order for iterables (besides sets)', () {
          final list1 = [1, 2, 3];
          final list2 = [2, 1, 3];

          expect(hasher.hash(list1) == hasher.hash(list2), isFalse);
        });
      });
    });
  });
}

void sharedHashTests(InstanceHasher Function() getHasher) {
  InstanceHasher hasher;

  setUp(() {
    hasher = getHasher();
  });

  group('canHash returns', () {
    test('false if the object is not a map or an iterable', () {
      expect(hasher.canHash(0), isFalse);
      expect(hasher.canHash('test'), isFalse);
      expect(hasher.canHash(false), isFalse);
    });

    test('true if the object is a map or iterable', () {
      final props = DomProps(react.a as ReactComponentFactoryProxy);
      final list = MockList();

      expect(hasher.canHash({'e', 'a', 'b'}), isTrue);
      expect(hasher.canHash([]), isTrue);
      expect(hasher.canHash({'a': 1}), isTrue);
      expect(hasher.canHash(props), isTrue);
      expect(hasher.canHash(list), isTrue);
    });
  });

  test('hash throws an argument error if the value is not an iterable or a map',
      () {
    expect(() => hasher.hash(0), throwsArgumentError);
  });

  group('hashHasChanged', () {
    group('returns false if', () {
      test('canHash returns false', () {
        expect(hasher.hasHashChanged(0), isFalse);
      });

      test('the object has not been checked before', () {
        final props = DomProps(react.a as ReactComponentFactoryProxy);
        expect(hasher.hasHashChanged(props), isFalse);
      });

      test('the object does not change', () {
        final map = {'test': true};
        expect(hasher.hasHashChanged(map), isFalse);
        map['update'] = true;

        expect(hasher.hasHashChanged(map), isTrue);
        expect(hasher.hasHashChanged(map), isFalse);
      });
    });

    test('returns true if the hash has changed', () {
      final map = {'test': true};
      expect(hasher.hasHashChanged(map), isFalse);

      map['newField'] = true;
      expect(hasher.hasHashChanged(map), isTrue);
    });
  });
}

class MockList extends Mock implements List {}
