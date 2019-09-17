@TestOn('browser')
@JS()
library shared_type_tester;

import 'dart:async';
import 'dart:html' as html;

import 'package:js/js.dart';
import 'package:test/test.dart';

void sharedTypeTests(
  void Function(dynamic value) testTypeValue,
  {
    bool skipNormalDartObjects: false,
    bool skipDartMaps: false,
    bool skipPrimitives: false,
    bool skipNumTypes: false,
    bool skipFunctions: false,
    bool skipBrowserObjects: false,
    bool skipLists: false,
    bool skipDatetimes: false,
    bool skipFutures: false,
    bool skipJsAnonInteropTypes: false,
    bool skipJsInteropTypes: true,
  }
) {
  if (!skipNormalDartObjects) {
    test('normal Dart objects', () {
      final object = new Foo('f');
      final iterable = new Iterable.generate(2);
      testTypeValue(object);
      testTypeValue(iterable);
    });
  }

  if (!skipDartMaps) {
    test('Dart maps', () {
      final dartMap = {};
      testTypeValue(dartMap);
    });
  }

  if (!skipPrimitives) {
    group('primitives', () {
      test('', () {
        final stringValue = 'test';
        final boolValue = false;
        final nullValue = null;

        testTypeValue(stringValue);
        testTypeValue(boolValue);
        testTypeValue(nullValue);
      });
      if (!skipNumTypes) {
        test('num types', () {
          final intValue = (1 as int); // ignore: unnecessary_cast
          final doubleValue = 1.1;
          final numValue = (1 as num); // ignore: unnecessary_cast

          testTypeValue(intValue);
          testTypeValue(doubleValue);
          testTypeValue(numValue);
        });
      }
    });
  }

  if (!skipFunctions) {
    test('functions', () {
      _functionLocalMethod() {}
      final functionLocalMethod = _functionLocalMethod;
      final functionExpression = () {};
      final functionTearOff = new Object().toString;
      final functionAllowInterop = allowInterop(() {});

      testTypeValue(functionLocalMethod);
      testTypeValue(functionExpression);
      testTypeValue(functionTearOff);
      testTypeValue(functionAllowInterop);
    });
  }

  if (!skipBrowserObjects) {
    test('browser objects', () {
      final element = new html.DivElement();
      final customEvent = new html.CustomEvent('foo');
      final window = html.window;

      testTypeValue(element);
      testTypeValue(customEvent);
      testTypeValue(window);
    });
  }

  if (!skipLists) {
    test('lists', () {
      final listDynamic = [1, 'foo'];
      final listInt = <int>[1, 2, 3];

      testTypeValue(listDynamic);
      testTypeValue(listInt);
    });
  }

  if (!skipDatetimes) {
    test('datetimes', () {
      final dateTime = new DateTime.utc(2018);

      testTypeValue(dateTime);
    });
  }

  if (!skipFutures) {
    test('futures', () {
      final future = new Future(() {});

      testTypeValue(future);
    });
  }

  if (!skipJsAnonInteropTypes) {
    test('JS anonymous interop types', () {
      final jsAnonymous = new JsTypeAnonymous();

      testTypeValue(jsAnonymous);
    });
  }

  if (!skipJsInteropTypes) {
    test('JS interop types', () {
      final jsType = new JsType();

      testTypeValue(jsType);
    });
  }
}

class Foo {
  final foo;
  Foo(this.foo);
}

@JS()
@anonymous
class JsTypeAnonymous {
  external factory JsTypeAnonymous();
}

@JS()
class JsType {
  external JsType();
}
