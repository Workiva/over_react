part of over_react.component_declaration.redux_component_test;

@Factory()
UiFactory<TestRedrawOnProps> TestRedrawOn;

@Props()
class TestRedrawOnProps extends ReduxUiProps {}

@Component()
class TestRedrawOnComponent extends ReduxUiComponent<TestRedrawOnProps> {
  int numberOfRedraws = 0;

  @override
  render() => Dom.div()();

  @override
  redrawOn() => [props.store.stream, props.store.state.store1.stream, props.store.state.store2.stream];

  @override
  void setState(_, [callback()]) {
    numberOfRedraws++;
    if (callback != null) callback();
  }
}
