import 'package:over_react/over_react.dart';

part 'value_enum.over_react.g.dart';

// ignore: undefined_identifier
UiFactory<FooProps> Foo = _$Foo; // ignore: undefined_identifier

mixin FooProps on UiProps {
  @Enum({'foo', 'bar'})
  String value;

  @Enum.fromClassConstants(Color)
  String color;
}

class FooComponent extends UiComponent2<FooProps> {
  @override
  render() {}
}

abstract class Color {
  static const red = 'red';
  static const green = 'green';
  static const blue = 'blue';
}

render() {
  (Foo()..value = 'foo')();
  (Foo()..value = 'bar')();
  (Foo()..value = 'baz')();

  (Foo()..color = Color.red)();
  (Foo()..color = 'red')();
  (Foo()..color = 'violet')();
}

// This would live in over_react lib.
//
// Right now the analyzer plugins just looks for a matching annotation name
// with matching field names.
class Enum {
  const Enum(this.allowedValues) : classWithAllowedValues = null;

  const Enum.fromClassConstants(this.classWithAllowedValues)
      : allowedValues = null;

  final Set allowedValues;
  final Type classWithAllowedValues;
}
