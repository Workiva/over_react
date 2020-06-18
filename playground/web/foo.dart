import 'package:over_react/over_react.dart';

part 'foo.over_react.g.dart';

UiFactory<FooPropsMixin> Foo = _$Foo; // ignore: undefined_identifier

mixin FooPropsMixin on UiProps {}

class FooComponent extends UiComponent2<FooPropsMixin> {
  @override
  Iterable<ConsumedProps> get consumedProps => [];

  @override
  render() {}
}

UiFactory<BarPropsMixin> Bar = _$Bar; // ignore: undefined_identifier

mixin BarPropsMixin on UiProps {}

class BarComponent extends UiComponent2<BarPropsMixin> {
  @override
  get consumedProps => [
    ...propsMeta.forMixins({FooPropsMixin, BarPropsMixin}),
    PropsMeta.forSimpleKey('_onChangePropKey'),
  ];

  @override
  render() {}
}

UiFactory<Foo2PropsMixin> Foo2 = _$Foo2; // ignore: undefined_identifier

mixin Foo2PropsMixin on UiProps {}

class Foo2Component extends UiComponent2<Foo2PropsMixin> {
  @override
  Iterable<ConsumedProps> get consumedProps => [
        propsMeta.forMixin(Foo2PropsMixin),
        propsMeta.forMixin(FooPropsMixin),
      ];

  @override
  render() {}
}
