import 'package:over_react/over_react.dart';
import 'package:test/test.dart';

import '../../../../test_util/test_util.dart';

// ignore: uri_has_not_been_generated
part 'private_props_ddc_bug.over_react.g.dart';

main() {
  test('sets private props correctly in `getDefaultProps`', () {
    var instance = render((Foo())());

    expect(instance, isNotNull); // sanity check

    var node = findDomNode(instance);

    expect(node.text, contains('some private value'));
  });
}


@Factory()
// ignore: undefined_identifier
UiFactory<FooProps> Foo = _$Foo;

@Props()
class _$FooProps extends UiProps {
  String _privateProp;
}

@Component()
class FooComponent extends UiComponent<FooProps> {
  @override
  Map getDefaultProps() => newProps().._privateProp = 'some private value';

  @override
  render() => (Dom.div())(props._privateProp);
}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class FooProps extends _$FooProps with _$FooPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = _$metaForFooProps;
}
