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
    MockMap mock;

    setUp(() {
      mock = new MockMap();
      proxy = mapProxyFactory(mock);
    });

    tearDown(() {
      // Ensure that there were no calls other than the ones we verified explicitly.
      verifyNoMoreInteractions(mock);
    });

    // TODO: Implement me
//    test('map', () {});

    // TODO: Implement me
//    test('entries', () {});

    // TODO: Implement me
//    test('addEntries', () {});

    // TODO: Implement me
//    test('removeWhere', () {});

    // TODO: Implement me
//    test('update', () {});

    // TODO: Implement me
//    test('updateAll', () {});

    // TODO: Implement me
//    test('cast', () {});

    // TODO: Implement me
//    test('retype', () {});

    test('operator[]', () {
      when(mock[any]).thenReturn('value');

      expect(proxy['key'], 'value');
      verify(mock['key']);
    });

    test('operator[]=', () {
      when(mock[any] = any).thenReturn('value');

      expect(proxy['key'] = 'value', 'value');
      verify(mock['key'] = 'value');
    });

    // TODO: Fix me
//    test('addAll', () {
//      var testMap = {};
//      when(mock.addAll(any)).thenReturn('value');
//
//      expect(proxy.addAll(testMap), isNull);
//      verify(mock.addAll(argThat(same(testMap))));
//    });

    // TODO: Fix me
//    test('clear', () {
//      expect(proxy.clear(), isNull);
//      verify(mock.clear());
//    });

    test('putIfAbsent', () {
      var ifAbsent = () => 'absent';

      expect(proxy.putIfAbsent('key', ifAbsent), isNull);
      verify(mock.putIfAbsent('key', ifAbsent));
    });

    test('containsKey', () {
      when(mock.containsKey(any)).thenReturn(true);

      expect(proxy.containsKey('key'), isTrue);
      verify(mock.containsKey('key'));
    });

    test('containsValue', () {
      when(mock.containsValue(any)).thenReturn(true);

      expect(proxy.containsValue('value'), isTrue);
      verify(mock.containsValue('value'));
    });

    // TODO: Fix me
//    test('forEach', () {
//      var callback = (key, value) {};
//
//      expect(proxy.forEach(callback), isNull);
//      verify(mock.forEach(callback));
//    });

    test('isEmpty', () {
      when(mock.isEmpty).thenReturn(true);

      expect(proxy.isEmpty, isTrue);
      verify(mock.isEmpty);
    });

    test('isNotEmpty', () {
      when(mock.isNotEmpty).thenReturn(true);

      expect(proxy.isNotEmpty, isTrue);
      verify(mock.isNotEmpty);
    });

    test('length', () {
      when(mock.length).thenReturn(1);

      expect(proxy.length, 1);
      verify(mock.length);
    });

    test('keys', () {
      when(mock.keys).thenReturn(['key']);

      expect(proxy.keys, equals(['key']));
      verify(mock.keys);
    });

    test('remove', () {
      expect(proxy.remove('key'), isNull);
      verify(mock.remove('key'));
    });

    test('values', () {
      when(mock.values).thenReturn(['value']);

      expect(proxy.values, equals(['value']));
      verify(mock.values);
    });
  },
      // Mirrors don't work in the DDC.
      tags: 'no-ddc'
  );
}

class MockMap extends Mock implements Map {}
