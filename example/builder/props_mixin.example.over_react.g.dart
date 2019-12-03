// ignore_for_file: unnecessary_null_in_if_null_operators
import 'package:over_react/over_react.dart';

import 'props_mixin.dart';

mixin $ExamplePropsMixinClass implements ExamplePropsMixinClass {
  @override
  Map get props;

  static const PropsMeta meta = _$metaForExamplePropsMixinClass;

  @override String get propMixin1 => props[_$key__propMixin1___$ExamplePropsMixinClass] ?? null;
  @override set propMixin1(String value) => props[_$key__propMixin1___$ExamplePropsMixinClass] = value;

  static const _$prop__propMixin1___$ExamplePropsMixinClass =
      PropDescriptor(_$key__propMixin1___$ExamplePropsMixinClass);
  static const _$key__propMixin1___$ExamplePropsMixinClass = 'ExamplePropsMixinClass.propMixin1';

  static const List<PropDescriptor> $props = [_$prop__propMixin1___$ExamplePropsMixinClass];
  static const List<String> $propKeys = [_$key__propMixin1___$ExamplePropsMixinClass];
}

const PropsMeta _$metaForExamplePropsMixinClass = PropsMeta(
  fields: $ExamplePropsMixinClass.$props,
  keys: $ExamplePropsMixinClass.$propKeys,
);

mixin $MixesInOtherMixinMixin<T extends Iterable, U> implements MixesInOtherMixinMixin<T, U> {
  @override
  Map get props;

  static const PropsMeta meta = _$metaForMixesInOtherMixinMixin;

  @override String get otherPropMixin => props[_$key__otherPropMixin___$MixesInOtherMixinMixin] ?? null;
  @override set otherPropMixin(String value) => props[_$key__otherPropMixin___$MixesInOtherMixinMixin] = value;

  static const _$prop__otherPropMixin___$MixesInOtherMixinMixin =
      PropDescriptor(_$key__otherPropMixin___$MixesInOtherMixinMixin);
  static const _$key__otherPropMixin___$MixesInOtherMixinMixin = 'MixesInOtherMixinMixin.otherPropMixin';

  static const List<PropDescriptor> $props = [_$prop__otherPropMixin___$MixesInOtherMixinMixin];
  static const List<String> $propKeys = [_$key__otherPropMixin___$MixesInOtherMixinMixin];
}

const PropsMeta _$metaForMixesInOtherMixinMixin = PropsMeta(
  fields: $MixesInOtherMixinMixin.$props,
  keys: $MixesInOtherMixinMixin.$propKeys,
);
