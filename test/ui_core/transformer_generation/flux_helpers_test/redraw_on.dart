part of ui_core.transformer_generation.w_flux_helpers_test;

@Factory()
UiFactory<TestRedrawOnProps> TestRedrawOn;

@Props()
class TestRedrawOnProps extends FluxUiProps<TestActions, TestStores> {}

@Component()
class TestRedrawOnComponent extends FluxUiComponent {
  int numberOfRedraws = 0;

  render() => Dom.div()();

  redrawOn() => [props.store.store1, props.store.store2];

  redraw() {
    numberOfRedraws += 1;
  }
}
