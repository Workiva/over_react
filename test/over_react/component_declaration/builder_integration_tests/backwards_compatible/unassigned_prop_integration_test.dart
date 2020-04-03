@TestOn('browser')

// ignore_for_file: deprecated_member_use_from_same_package
import 'package:over_react/over_react.dart';
import 'package:test/test.dart';

import '../../../../test_util/test_util.dart';

part 'unassigned_prop_integration_test.over_react.g.dart';

main() {
  test('renders all children, even with unassigned props present', () {
    var instance = render((Foo()
      ..stringProp = 'some string value'
    )());

    expect(instance, isNotNull); // sanity check

    var node = findDomNode(instance);

    // This tests a workaround added to impl_generation.dart to add ` ?? null;` to the getters
    // for props/state members. Details: <https://github.com/dart-lang/sdk/issues/36052>
    // without this workaround, this test would fail when compiled via DDC.
    expect(node.text, contains('some string value'));
  });
}


@Factory()
// ignore: undefined_identifier
UiFactory<FooProps> Foo = _$Foo;

@Props()
class _$FooProps extends UiProps {
  String stringProp;
  String unassignedProp;
}

@Component()
class FooComponent extends UiComponent<FooProps> {
  @override
  Map getDefaultProps() => newProps()..id = 'testId';

  @override
  render() => (Dom.div())(props.unassignedProp, props.stringProp);
}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class FooProps extends _$FooProps with _$FooPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = _$metaForFooProps;
}
