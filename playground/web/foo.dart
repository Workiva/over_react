import 'package:over_react/over_react.dart';

part 'foo.over_react.g.dart';

UiFactory<FooProps> Foo = _$Foo; // ignore: undefined_identifier

mixin FooProps on UiProps {}

class FooComponent extends UiComponent2<FooProps> {
  @override
  render() {}
}

UiFactory<FooProps> Bar = _$Bar; // ignore: undefined_identifier

mixin BarProps on UiProps {}

class BarComponent extends UiComponent2<BarProps> {
  @override
  render() {}
}
