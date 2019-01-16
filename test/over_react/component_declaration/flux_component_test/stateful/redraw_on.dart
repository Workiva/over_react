part of over_react.component_declaration.flux_component_test;

@Factory()
// ignore: undefined_identifier
UiFactory<TestStatefulRedrawOnProps> TestStatefulRedrawOn = _$TestStatefulRedrawOn;

@Props()
class _$TestStatefulRedrawOnProps extends FluxUiProps<TestActions, TestStores> implements TestRedrawOnProps {}

@State()
class _$TestStatefulRedrawOnState extends UiState {}

@Component()
class TestStatefulRedrawOnComponent extends FluxUiStatefulComponent<TestStatefulRedrawOnProps, TestStatefulRedrawOnState> {
  int numberOfRedraws = 0;

  @override
  render() => Dom.div()();

  @override
  redrawOn() => [props.store.store1, props.store.store2];

  @override
  void setState(_, [callback()]) {
    numberOfRedraws++;
    if (callback != null) callback();
  }
}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class TestStatefulRedrawOnProps extends _$TestStatefulRedrawOnProps with _$TestStatefulRedrawOnPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = _$metaForTestStatefulRedrawOnProps;
}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class TestStatefulRedrawOnState extends _$TestStatefulRedrawOnState with _$TestStatefulRedrawOnStateAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const StateMeta meta = _$metaForTestStatefulRedrawOnState;
}
