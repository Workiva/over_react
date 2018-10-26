import 'package:over_react/over_react.dart';

part 'props_mixin.overReactBuilder.g.dart';

// ignore: mixin_of_non_class,undefined_class, implements_non_class
abstract class ExamplePropsMixinClass implements _$$ExamplePropsMixinClass {
  // ignore: undefined_identifier, const_initialized_with_non_constant_value
  static const PropsMeta meta = $metaForReactPropsMixin;
}

@PropsMixin()
abstract class _$ExamplePropsMixinClass implements UiProps {
  Map get props;

  String propMixin1;
}

