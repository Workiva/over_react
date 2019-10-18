import 'package:over_react/over_react.dart';

// ignore_for_file: uri_has_not_been_generated
import 'props_mixin.over_react.g.dart' as $;
export 'props_mixin.over_react.g.dart';

@PropsMixin()
mixin ExamplePropsMixinClass on UiProps {
  @override
  Map get props;

  String propMixin1;
}

@PropsMixin()
mixin MixesInOtherMixinMixin<T extends Iterable, U>
    on ExamplePropsMixinClass {
  @override
  Map get props;

  String otherPropMixin;
}

