import 'package:over_react/over_react.dart';

// ignore: uri_has_not_been_generated
part 'foo_current_dart2only.over_react.g.dart';

@Factory()
// ignore: undefined_identifier
UiFactory<FooCurrentProps> Foo = $Foo;

@Props()
class _$FooCurrentProps extends UiProps {
  String foo;
}

@Component2()
class FooComponent extends UiComponent2<FooCurrentProps> {
  @override
  render() => [props.foo];
}
