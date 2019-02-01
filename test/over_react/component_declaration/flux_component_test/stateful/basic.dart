part of over_react.component_declaration.flux_component_test;

@Factory()
// ignore: undefined_identifier
UiFactory<TestStatefulBasicProps> TestStatefulBasic = _$TestStatefulBasic;

@Props()
class _$TestStatefulBasicProps extends FluxUiProps implements TestBasicProps {}

@State()
class _$TestStatefulBasicState extends UiState {}

@Component()
class TestStatefulBasicComponent extends FluxUiStatefulComponent<TestStatefulBasicProps, TestStatefulBasicState> {
  int numberOfRedraws = 0;

  @override
  render() => Dom.div()();

  @override
  void setState(_, [callback()]) {
    numberOfRedraws++;
    if (callback != null) callback();
  }
}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class TestStatefulBasicProps extends _$TestStatefulBasicProps with _$TestStatefulBasicPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = _$metaForTestStatefulBasicProps;
}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class TestStatefulBasicState extends _$TestStatefulBasicState with _$TestStatefulBasicStateAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const StateMeta meta = _$metaForTestStatefulBasicState;
}
