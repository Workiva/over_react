import 'package:over_react/over_react.dart';

@Factory()
UiFactory<FooProps> Foo;

@Props()
class FooProps extends UiProps with FooPropsMixin,
// TODO: AF-#### This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class,undefined_class
$FooPropsMixin, BarPropsMixin, $FizzPropsMixin, $BarPropsMixin {}

@State()
class FooState extends UiState with FooStateMixin,
// TODO: AF-#### This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class,undefined_class
$FooStateMixin {}

@Component()
class FooComponent {
  render() => null;
}

@PropsMixin()
abstract class FooPropsMixin {
  Map get props;
}

@PropsMixin()
abstract class BarPropsMixin {
  Map get props;
}

@PropsMixin()
abstract class $FizzPropsMixin {
  Map get props;
}

@StateMixin()
abstract class FooStateMixin {
  Map get state;
}
