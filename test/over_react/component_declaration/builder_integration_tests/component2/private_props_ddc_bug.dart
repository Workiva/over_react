import 'package:over_react/over_react.dart';
import 'package:test/test.dart';

import '../../../../test_util/test_util.dart';

part 'private_props_ddc_bug.over_react.g.dart';

main() {
  test('(Component2) sets private props correctly in `getDefaultProps`', () {
    var instance = render((Foo())());

    expect(instance, isNotNull); // sanity check

    var node = findDomNode(instance);

    expect(node.text, contains('some private value'));
  });
}


@Factory()
UiFactory<FooProps> Foo = _$Foo;

@Props()
class _$FooProps extends UiProps {
  String _privateProp;
}

@Component2()
class FooComponent extends UiComponent2<FooProps> {
  @override
  Map getDefaultProps() => newProps().._privateProp = 'some private value';

  @override
  render() => (Dom.div())(props._privateProp);
}
