import 'package:over_react/over_react.dart';

part 'props_mixin.overReactBuilder.template.dart';

@PropsMixin()
abstract class _$ExamplePropsMixinClass {
  // ignore: undefined_identifier, const_initialized_with_non_constant_value
  static const PropsMeta meta = $metaForReactPropsMixin;

  Map get props;

  String propMixin1;
}

