part of over_react.component_declaration.flux_component_test;

@Factory()
// ignore: undefined_identifier
UiFactory<TestPropValidationProps> TestPropValidation = $TestPropValidation;

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

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class TestPropValidationProps extends _$TestPropValidationProps with _$TestPropValidationPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = $metaForTestPropValidationProps;
}
