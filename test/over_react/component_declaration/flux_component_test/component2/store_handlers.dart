part of over_react.component_declaration.component2.flux_component_test;

@Factory()
UiFactory<TestStoreHandlersProps> TestStoreHandlers = _$TestStoreHandlers;

@Props()
class _$TestStoreHandlersProps extends FluxUiProps<TestActions, TestStore> {}

@Component2()
class TestStoreHandlersComponent extends FluxUiComponent2<TestStoreHandlersProps> {
  int numberOfHandlerCalls = 0;

  @override
  render() => Dom.div()();

  @override
  getStoreHandlers() => {props.store: increment};

  increment(Store store) {
    numberOfHandlerCalls += 1;
  }
}

