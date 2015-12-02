part of ui_core.transformer_generation.w_flux_helpers_test;

@Factory()
UiFactory<TestHandlerPrecedenceProps> TestHandlerPrecedence;

@Props()
class TestHandlerPrecedenceProps extends FluxUiProps<TestActions, TestStores> {}

@Component()
class TestHandlerPrecedenceComponent extends FluxUiComponent {
  int numberOfRedraws = 0;
  int numberOfHandlerCalls = 0;

  render() => Dom.div()();

  redrawOn() => [props.store.store1, props.store.store2];

  getStoreHandlers() => {props.store.store1: increment};

  increment(_) {
    numberOfHandlerCalls += 1;
  }

  redraw() {
    numberOfRedraws += 1;
  }
}
