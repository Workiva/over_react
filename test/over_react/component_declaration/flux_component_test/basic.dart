part of over_react.component_declaration.flux_component_test;

@Factory()
UiFactory<TestBasicProps> TestBasic;

@Props()
class TestBasicProps extends FluxUiProps {}

@Component()
class TestBasicComponent extends FluxUiComponent<TestBasicProps> {
  int numberOfRedraws = 0;

  @override
  render() => Dom.div()();

  @override
  void setState(_, [callback()]) {
    numberOfRedraws++;
    if (callback != null) callback();
  }
}
