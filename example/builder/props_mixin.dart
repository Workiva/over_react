import 'package:over_react/over_react.dart';

part 'props_mixin.overReactBuilder.g.dart';

@PropsMixin()
abstract class ExamplePropsMixinClass {
  // ignore: undefined_identifier, const_initialized_with_non_constant_value
  static const PropsMeta meta = $metaForReactPropsMixin;

  Map get props;

  String propMixin1;
}

