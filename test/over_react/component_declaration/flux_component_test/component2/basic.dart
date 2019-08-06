part of over_react.component_declaration.component2.flux_component_test;

@Factory()
UiFactory<TestBasicProps> TestBasic = _$TestBasic;

@Props()
class _$TestBasicProps extends FluxUiProps {}

@Component2()
class TestBasicComponent extends FluxUiComponent2<TestBasicProps> {
  int numberOfRedraws = 0;

  @override
  render() => Dom.div()();

  @override
  void setState(Map _, [callback()]) {
    numberOfRedraws++;
    if (callback != null) callback();
  }
}

