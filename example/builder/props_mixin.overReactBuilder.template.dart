part of 'props_mixin.dart';
//
//abstract class $ExamplePropsMixinClassAccessorsMixin {
//  Map get props;
//
//  String get propMixin1 => props[_$key__propMixin1__ExamplePropsMixinClass];
//  set propMixin1(String value) => props[_$key__propMixin1__ExamplePropsMixinClass] = value;
//  /* GENERATED CONSTANTS */
//  static const PropDescriptor _$prop__propMixin1__ExamplePropsMixinClass = const PropDescriptor(_$key__propMixin1__ExamplePropsMixinClass);
//  static const String _$key__propMixin1__ExamplePropsMixinClass = 'ExamplePropsMixinClass.propMixin1';
//
//  static const List<PropDescriptor> $props = const [_$prop__propMixin1__ExamplePropsMixinClass];
//  static const List<String> $propKeys = const [_$key__propMixin1__ExamplePropsMixinClass];
//}

const PropsMeta $metaForExamplePropsMixinClass = const PropsMeta(
  fields: ExamplePropsMixinClass.$props,
  keys: ExamplePropsMixinClass.$propKeys,
);

abstract class ExamplePropsMixinClass implements _$ExamplePropsMixinClass {
  Map get props;

  String get propMixin1 => props[_$key__propMixin1__ExamplePropsMixinClass];
  set propMixin1(String value) => props[_$key__propMixin1__ExamplePropsMixinClass] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__propMixin1__ExamplePropsMixinClass = const PropDescriptor(_$key__propMixin1__ExamplePropsMixinClass);
  static const String _$key__propMixin1__ExamplePropsMixinClass = 'ExamplePropsMixinClass.propMixin1';

  static const List<PropDescriptor> $props = const [_$prop__propMixin1__ExamplePropsMixinClass];
  static const List<String> $propKeys = const [_$key__propMixin1__ExamplePropsMixinClass];
}
