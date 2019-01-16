import 'package:test/test.dart';
import 'package:over_react/over_react.dart';

// ignore: uri_has_not_been_generated
part 'prop_key_util_test_dart2.over_react.g.dart';

main() {
  group('(dart 2) getPropKey', () {
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
// ignore: undefined_identifier
UiFactory<TestProps> Test = _$Test;

@Props()
class _$TestProps extends UiProps {
  String foo;

  String bar;
}

@Component()
class TestComponent extends UiComponent<TestProps> {
  @override
  render() {}
}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class TestProps extends _$TestProps with _$TestPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = _$metaForTestProps;
}
