import 'package:over_react/over_react.dart';

part 'props_mixin.over_react.g.dart';

@PropsMixin()
abstract class ExamplePropsMixinClass implements UiProps {
  @override
  Map get props;

  static const PropsMeta meta = _$metaForExamplePropsMixinClass;

  String propMixin1;
}

@PropsMixin()
abstract class MixesInOtherMixinMixin
    implements ExamplePropsMixinClass {
  @override
  Map get props;

  static const PropsMeta meta = _$metaForMixesInOtherMixinMixin;

  String otherPropMixin;
}

