import 'package:over_react/over_react.dart';

part 'third_party_file.over_react.g.dart';

// Because you cannot use types from lazy loaded components until after you have imported them, this is the "workaround".
// I, keal jones, am not a fan.
@Props(keyNamespace: '')
mixin CounterPropsMixin on UiProps {
  num initialCount;
}

UiFactory<CounterPropsMixin> CounterPropsMapView = castUiFactory(_$CounterPropsMapView);
