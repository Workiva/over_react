part of over_react.component_declaration.flux_component_test;

@Factory()
UiFactory<TestStatefulBasicProps> TestStatefulBasic;

@Props()
class TestStatefulBasicProps extends FluxUiProps implements TestBasicProps {}

@State()
class TestStatefulBasicState extends UiState {}

@Component()
class TestStatefulBasicComponent extends FluxUiStatefulComponent<TestStatefulBasicProps, TestStatefulBasicState> {
  int numberOfRedraws = 0;

  @override
  render() => Dom.div()();

  @override
  void setState(_, [callback()]) {
    numberOfRedraws++;
    if (callback != null) callback();
  }
}
