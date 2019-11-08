part of over_react.component_declaration.component2.flux_component_test;

@Factory()
UiFactory<TestStatefulBasicProps> TestStatefulBasic = _$TestStatefulBasic;

@Props()
class _$TestStatefulBasicProps extends FluxUiProps implements TestBasicProps {}

@State()
class _$TestStatefulBasicState extends UiState {}

@Component2()
class TestStatefulBasicComponent extends FluxUiStatefulComponent2<TestStatefulBasicProps, TestStatefulBasicState> {
  int numberOfRedraws = 0;

  @override
  render() => Dom.div()();

  @override
  void setState(Map _, [Function() callback]) {
    numberOfRedraws++;
    if (callback != null) callback();
  }
}

