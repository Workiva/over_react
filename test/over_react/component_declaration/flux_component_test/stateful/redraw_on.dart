part of over_react.component_declaration.flux_component_test;

@Factory()
UiFactory<TestStatefulRedrawOnProps> TestStatefulRedrawOn;

@Props()
class TestStatefulRedrawOnProps extends FluxUiProps<TestActions, TestStores> implements TestRedrawOnProps {}

@State()
class TestStatefulRedrawOnState extends UiState {}

@Component()
class TestStatefulRedrawOnComponent extends FluxUiStatefulComponent<TestStatefulRedrawOnProps, TestStatefulRedrawOnState> {
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
