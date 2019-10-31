@TestOn('browser')

import 'package:test/test.dart';
import 'package:over_react/over_react.dart';

part 'prop_key_util_test_dart2.over_react.g.dart';

main() {
  group('getPropKey', () {
    test('returns the expected key', () {
      var testProps = Test()..foo = 'baz';
      var fooPropKey = getPropKey<TestProps>((props) { props.foo; }, Test);
      expect(testProps, equals({fooPropKey: 'baz'}));
    });

    test('throws if you don\'t access the prop', () {
      expect(() => getPropKey((props) => false, Test), throwsStateError);
    });

    test('throws if you access the prop multiple times', () {
      expect(() => getPropKey<TestProps>((props) {
        props.foo;
        props.foo;
      }, Test), throwsStateError);
    });

    test('throws if you access multiple props', () {
      expect(() => getPropKey<TestProps>((props) {
        props.foo;
        props.bar;
      }, Test), throwsStateError);
    });
  });
}

@Factory()
UiFactory<TestProps> Test = _$Test;

@Props()
class _$TestProps extends UiProps {
  String foo;

  String bar;
}

@Component2()
class TestComponent extends UiComponent2<TestProps> {
  @override
  render() {}
}

