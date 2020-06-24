import 'package:over_react_analyzer_plugin/src/util/react_types.dart';
import 'package:test/test.dart';

import '../mocks/element_mock.dart';

void main() {
  group('react_types', () {
    test('isComponentClass', () {
      final dummyType = DartTypeMock();
      expect(dummyType.isComponentClass, isTrue);
    });
  });
}
