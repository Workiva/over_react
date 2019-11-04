// ignore_for_file: deprecated_member_use_from_same_package
part of over_react.component_declaration.flux_component_test;

@Factory()
UiFactory<TestStoreHandlersProps> TestStatefulStoreHandlers = _$TestStatefulStoreHandlers;

@Props()
class _$TestStatefulStoreHandlersProps extends FluxUiProps<TestActions, TestStore> implements TestStoreHandlersProps {}

@State()
class _$TestStatefulStoreHandlersState extends UiState {}

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

