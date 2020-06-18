import 'package:over_react/over_react.dart';

part 'consumed_props_usage.over_react.g.dart';

UiFactory<ConsumedPropsExample1PropsMixin> ConsumedPropsExample1 =
    _$ConsumedPropsExample1; // ignore: undefined_identifier

mixin ConsumedPropsExample1PropsMixin on UiProps {}

class ConsumedPropsExample1Component
    extends UiComponent2<ConsumedPropsExample1PropsMixin> {
  // This should have a lint.
  @override
  get consumedProps => [
        propsMeta.forMixin(ConsumedPropsExample1PropsMixin),
        propsMeta.forMixin(ConsumedPropsExample2PropsMixin),
      ];

  @override
  render() {}
}

UiFactory<ConsumedPropsExample2PropsMixin> ConsumedPropsExample2 =
    _$ConsumedPropsExample2; // ignore: undefined_identifier

mixin ConsumedPropsExample2PropsMixin on UiProps {}

class ConsumedPropsExample2Component
    extends UiComponent2<ConsumedPropsExample2PropsMixin> {
  // This should not have a lint.
  @override
  get consumedProps => [];

  @override
  render() {}
}

UiFactory<ConsumedPropsExample3PropsMixin> ConsumedPropsExample3 =
    _$ConsumedPropsExample3; // ignore: undefined_identifier

mixin ConsumedPropsExample3PropsMixin on UiProps {}

class ConsumedPropsExample3Component
    extends UiComponent2<ConsumedPropsExample3PropsMixin> {
  // This should not have a lint.
  @override
  get consumedProps => [
        ...propsMeta.forMixins(
            {ConsumedPropsExample2PropsMixin, ConsumedPropsExample3PropsMixin}),
        PropsMeta.forSimpleKey('_onChangePropKey'),
      ];

  @override
  render() {}
}
