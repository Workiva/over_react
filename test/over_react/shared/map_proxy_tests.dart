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

library over_react_tests.shared.map_proxy_tests;

import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

void mapProxyTests(Map mapProxyFactory(Map proxiedMap)) {
  group('proxies the Map member:', () {
    Map proxy;
    MockMap backingMap;

    setUp(() {
      backingMap = new MockMap();
      proxy = mapProxyFactory(backingMap);
    });

    tearDown(() {
      // Ensure that there were no calls other than the ones we verified explicitly.
      verifyNoMoreInteractions(backingMap);
    });

    test('map', () {
      var callback = (key, value) {};

      proxy.map(callback);
      verify(backingMap.map(callback));
    });

    test('entries', () {
      var entries = <MapEntry>[];
      when(backingMap.entries).thenReturn(entries);
      expect(proxy.entries, entries);
      verify(proxy.entries);
    });

    test('addEntries', () {
      var entry = MapEntry('key', 'value');
      proxy.addEntries([entry]);
      verify(proxy.addEntries([entry]));
    });

    test('removeWhere', () {
      var callback = (key, value) {};
      proxy.removeWhere(callback);
      verify(backingMap.removeWhere(callback));
    });

    test('update', () {
      var updater = (value) {};
      proxy.update('key', updater);
      verify(backingMap.update('key', updater));
    });

    test('updateAll', () {
      var updater = (key, value) {};
      proxy.updateAll(updater);
      verify(backingMap.updateAll(updater));
    });

    test('cast', () {
      var castMap = {};
      when(backingMap.cast()).thenReturn(castMap);
      expect(proxy.cast(), castMap);
      verify(backingMap.cast());
    });

    test('operator[]', () {
      when(backingMap[any]).thenReturn('value');

      expect(proxy['key'], 'value');
      verify(backingMap['key']);
    });

    test('operator[]=', () {
      when(backingMap['key'] = 'key').thenReturn('value');

      expect(proxy['key'] = 'value', 'value');
      verify(backingMap['key'] = 'value');
    });

    test('addAll', () {
      var testMap = {};

      proxy.addAll(testMap);
      verify(backingMap.addAll(argThat(same(testMap))));
    });

    test('clear', () {
      proxy.clear();
      verify(backingMap.clear());
    });

    test('putIfAbsent', () {
      var ifAbsent = () => 'absent';

      expect(proxy.putIfAbsent('key', ifAbsent), isNull);
      verify(backingMap.putIfAbsent('key', ifAbsent));
    });

    test('containsKey', () {
      when(backingMap.containsKey(any)).thenReturn(true);

      expect(proxy.containsKey('key'), isTrue);
      verify(backingMap.containsKey('key'));
    });

    test('containsValue', () {
      when(backingMap.containsValue(any)).thenReturn(true);

      expect(proxy.containsValue('value'), isTrue);
      verify(backingMap.containsValue('value'));
    });

    test('forEach', () {
      var callback = (key, value) {};

      proxy.forEach(callback);
      verify(backingMap.forEach(callback));
    });

    test('isEmpty', () {
      when(backingMap.isEmpty).thenReturn(true);

      expect(proxy.isEmpty, isTrue);
      verify(backingMap.isEmpty);
    });

    test('isNotEmpty', () {
      when(backingMap.isNotEmpty).thenReturn(true);

      expect(proxy.isNotEmpty, isTrue);
      verify(backingMap.isNotEmpty);
    });

    test('length', () {
      when(backingMap.length).thenReturn(1);

      expect(proxy.length, 1);
      verify(backingMap.length);
    });

    test('keys', () {
      when(backingMap.keys).thenReturn(['key']);

      expect(proxy.keys, equals(['key']));
      verify(backingMap.keys);
    });

    test('remove', () {
      expect(proxy.remove('key'), isNull);
      verify(backingMap.remove('key'));
    });

    test('values', () {
      when(backingMap.values).thenReturn(['value']);

      expect(proxy.values, equals(['value']));
      verify(backingMap.values);
    });
  });
}

class MockMap extends Mock implements Map {}
