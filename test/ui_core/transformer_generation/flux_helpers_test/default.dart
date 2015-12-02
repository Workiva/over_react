part of ui_core.transformer_generation.w_flux_helpers_test;

@Factory()
UiFactory<TestDefaultProps> TestDefault;

@Props()
class TestDefaultProps extends FluxUiProps {}

@Component()
class TestDefaultComponent extends FluxUiComponent {
  int numberOfRedraws = 0;

  render() => Dom.div()();

  redraw() {
    numberOfRedraws += 1;
  }
}
