import 'package:over_react/over_react.dart';

// ignore_for_file: uri_has_not_been_generated
import 'foo_new_2.over_react.g.dart' as $;
export 'foo_new_2.over_react.g.dart';

@Factory()
UiFactory<FooVerboseProps> Foo = $.foo;

@PropsMixin()
mixin FooVerbosePropsMixin on UiProps {
  @requiredProp
  int foo;
}

@Props()
class FooVerboseProps = UiProps with FooVerbosePropsMixin;

@Component2()
class FooComponent extends UiComponent2<FooVerboseProps> {
  @override
  render() => [props.foo];
}
