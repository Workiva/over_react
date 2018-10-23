part of over_react.component_declaration.flux_component_test;

@Factory()
UiFactory<TestStatefulHandlerPrecedenceProps> TestStatefulHandlerPrecedence;

@Props()
class TestStatefulHandlerPrecedenceProps extends FluxUiProps<TestActions, TestStores> implements TestHandlerPrecedenceProps {}

@State()
class TestStatefulHandlerPrecedenceState extends UiState {}

@Component()
class TestStatefulHandlerPrecedenceComponent extends FluxUiStatefulComponent<TestStatefulHandlerPrecedenceProps, TestStatefulHandlerPrecedenceState> {
  int numberOfRedraws = 0;
  int numberOfHandlerCalls = 0;

  @override
  render() => Dom.div()();

  @override
  redrawOn() => [props.store.store1, props.store.store2];

  @override
  getStoreHandlers() => {props.store.store1: increment};

  increment(Store store) {
    numberOfHandlerCalls += 1;
  }

  @override
  void setState(_, [callback()]) {
    numberOfRedraws++;
    if (callback != null) callback();
  }
}
