part of over_react.component_declaration.redux_component_test;

@Factory()
UiFactory<TestConnectProps> TestConnect;

@Props()
class TestConnectProps
    extends ReduxUiProps<BaseState, BaseStateBuilder, BaseActions> {}

@Component()
class TestConnectComponent
    extends ReduxUiComponent<BaseState, BaseStateBuilder, BaseActions, TestConnectProps, int> {
  int numberOfRedraws = 0;

  @override
  render() => Dom.div()(connectedProps);

  @override
  int connect(BaseState state) => state.count1;

  @override
  void setState(_, [callback()]) {
    numberOfRedraws++;
    if (callback != null) callback();
  }
}
