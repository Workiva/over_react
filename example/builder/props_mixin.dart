import 'package:over_react/over_react.dart';

import 'props_mixin.overReactBuilder.g.dart';

@PropsMixin()
abstract class ExamplePropsMixinClass {
  // ignore: undefined_identifier, const_initialized_with_non_constant_value
  static const PropsMeta meta = $metaForExamplePropsMixinClass;

  Map get props;

  String propMixin1;
}

