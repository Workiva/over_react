part of over_react.component_declaration.redux_component_test;

@Factory()
UiFactory<TestDefaultProps> TestDefault;

@Props()
class TestDefaultProps extends BuiltReduxUiProps<BaseState, BaseStateBuilder, BaseActions> {}

@Component()
class TestDefaultComponent extends BuiltReduxUiComponent<BaseState, BaseStateBuilder, BaseActions, TestDefaultProps, BaseState> {
  int numberOfRedraws = 0;

  @override
  BaseState connect(BaseState state) => state;

  @override
  render() => Dom.div()();

  @override
  void setState(_, [callback()]) {
    numberOfRedraws++;
    if (callback != null) callback();
  }
}
