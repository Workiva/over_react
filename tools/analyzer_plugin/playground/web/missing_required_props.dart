// @dart=2.7
// ^ Do not remove until migrated to null safety. More info at https://wiki.atl.workiva.net/pages/viewpage.action?pageId=189370832
import 'package:over_react/over_react.dart';

part 'missing_required_props.over_react.g.dart';

main() {
  final content = (Bar()
    ..bar = ''
//    ..barRequired = ''
  )();
}

UiFactory<BarProps> Bar = castUiFactory(_$Bar); // ignore: undefined_identifier

mixin BarProps on UiProps {
  @requiredProp
  String barRequired;

  /// yo yo
  String bar;
}

class BarComponent extends UiComponent2<BarProps> {
  @override
  render() => Dom.div()();
}
