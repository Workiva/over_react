import 'package:over_react/over_react.dart';

class Fizz extends UiProps with FooPropsMixin,
// TODO: AF-#### This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class,undefined_class
$FooPropsMixin, BarPropsMixin, $BarPropsMixin {
  @override
  Map get props => null;
}

@PropsMixin()
abstract class FooPropsMixin {
  Map get props;
}

@PropsMixin()
abstract class BarPropsMixin {
  Map get props;
}
