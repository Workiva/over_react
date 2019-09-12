@TestOn('browser')
library react_util_test;

import 'package:over_react/over_react.dart';
import 'package:test/test.dart';

main() {
  setClientConfiguration();
  enableTestMode();

  group('UiPropsMapView', () {
    UiPropsMapView mapView;

    setUp(() {
      mapView = new UiPropsMapView({});
    });

    tearDown(() {
      mapView = null;
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
