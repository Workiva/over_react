import 'package:over_react/over_react.dart';

//@Factory()
UiFactory<BarProps> Bar;

//@PropsMixin()
abstract class BarPropsMixin {
  Map get props;

  String barMixinProp;
}

//@Props()
class BarProps extends UiProps with BarPropsMixin,
    // ignore: mixin_of_non_class, undefined_class
    $BarPropsMixin {
  String barProp;
}

//@Component()
class BarComponent extends UiComponent<BarProps> {
  @override
  render() {
    return Dom.div()();
  }
}
