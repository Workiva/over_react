import 'package:over_react/over_react.dart';

part 'lazy_load_me_props.over_react.g.dart';

// Because you cannot use types from lazy loaded components until after you have imported them, this is the "workaround".
// I, keal jones, am not a fan.
@Props(keyNamespace: '')
mixin LazyLoadMePropsMixin on UiProps {
  num initialCount;
}

UiFactory<LazyLoadMePropsMixin> LazyLoadMePropsMapView = castUiFactory(_$LazyLoadMePropsMapView);
