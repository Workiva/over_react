// ignore_for_file: deprecated_member_use_from_same_package
part of over_react.component_declaration.flux_component_test;

@Factory()
UiFactory<TestPropValidationProps> TestPropValidation = _$TestPropValidation;

@Props()
class _$TestPropValidationProps extends FluxUiProps {
  @requiredProp
  String required;
}

@Component()
class TestPropValidationComponent extends FluxUiComponent<TestPropValidationProps> {
  @override
  render() => Dom.div()();
}

