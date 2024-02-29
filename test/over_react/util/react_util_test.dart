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
    late Map backingMap;
    late UiPropsMapView mapView;

    setUp(() {
      backingMap = {
        'id': 'test-id',
      };
      mapView = TestUiPropsMapView(backingMap);
    });

    test('reads from and writes to the backing map as expected', () {
      expect(mapView.id, 'test-id');
      mapView.id = 'something else';
      mapView['foo'] = 'bar';
      expect({...mapView}, {'id': 'something else', 'foo': 'bar'});
      expect({...mapView}, backingMap);
    });

    test('getPropKey works as expected and uses selfFactory to construct a new instance', () {
      final getPropKeyCalls = [];
      final result = mapView.getPropKey((p) {
        getPropKeyCalls.add(p);
        p.id;
      });
      expect(result, 'id');
      expect(getPropKeyCalls, [isA<TestUiPropsMapView>()]);
      expect(getPropKeyCalls.single, isNot(same(mapView)));
    });

    group('throws an `UnimplementedError` when unimplemented fields/methods are accessed/called:', () {
      test('`\$isClassGenerated`', () {
        expect(() => mapView.$isClassGenerated, throwsUnimplementedError);
      });

      test('`propKeyNamespace`', () {
        expect(() => mapView.propKeyNamespace, throwsUnimplementedError);
      });

      test('`componentFactory`', () {
        expect(() => mapView.componentFactory, throwsUnimplementedError);
      });

      test('`testId`', () {
        expect(() => mapView.testId, throwsUnimplementedError);
      });

      test('`defaultProps`', () {
        expect(() => mapView.componentDefaultProps, throwsUnimplementedError);
      });

      test('`getTestId()`', () {
        expect(() => mapView.getTestId(), throwsUnimplementedError);
      });

      test('`addTestId()`', () {
        expect(() => mapView.addTestId('foo'), throwsUnimplementedError);
      });

      test('`addProp()`', () {
        expect(() => mapView.addProp('data-foo', 'bar'), throwsUnimplementedError);
      });

      test('`addProps()`', () {
        expect(() => mapView.addProps({'data-foo': 'bar'}), throwsUnimplementedError);
      });

      test('`modifyProps()`', () {
        expect(() => mapView.modifyProps((_) => {'data-foo': 'bar'}), throwsUnimplementedError);
      });

      test('`build()`', () {
        expect(() => mapView.build(), throwsUnimplementedError);
      });

      test('`call()`', () {
        expect(() => mapView.call(), throwsUnimplementedError);
      });
    });
  });
}

class TestUiPropsMapView extends UiPropsMapView {
  TestUiPropsMapView(Map map): super(map);

  @override
  TestUiPropsMapView selfFactory(Map props) => TestUiPropsMapView(props);
}
