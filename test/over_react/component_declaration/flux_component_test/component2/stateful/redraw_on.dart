part of over_react.component_declaration.component2.flux_component_test;

@Factory()
UiFactory<TestStatefulRedrawOnProps> TestStatefulRedrawOn = _$TestStatefulRedrawOn;

@Props()
class _$TestStatefulRedrawOnProps extends FluxUiProps<TestActions, TestStores> implements TestRedrawOnProps {}

@State()
class _$TestStatefulRedrawOnState extends UiState {}

@Component2()
class TestStatefulRedrawOnComponent extends FluxUiStatefulComponent2<TestStatefulRedrawOnProps, TestStatefulRedrawOnState> {
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

