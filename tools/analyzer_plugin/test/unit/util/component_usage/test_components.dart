import 'package:over_react/over_react.dart';

part 'test_components.over_react.g.dart';

UiFactory<FooProps> Foo = _$Foo; // ignore: undefined_identifier, invalid_assignment

mixin FooProps on UiProps {}

class FooComponent extends UiComponent2<FooProps> {
  @override
  void render() {}
}

UiFactory<BarProps> Bar = _$Bar; // ignore: undefined_identifier, invalid_assignment

mixin BarProps on UiProps {}

class BarComponent extends UiComponent2<BarProps> {
  @override
  void render() {}
}

FooProps getFooBuilder() => Foo();

FooProps getBuilderForFoo() => Foo();
