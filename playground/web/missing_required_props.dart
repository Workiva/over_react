import 'package:over_react/over_react.dart';

part 'missing_required_props.over_react.g.dart';

main() {
  final content = (Bar()
    ..bar = ''
//    ..barRequired = ''
  )();
}


@Factory()
// ignore: undefined_identifier
UiFactory<BarProps> Bar = _$Bar;

@Props()
class _$BarProps extends UiProps {
  @requiredProp
  String barRequired;

  /// yo yo
  String bar;
}

// ignore: mixin_of_non_class, undefined_class
class BarProps extends _$BarProps with _$BarPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = _$metaForBarProps;
}

@Component()
class BarComponent extends UiComponent<BarProps> {
  @override
  render() => Dom.div()();
}
