library over_react_tests.shared.map_proxy_tests;

import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

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

    test('addAll', () {
      var testMap = {};
      when(mock.addAll(any)).thenReturn('value');

      expect(proxy.addAll(testMap), isNull);
      verify(mock.addAll(argThat(same(testMap))));
    });

    test('clear', () {
      expect(proxy.clear(), isNull);
      verify(mock.clear());
    });

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

    test('forEach', () {
      var callback = (key, value) {};

      expect(proxy.forEach(callback), isNull);
      verify(mock.forEach(callback));
    });

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
  });
}

class MockMap extends Mock implements Map {}
