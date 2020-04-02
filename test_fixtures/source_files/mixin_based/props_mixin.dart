import 'package:over_react/over_react.dart';

// ignore_for_file: uri_has_not_been_generated
part 'props_mixin.over_react.g.dart';

mixin ExamplePropsMixin on UiProps {
  String propMixin1;
}

mixin RequiresOtherMixinPropsMixin<T extends Iterable, U> on UiProps, ExamplePropsMixin {
  String otherPropMixin;
}
