import 'package:over_react/over_react.dart';
import 'package:test/test.dart';

import '../../../../test_util/test_util.dart';

part 'private_props_ddc_bug.over_react.g.dart';

main() {
  test('(New boilerplate) sets private props correctly in `getDefaultProps`', () {
    var instance = render((Foo())());

    expect(instance, isNotNull); // sanity check

    var node = findDomNode(instance);

    expect(node.text, contains('some private value'));
  });
}

UiFactory<FooProps> Foo = _$Foo;

mixin FooProps on UiProps {
  String _privateProp;
}

class FooComponent extends UiComponent2<FooProps> {
  @override
  Map get defaultProps => newProps().._privateProp = 'some private value';

  @override
  render() => (Dom.div())(props._privateProp);
}
