import 'package:over_react/over_react.dart';

part 'foo.over_react.g.dart';

UiFactory<FooProps> Foo = castUiFactory(_$Foo); // ignore: undefined_identifier

mixin FooProps on UiProps {}

class FooComponent extends UiComponent2<FooProps> {
  @override
  get defaultProps => (newProps());

  @override
  render() {}
}

UiFactory<BarProps> Bar = castUiFactory(_$Bar); // ignore: undefined_identifier

mixin BarPropsMixin on UiProps {}

class BarProps = UiProps with FluxUiPropsMixin, BarPropsMixin;

mixin BarState on UiState {}

class BarComponent extends FluxUiStatefulComponent2<BarProps, BarState> {
  @override
  get initialState => (newState());

  @override
  render() {}
}
