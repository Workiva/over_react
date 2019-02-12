part of over_react.component_declaration.flux_component_test;

@Factory()
UiFactory<TestStatefulPropValidationProps> TestStatefulPropValidation = _$TestStatefulPropValidation;

@Props()
class _$TestStatefulPropValidationProps extends FluxUiProps implements TestPropValidationProps {
  @override
  @requiredProp
  String required;
}

@State()
class _$TestStatefulPropValidationState extends UiState {}

@Component()
class TestStatefulPropValidationComponent extends FluxUiStatefulComponent<TestStatefulPropValidationProps, TestStatefulPropValidationState> {
  @override
  render() => Dom.div()();
}

