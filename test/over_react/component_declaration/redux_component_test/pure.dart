part of over_react.component_declaration.redux_component_test;

@Factory()
UiFactory<TestPureProps> TestPure = _$TestPure;

@Props()
class _$TestPureProps extends BuiltReduxUiProps<BaseState, BaseStateBuilder, BaseActions> {}

@Component()
class TestPureComponent extends BuiltReduxUiComponent<BaseState, BaseStateBuilder, BaseActions, TestPureProps, BaseState> {
  int numberOfRedraws = 0;

  @override
  void componentDidUpdate(Map prevProps, Map prevState) {
    numberOfRedraws++;
  }

  @override
  bool get isPure => true;

  @override
  BaseState connect(BaseState state) => state;

  @override
  render() => Dom.div()();
}

