part of ui_core.transformer_generation.w_flux_helpers_test;

@Factory()
UiFactory<TestStoreHandlersProps> TestStoreHandlers;

@Props()
class TestStoreHandlersProps extends FluxUiProps<TestActions, TestStore> {}

@Component()
class TestStoreHandlersComponent extends FluxUiComponent {
  int numberOfHandlerCalls = 0;

  render() => Dom.div()();

  getStoreHandlers() => {props.store: increment};

  increment(_) {
    numberOfHandlerCalls += 1;
  }
}
