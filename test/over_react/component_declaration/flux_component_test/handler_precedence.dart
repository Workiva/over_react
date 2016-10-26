part of over_react.component_declaration.flux_component_test;

@Factory()
UiFactory<TestHandlerPrecedenceProps> TestHandlerPrecedence;

@Props()
class TestHandlerPrecedenceProps extends FluxUiProps<TestActions, TestStores> {}

@Component()
class TestHandlerPrecedenceComponent extends FluxUiComponent {
  int numberOfRedraws = 0;
  int numberOfHandlerCalls = 0;

  @override
  render() => Dom.div()();

  @override
  redrawOn() => [props.store.store1, props.store.store2];

  @override
  getStoreHandlers() => {props.store.store1: increment};

  increment(_) {
    numberOfHandlerCalls += 1;
  }

  @override
  void setState(_, [callback()]) {
    numberOfRedraws++;
    if (callback != null) callback();
  }
}
