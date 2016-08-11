part of ui_core.comonent_declaration.flux_component_test;

@Factory()
UiFactory<TestRedrawOnProps> TestRedrawOn;

@Props()
class TestRedrawOnProps extends FluxUiProps<TestActions, TestStores> {}

@Component()
class TestRedrawOnComponent extends FluxUiComponent {
  int numberOfRedraws = 0;

  @override
  render() => Dom.div()();

  @override
  redrawOn() => [props.store.store1, props.store.store2];

  @override
  redraw([callback()]) {
    numberOfRedraws += 1;
  }
}
