part of over_react.component_declaration.component2.flux_component_test;

@Factory()
UiFactory<TestRedrawOnProps> TestRedrawOn = _$TestRedrawOn;

@Props()
class _$TestRedrawOnProps extends FluxUiProps<TestActions, TestStores> {}

@Component2()
class TestRedrawOnComponent extends FluxUiComponent2<TestRedrawOnProps> {
  int numberOfRedraws = 0;

  @override
  render() => Dom.div()();

  @override
  redrawOn() => [props.store.store1, props.store.store2];

  @override
  void setState(Map _, [Function() callback]) {
    numberOfRedraws++;
    if (callback != null) callback();
  }
}

