library prop_key_util_test;

import 'package:test/test.dart';
import 'package:over_react/over_react.dart';

main() {
  group('getPropKey', () {
    test('returns the expected key', () {
      var testProps = Test()..foo = 'baz';
      var fooPropKey = getPropKey((Map props) { (props as TestProps).foo; }, Test);   // ignore: avoid_as
      expect(testProps, equals({fooPropKey: 'baz'}));
    });

    test('throws if you don\'t access the prop', () {
      expect(() => getPropKey((props) => false, Test), throwsStateError);
    });

    test('throws if you access the prop multiple times', () {
      expect(() => getPropKey((Map props) {
        (props as TestProps).foo; // ignore: avoid_as
        (props as TestProps).foo; // ignore: avoid_as
      }, Test), throwsStateError);
    });

    test('throws if you access multiple props', () {
      expect(() => getPropKey((Map props) {
        (props as TestProps).foo; // ignore: avoid_as
        (props as TestProps).bar; // ignore: avoid_as
      }, Test), throwsStateError);
    });
  });
}

@Factory()
UiFactory<TestProps> Test;

@Props()
class TestProps extends UiProps {
  String foo;

  String bar;
}

@Component()
class TestComponent extends UiComponent<TestProps> {
  @override
  render() {}
}
