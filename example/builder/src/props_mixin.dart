import 'package:over_react/over_react.dart';

// ignore_for_file: uri_has_not_been_generated
part 'props_mixin.over_react.g.dart';

mixin ExamplePropsMixin on UiProps {
  @override
  Map get props;

  String propMixin1;
}

mixin MixesInOtherMixinPropsMixin<T extends Iterable, U>
    on ExamplePropsMixin {
  @override
  Map get props;

  String otherPropMixin;
}

