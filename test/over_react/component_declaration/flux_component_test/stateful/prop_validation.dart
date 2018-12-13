part of over_react.component_declaration.flux_component_test;

@Factory()
// ignore: undefined_identifier
UiFactory<TestStatefulPropValidationProps> TestStatefulPropValidation = $TestStatefulPropValidation;

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

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class TestStatefulPropValidationProps extends _$TestStatefulPropValidationProps with _$TestStatefulPropValidationPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = $metaForTestStatefulPropValidationProps;
}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class TestStatefulPropValidationState extends _$TestStatefulPropValidationState with _$TestStatefulPropValidationStateAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const StateMeta meta = $metaForTestStatefulPropValidationState;
}
