part of over_react.component_declaration.flux_component_test;

@Factory()
UiFactory<TestStatefulPropValidationProps> TestStatefulPropValidation;

@Props()
class TestStatefulPropValidationProps extends FluxUiProps implements TestPropValidationProps {
  @override
  @requiredProp
  String required;
}

@Component()
class TestStatefulPropValidationComponent extends FluxUiComponent<TestStatefulPropValidationProps> {
  @override
  render() => Dom.div()();
}
