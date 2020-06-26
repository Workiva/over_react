import 'package:over_react/over_react.dart';

part 'foo.over_react.g.dart';

UiFactory<FooProps> Foo = _$Foo; // ignore: undefined_identifier

mixin FooProps on UiProps {}

mixin FooState on UiState {}

class FooComponent extends UiStatefulComponent2<FooProps, FooState> {
  @override
  get defaultProps => (newProps());

  @override
  get initialState => (newState());

  @override
  render() {}
}

UiFactory<BarProps> Bar = _$Bar; // ignore: undefined_identifier

mixin BarPropsMixin on UiProps {}

class BarProps = UiProps with FluxUiPropsMixin, BarPropsMixin;

mixin BarState on UiState {}

class BarComponent extends FluxUiStatefulComponent2<BarProps, BarState> {
  @override
  get initialState => (newState());

  @override
  render() {}
}
