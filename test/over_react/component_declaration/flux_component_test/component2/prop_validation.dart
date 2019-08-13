part of over_react.component_declaration.component2.flux_component_test;

@Factory()
UiFactory<TestPropValidationProps> TestPropValidation = _$TestPropValidation;

@Props()
class _$TestPropValidationProps extends FluxUiProps {
  @requiredProp
  String required;
}

@Component2()
class TestPropValidationComponent extends FluxUiComponent2<TestPropValidationProps> {
  @override
  render() => Dom.div()();
}

