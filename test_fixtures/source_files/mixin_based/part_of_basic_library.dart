part of basic.library;

UiFactory<BasicPartOfLibProps> BasicPartOfLib = _$BasicPartOfLib; // ignore: undefined_identifier

class BasicPartOfLibProps = UiProps with ExamplePropsMixin, BasicPartOfLibPropsMixin;
class BasicPartOfLibState = UiState with ExampleStateMixin, BasicPartOfLibStateMixin;

mixin BasicPartOfLibPropsMixin on UiProps, ExamplePropsMixin {
  String basicProp;
  String basic1;
  String basic2;
  String basic3;
  String basic4;
  String basic5;
}

mixin BasicPartOfLibStateMixin on UiState, ExampleStateMixin {
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
      'BasicPartOfLibComponentState: ${state.basicState}, ${state.stateMixin1}',
      Dom.div()('propsMeta: ${propsMeta.keys}'),
      Dom.div()('propsMeta for just ExamplePropsMixinClass: ${propsMeta.forMixin(ExamplePropsMixin).keys}'),
    );
  }
}
