part of over_react.component_declaration.flux_component_test;

@Factory()
UiFactory<TestPropValidationProps> TestPropValidation;

@Props()
class TestPropValidationProps extends FluxUiProps {
  @requiredProp
  String required;
}

@Component()
class TestPropValidationComponent extends FluxUiComponent<TestPropValidationProps> {
  int numberOfRedraws = 0;

  @override
  render() => Dom.div()();

  @override
  void setState(_, [callback()]) {
    numberOfRedraws++;
    if (callback != null) callback();
  }
}
