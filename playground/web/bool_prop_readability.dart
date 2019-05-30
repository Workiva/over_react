import 'package:over_react/over_react.dart';

part 'bool_prop_readability.over_react.g.dart';

@Factory()
// ignore: undefined_identifier
UiFactory<BarProps> Bar = _$Bar;

@Props()
class _$BarProps extends UiProps {
  // Prefix
  bool isGoodPrefix;
  bool wasGoodPrefix;
  bool hasGoodPrefix;
  bool canGoodPrefix;
  bool shouldGoodPrefix;
  bool useGoodPrefix;
  bool checkGoodPrefix;
  bool showGoodPrefix;
  bool hideGoodPrefix;
  bool allowGoodPrefix;

  // Contains
  bool coolnessEnable;
  bool lamenessDisable;
  bool triggerIsAbleToClick;
  bool triggersAreAwesome;
  bool defaultChecked;
  bool propThatShouldSuppressSomething;
  bool needsToOpenOnClick;
  bool closeOnChange;
  bool renderAsSomethingCool;
  bool initiallyChecked;

  // lowercase
  bool grow; // isLowercase

  // Bad Props
  bool someOtherPropNameThatIsntObvious;
  bool forgetTheCheese; // Better Option: shouldForgetTheCheese
  bool jumpAround; // Better Option: canJumpAround or enableJumpAround
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
