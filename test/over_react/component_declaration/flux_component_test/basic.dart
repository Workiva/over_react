// ignore_for_file: deprecated_member_use_from_same_package
part of over_react.component_declaration.flux_component_test;

@Factory()
UiFactory<TestBasicProps> TestBasic = _$TestBasic;

@Props()
class _$TestBasicProps extends FluxUiProps {}

@Component()
class TestBasicComponent extends FluxUiComponent<TestBasicProps> {
  int numberOfRedraws = 0;

  @override
  render() => Dom.div()();

  @override
  void setState(_, [Function() callback]) {
    numberOfRedraws++;
    if (callback != null) callback();
  }
}

