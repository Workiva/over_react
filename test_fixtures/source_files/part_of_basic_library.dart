part of basic.library;

@Factory()
UiFactory<BasicPartOfLibProps> BasicPartOfLib = _$BasicPartOfLib;

@Props()
class _$BasicPartOfLibProps extends UiProps
    with ExamplePropsMixinClass {

  /// Test that doc comment is copied over.
  String basicProp;
  String basic1;
  String basic2;
  String basic3;
  String basic4;
  String basic5;
}

@State()
class _$BasicPartOfLibState extends UiState
    with ExampleStateMixinClass, $ExampleStateMixinClass {

  String basicState;
}

@Component()
class BasicPartOfLibComponent extends UiStatefulComponent<BasicPartOfLibProps, BasicPartOfLibState> {
  @override
  Map getDefaultProps() => newProps()..id = 'BasicPartOfLib';

  @override
  Map getInitialState() => newState()..basicState = '<Basic state>'
      ..stateMixin1 = '<state mixin>';

  @override
  render() {
    return Dom.div()(
        'BasicPartOfLibComponentProps: ${props.basicProp}, ${props.propMixin1}',
        'BasicPartOfLibComponentState: ${state.basicState}, ${state.stateMixin1}');
  }
}
