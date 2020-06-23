import 'package:over_react/over_react.dart';

part 'bool_prop_readability.over_react.g.dart';

UiFactory<BarProps> Bar = _$Bar; // ignore: undefined_identifier

mixin BarProps on UiProps {
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

class BarComponent extends UiComponent2<BarProps> {
  @override
  render() => Dom.div()();
}
