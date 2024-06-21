// @dart=2.11
// This file is a non-null safe copy of playground examples to enable QAing backwards compatibility.
import 'package:over_react/over_react.dart';

import '../missing_required_props.dart';

part 'missing_required_props.over_react.g.dart';

main() {
  final content = (Bar()..bar = ''
//    ..barRequired = ''
  )();
}

UiFactory<BarProps> Bar = castUiFactory(_$Bar); // ignore: undefined_identifier

mixin BarPropsMixin on UiProps {
  @requiredProp
  String barRequired;

  /// yo yo
  String bar;
}

class BarProps = UiProps with BarPropsMixin, WithLateRequiredProps;

class BarComponent extends UiComponent2<BarProps> {
  @override
  render() => Dom.div()();
}
