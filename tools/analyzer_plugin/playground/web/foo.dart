import 'package:over_react/over_react.dart';

part 'foo.over_react.g.dart';

UiFactory<FooProps> Foo = _$Foo; // ignore: undefined_identifier

mixin FooProps on UiProps {}

class FooComponent extends UiComponent2<FooProps> {
  @override
  render() {}

  void someFooishMethod() {}
  bool get isBar => false;
}
