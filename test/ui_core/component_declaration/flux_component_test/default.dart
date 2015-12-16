part of ui_core.comonent_declaration.flux_component_test;

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
