// ignore_for_file: deprecated_member_use

part of over_react.component_declaration.redux_component_test;

@Factory()
UiFactory<TestDefaultProps> TestDefault;

@Props()
class TestDefaultProps extends BuiltReduxUiProps<BaseState, BaseStateBuilder, BaseActions> {}

@Component()
class TestDefaultComponent extends BuiltReduxUiComponent<BaseState, BaseStateBuilder, BaseActions, TestDefaultProps, BaseState> {
  int numberOfRedraws = 0;

  @override
  void componentDidUpdate(Map prevProps, Map prevState) {
    numberOfRedraws++;
  }

  @override
  BaseState connect(BaseState state) => state;

  @override
  render() => Dom.div()();
}
