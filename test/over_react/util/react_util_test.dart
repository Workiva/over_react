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

// ignore_for_file: deprecated_member_use_from_same_package
@TestOn('browser')
library react_util_test;

import 'package:over_react/over_react.dart';
import 'package:test/test.dart';

main() {
  group('UiPropsMapView', () {
    UiPropsMapView? mapView;

    setUp(() {
      mapView = UiPropsMapView({});
    });

    tearDown(() {
      mapView = null;
    });

    group('throws an `UnimplementedError` when unimplemented fields/methods are accessed/called:', () {
      test('`\$isClassGenerated`', () {
        expect(() => mapView!.$isClassGenerated, throwsUnimplementedError);
      });

      test('`propKeyNamespace`', () {
        expect(() => mapView!.propKeyNamespace, throwsUnimplementedError);
      });

      test('`componentFactory`', () {
        expect(() => mapView!.componentFactory, throwsUnimplementedError);
      });

      test('`testId`', () {
        expect(() => mapView!.testId, throwsUnimplementedError);
      });

      test('`defaultProps`', () {
        expect(() => mapView!.componentDefaultProps, throwsUnimplementedError);
      });

      test('`getTestId()`', () {
        expect(() => mapView!.getTestId(), throwsUnimplementedError);
      });

      test('`addTestId()`', () {
        expect(() => mapView!.addTestId('foo'), throwsUnimplementedError);
      });

      test('`addProp()`', () {
        expect(() => mapView!.addProp('data-foo', 'bar'), throwsUnimplementedError);
      });

      test('`addProps()`', () {
        expect(() => mapView!.addProps({'data-foo': 'bar'}), throwsUnimplementedError);
      });

      test('`modifyProps()`', () {
        expect(() => mapView!.modifyProps((_) => {'data-foo': 'bar'}), throwsUnimplementedError);
      });

      test('`build()`', () {
        expect(() => mapView!.build(), throwsUnimplementedError);
      });

      test('`call()`', () {
        expect(() => mapView!.call(), throwsUnimplementedError);
      });
    });
  });
}
