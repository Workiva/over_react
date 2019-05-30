import 'package:over_react/over_react.dart';

part 'foo.over_react.g.dart';

@Factory()
// ignore: undefined_identifier
UiFactory<FooProps> Foo = _$Foo;

@Props()
class _$FooProps extends UiProps {}

// ignore: mixin_of_non_class, undefined_class
class FooProps extends _$FooProps with _$FooPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = _$metaForFooProps;
}

@Component()
class FooComponent extends UiComponent<FooProps> {
  @override
  render() {}
}
