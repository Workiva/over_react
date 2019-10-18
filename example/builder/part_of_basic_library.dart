part of basic.library;

UiFactory<BasicPartOfLibProps> BasicPartOfLib = $.BasicPartOfLib;

class BasicPartOfLibProps = UiProps with ExamplePropsMixinClass, BasicPartOfLibPropsMixin;
class BasicPartOfLibState = UiState with ExampleStateMixinClass, BasicPartOfLibStateMixin;

mixin BasicPartOfLibPropsMixin on UiProps, ExamplePropsMixinClass {
  String basicProp;
  String basic1;
  String basic2;
  String basic3;
  String basic4;
  String basic5;
}

mixin BasicPartOfLibStateMixin on UiState, ExampleStateMixinClass {
  String basicState;
}

class BasicPartOfLibComponent extends UiStatefulComponent2<BasicPartOfLibProps, BasicPartOfLibState> {
  @override
  get defaultProps => newProps()..id = 'BasicPartOfLib';

  @override
  get initialState => newState()..basicState = '<Basic state>'
      ..stateMixin1 = '<state mixin>';

  @override
  render() {
    return Dom.div()(
        'BasicPartOfLibComponentProps: ${props.basicProp}, ${props.propMixin1}',
        'BasicPartOfLibComponentState: ${state.basicState}, ${state.stateMixin1}');
  }
}
