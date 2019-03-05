part of over_react.component_declaration.redux_component_test;

@Factory()
UiFactory<TestConnectProps> TestConnect = _$TestConnect;

@Props()
class _$TestConnectProps
    extends BuiltReduxUiProps<BaseState, BaseStateBuilder, BaseActions> {}

@Component()
class TestConnectComponent
    extends BuiltReduxUiComponent<BaseState, BaseStateBuilder, BaseActions, TestConnectProps, int> {
  int numberOfRedraws = 0;

  @override
  void componentDidUpdate(Map prevProps, Map prevState) {
    numberOfRedraws++;
  }

  @override
  render() => Dom.div()(connectedState);

  @override
  int connect(BaseState state) => state.count1;
}

