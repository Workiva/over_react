import 'package:over_react/over_react.dart';

// ignore: uri_has_not_been_generated
part 'foo_current_dart2only.over_react.g.dart';

@Factory()
// ignore: undefined_identifier
UiFactory<FooProps> Foo = $Foo;

@Props()
class _$FooProps extends UiProps {
  String foo;
}

@Component2()
class FooComponent extends UiComponent2<FooProps> {
  @override
  render() => [props.foo];
}
