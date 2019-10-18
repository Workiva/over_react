import 'package:over_react/over_react.dart';

// ignore_for_file: uri_has_not_been_generated
import 'foo_new_terse.over_react.g.dart' as $;
export 'foo_new_terse.over_react.g.dart';

UiFactory<FooPropsMixin> Foo = $.foo;

mixin FooPropsMixin on UiProps {
  @requiredProp
  int foo;
}

class FooComponent extends UiComponent2<FooPropsMixin> {
  @override
  render() => [props.foo];
}













UiFactory<BarProps> Bar = $.Bar;

mixin BarPropsMixin on UiProps {
  int bar;
}

// optional, only when mixing in other classes
class BarProps = UiProps with FooPropsMixin, BarPropsMixin;

class BarComponent extends UiComponent2<BarProps> {
  @override
  render() => [props.foo];
}



UiFactory<BazProps> Baz = $.Baz;

mixin BazPropsMixin on UiProps, FooPropsMixin {
  int bar;
}

// optional, only when mixing in other classes
class BazProps = UiProps with FooPropsMixin, BazPropsMixin;

class BazComponent extends UiComponent2<BazProps> {
  @override
  render() => [props.foo];
}
