part of over_react.component_declaration.flux_component_test;

@Factory()
UiFactory<TestStatefulRedrawOnProps> TestStatefulRedrawOn;

@Props()
class TestStatefulRedrawOnProps extends FluxUiProps<TestActions, TestStores> implements TestRedrawOnProps {}

@Component()
class TestStatefulRedrawOnComponent extends FluxUiComponent<TestStatefulRedrawOnProps> {
  int numberOfRedraws = 0;

  @override
  render() => Dom.div()();

  @override
  redrawOn() => [props.store.store1, props.store.store2];

  @override
  void setState(_, [callback()]) {
    numberOfRedraws++;
    if (callback != null) callback();
  }
}
