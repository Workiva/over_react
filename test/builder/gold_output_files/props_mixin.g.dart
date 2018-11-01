part of 'props_mixin.dart';

abstract class ExamplePropsMixinClass implements $ExamplePropsMixinClass {
  @override  Map get props;

  @override
  String get propMixin1 => props[_$key__propMixin1__$ExamplePropsMixinClass];
  @override
  set propMixin1(String value) => props[_$key__propMixin1__$ExamplePropsMixinClass] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__propMixin1__$ExamplePropsMixinClass = const PropDescriptor(_$key__propMixin1__$ExamplePropsMixinClass);
  static const String _$key__propMixin1__$ExamplePropsMixinClass = '\$ExamplePropsMixinClass.propMixin1';

  static const List<PropDescriptor> $props = const [_$prop__propMixin1__$ExamplePropsMixinClass];
  static const List<String> $propKeys = const [_$key__propMixin1__$ExamplePropsMixinClass];
}

const PropsMeta $metaFor$ExamplePropsMixinClass = const PropsMeta(
  fields: ExamplePropsMixinClass.$props,
  keys: ExamplePropsMixinClass.$propKeys,
);

