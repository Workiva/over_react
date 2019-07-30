part of over_react.component_declaration.component2.flux_component_test;

@Factory()
UiFactory<TestStoreHandlersProps> TestStatefulStoreHandlers = _$TestStatefulStoreHandlers;

@Props()
class _$TestStatefulStoreHandlersProps extends FluxUiProps<TestActions, TestStore> implements TestStoreHandlersProps {}

@State()
class _$TestStatefulStoreHandlersState extends UiState {}

@Component2()
class TestStatefulStoreHandlersComponent extends FluxUiStatefulComponent2<TestStatefulStoreHandlersProps, TestStatefulStoreHandlersState> {
  int numberOfHandlerCalls = 0;

  @override
  render() => Dom.div()();

  @override
  getStoreHandlers() => {props.store: increment};

  increment(Store store) {
    numberOfHandlerCalls += 1;
  }
}

