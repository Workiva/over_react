part of 'props_mixin.dart';

abstract class $ExamplePropsMixinClass implements ExamplePropsMixinClass {
  @override  Map get props;

  @override
  String get propMixin1 => props[_$key__propMixin1__ExamplePropsMixinClass];
  @override
  set propMixin1(String value) => props[_$key__propMixin1__ExamplePropsMixinClass] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__propMixin1__ExamplePropsMixinClass = const PropDescriptor(_$key__propMixin1__ExamplePropsMixinClass);
  static const String _$key__propMixin1__ExamplePropsMixinClass = 'ExamplePropsMixinClass.propMixin1';

  static const List<PropDescriptor> $props = const [_$prop__propMixin1__ExamplePropsMixinClass];
  static const List<String> $propKeys = const [_$key__propMixin1__ExamplePropsMixinClass];
}

const PropsMeta $metaForExamplePropsMixinClass = const PropsMeta(
  fields: $ExamplePropsMixinClass.$props,
  keys: $ExamplePropsMixinClass.$propKeys,
);

abstract class $MixesInOtherMixinMixin implements MixesInOtherMixinMixin {
  @override  Map get props;

  @override
  String get otherPropMixin => props[_$key__otherPropMixin__MixesInOtherMixinMixin];
  @override
  set otherPropMixin(String value) => props[_$key__otherPropMixin__MixesInOtherMixinMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__otherPropMixin__MixesInOtherMixinMixin = const PropDescriptor(_$key__otherPropMixin__MixesInOtherMixinMixin);
  static const String _$key__otherPropMixin__MixesInOtherMixinMixin = 'MixesInOtherMixinMixin.otherPropMixin';

  static const List<PropDescriptor> $props = const [_$prop__otherPropMixin__MixesInOtherMixinMixin];
  static const List<String> $propKeys = const [_$key__otherPropMixin__MixesInOtherMixinMixin];
}

const PropsMeta $metaForMixesInOtherMixinMixin = const PropsMeta(
  fields: $MixesInOtherMixinMixin.$props,
  keys: $MixesInOtherMixinMixin.$propKeys,
);

