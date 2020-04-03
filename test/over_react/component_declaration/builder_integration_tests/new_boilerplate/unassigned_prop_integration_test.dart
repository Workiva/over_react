import 'package:over_react/over_react.dart';
import 'package:test/test.dart';

import '../../../../test_util/test_util.dart';

part 'unassigned_prop_integration_test.over_react.g.dart';

main() {
  test('(New boilerplate) renders all children, even with unassigned props present', () {
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

UiFactory<FooProps> Foo = _$Foo;

mixin FooProps on UiProps {
  String stringProp;
  String unassignedProp;
}

class FooComponent extends UiComponent2<FooProps> {
  @override
  // ignore: must_call_super
  Map getDefaultProps() => newProps()..id = 'testId';

  @override
  render() => (Dom.div())(props.unassignedProp, props.stringProp);
}
