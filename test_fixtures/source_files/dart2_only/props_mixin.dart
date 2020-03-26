import 'package:over_react/over_react.dart';

part 'props_mixin.over_react.g.dart';

@PropsMixin()
abstract class _$ExamplePropsMixinClass implements UiProps {
  @override
  Map get props;

  String propMixin1;
}

@PropsMixin()
abstract class _$MixesInOtherMixinMixin<T extends Iterable, U>
    implements ExamplePropsMixinClass {
  @override
  Map get props;

  String otherPropMixin;
}

