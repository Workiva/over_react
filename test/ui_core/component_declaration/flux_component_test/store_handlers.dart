part of ui_core.comonent_declaration.flux_component_test;

@Factory()
UiFactory<TestStoreHandlersProps> TestStoreHandlers;

@Props()
class TestStoreHandlersProps extends FluxUiProps<TestActions, TestStore> {}

@Component()
class TestStoreHandlersComponent extends FluxUiComponent {
  int numberOfHandlerCalls = 0;

  @override
  render() => Dom.div()();

  @override
  getStoreHandlers() => {props.store: increment};

  increment(_) {
    numberOfHandlerCalls += 1;
  }
}
