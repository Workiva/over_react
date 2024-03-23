// Copyright 2024 Workiva Inc.
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

import 'package:over_react_analyzer_plugin/src/util/weak_map.dart';
import 'package:test/test.dart';

void main() {
  group('WeakMap', () {
    test('associates a value with a key', () {
      final weakMap = WeakMap<TestObject, TestObject>();
      final key = TestObject('key');
      final value = TestObject('value');
      weakMap.set(key, value);
      expect(weakMap.get(key), same(value));
    });

    test('associates more than one value with a key', () {
      final weakMap = WeakMap<TestObject, TestObject>();
      final key1 = TestObject('key1');
      final value1 = TestObject('value1');
      final key2 = TestObject('key2');
      final value2 = TestObject('value2');

      expect(key1, isNot(same(key2)), reason: 'test setup check');
      expect(value1, isNot(same(value2)), reason: 'test setup check');

      weakMap.set(key1, value1);
      weakMap.set(key2, value2);
      expect(weakMap.get(key1), same(value1));
      expect(weakMap.get(key2), same(value2));
    });

    test('works with null values', () {
      final weakMap = WeakMap<TestObject, TestObject?>();
      final key = TestObject('key');
      weakMap.set(key, null);
      expect(weakMap.get(key), isNull);
      expect(weakMap.has(key), isTrue);
    });

    test('.get returns null if no value is associated with a key', () {
      final weakMap = WeakMap<TestObject, TestObject>();
      expect(weakMap.get(TestObject('key')), isNull);
    });

    group('.getNullableKey', () {
      test('returns null for null', () {
        final weakMap = WeakMap<TestObject, TestObject>();
        expect(weakMap.getNullableKey(null), isNull);
        weakMap.set(TestObject('key'), TestObject('value'));
        expect(weakMap.getNullableKey(null), isNull);
      });

      test('returns the same value as .get for non-null arguments', () {
        final weakMap = WeakMap<TestObject, TestObject>();
        final key = TestObject('key');
        final value = TestObject('value');
        weakMap.set(key, value);
        expect(weakMap.getNullableKey(key), same(value));
      });
    });

    test('.set overwrites existing values', () {
      final weakMap = WeakMap<TestObject, TestObject>();
      final key = TestObject('key');
      weakMap.set(key, TestObject('originalValue'));

      final newValue = TestObject('newValue');
      weakMap.set(key, newValue);
      expect(weakMap.get(key), same(newValue));
    });

    test('.remove removes values', () {
      final weakMap = WeakMap<TestObject, TestObject>();
      final key = TestObject('key');
      final value = TestObject('value');
      weakMap.set(key, value);
      expect(weakMap.get(key), same(value), reason: 'test setup check');

      weakMap.remove(key);
      expect(weakMap.has(key), isFalse);
      expect(weakMap.get(key), isNull);
    });

    test('.has returns whether a key has a value', () {
      final weakMap = WeakMap<TestObject, TestObject>();
      final key = TestObject('key');
      final value = TestObject('value');

      expect(weakMap.has(key), isFalse);

      weakMap.set(key, value);
      expect(weakMap.has(key), isTrue);

      expect(weakMap.has(value), isFalse);
    });

    group('.putIfAbsent', () {
      test('stores a value if not present', () {
        final weakMap = WeakMap<TestObject, TestObject>();
        final key = TestObject('key');

        final ifAbsentValue = TestObject('ifAbsentValue');
        weakMap.putIfAbsent(key, () => ifAbsentValue);

        expect(weakMap.get(key), same(ifAbsentValue));
      });

      test('does not recompute or store the value if already present', () {
        final weakMap = WeakMap<TestObject, TestObject>();
        final key = TestObject('key');
        final originalValue = TestObject('originalValue');
        weakMap.set(key, originalValue);

        final ifAbsentValue = TestObject('ifAbsentValue');
        var ifAbsentCalled = false;
        weakMap.putIfAbsent(key, () {
          ifAbsentCalled = true;
          return ifAbsentValue;
        });

        expect(weakMap.get(key), same(originalValue));
        expect(ifAbsentCalled, isFalse);
      });
    });

    test('does not share data across instances', () {
      final weakMap1 = WeakMap<TestObject, TestObject>();
      final weakMap2 = WeakMap<TestObject, TestObject>();
      final key = TestObject('key');
      final value1 = TestObject('value1');
      final value2 = TestObject('value2');

      weakMap1.set(key, value1);
      expect(weakMap1.get(key), same(value1));
      expect(weakMap1.has(key), isTrue);
      expect(weakMap2.get(key), isNull);
      expect(weakMap2.has(key), isFalse);

      weakMap2.set(key, value2);
      expect(weakMap1.get(key), same(value1));
      expect(weakMap1.has(key), isTrue);
      expect(weakMap2.get(key), same(value2));
      expect(weakMap2.has(key), isTrue);

      weakMap1.remove(key);
      expect(weakMap1.get(key), isNull);
      expect(weakMap1.has(key), isFalse);
      expect(weakMap2.get(key), same(value2));
      expect(weakMap2.has(key), isTrue);
    });
  });
}

/// A test object with a name, for better toString values and error messages.
class TestObject {
  final String debugName;

  TestObject(this.debugName);

  @override
  toString() => 'TestObject: $debugName';
}
