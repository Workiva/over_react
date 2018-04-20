part of over_react.component_declaration.flux_component_test;

@Factory()
UiFactory<TestRedrawOnProps> TestRedrawOn;

@Props()
class TestRedrawOnProps extends FluxUiProps<TestActions, TestStores> {}

@Component()
class TestRedrawOnComponent extends FluxUiComponent<TestRedrawOnProps> {
  int numberOfRedraws = 0;

  @override
  render() => Dom.div()();

  @override
  redrawOn() => [props.store.store1, props.store.store2];

  @override
  void setState(_, [Function callback]) {
    numberOfRedraws++;
    if (callback != null) callback();
  }
}
