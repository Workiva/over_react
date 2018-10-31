part of over_react.component_declaration.flux_component_test;

@Factory()
UiFactory<TestStoreHandlersProps> TestStatefulStoreHandlers;

@Props()
class TestStatefulStoreHandlersProps extends FluxUiProps<TestActions, TestStore> implements TestStoreHandlersProps {}

@State()
class TestStatefulStoreHandlersState extends UiState {}

@Component()
class TestStatefulStoreHandlersComponent extends FluxUiStatefulComponent<TestStatefulStoreHandlersProps, TestStatefulStoreHandlersState> {
  int numberOfHandlerCalls = 0;

  @override
  render() => Dom.div()();

  @override
  getStoreHandlers() => {props.store: increment};

  increment(Store store) {
    numberOfHandlerCalls += 1;
  }
}
