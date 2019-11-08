part of over_react.component_declaration.component2.flux_component_test;

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

@Component2()
class TestStatefulPropValidationComponent extends FluxUiStatefulComponent2<TestStatefulPropValidationProps, TestStatefulPropValidationState> {
  @override
  render() => Dom.div()();
}

