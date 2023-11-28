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
    bool skipNormalDartObjects = false,
    bool skipDartMaps = false,
    bool skipPrimitives = false,
    bool skipNumTypes = false,
    bool skipFunctions = false,
    bool skipBrowserObjects = false,
    bool skipLists = false,
    bool skipDatetimes = false,
    bool skipFutures = false,
    bool skipJsAnonInteropTypes = false,
    bool skipJsInteropTypes = true,
  }
) {
  if (!skipNormalDartObjects) {
    test('normal Dart objects', () {
      final object = Foo('f');
      final iterable = Iterable.generate(2);
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
        const stringValue = 'test';
        const boolValue = false;
        const nullValue = null;

        testTypeValue(stringValue);
        testTypeValue(boolValue);
        testTypeValue(nullValue);
      });
      if (!skipNumTypes) {
        test('num types', () {
          const intValue = (1 as int); // ignore: unnecessary_cast
          const doubleValue = 1.1;
          const numValue = (1 as num); // ignore: unnecessary_cast

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
      // ignore: prefer_function_declarations_over_variables
      final functionExpression = () {};
      final functionTearOff = Object().toString;
      final functionAllowInterop = allowInterop(() {});

      testTypeValue(functionLocalMethod);
      testTypeValue(functionExpression);
      testTypeValue(functionTearOff);
      testTypeValue(functionAllowInterop);
    });
  }

  if (!skipBrowserObjects) {
    test('browser objects', () {
      final element = html.DivElement();
      final customEvent = html.CustomEvent('foo');
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
      final dateTime = DateTime.utc(2018);

      testTypeValue(dateTime);
    });
  }

  if (!skipFutures) {
    test('futures', () {
      final future = Future(() {});

      testTypeValue(future);
    });
  }

  if (!skipJsAnonInteropTypes) {
    test('JS anonymous interop types', () {
      final jsAnonymous = JsTypeAnonymous();

      testTypeValue(jsAnonymous);
    });
  }

  if (!skipJsInteropTypes) {
    test('JS interop types', () {
      final jsType = JsType();

      testTypeValue(jsType);
    });
  }
}

class Foo {
  final dynamic foo;
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
