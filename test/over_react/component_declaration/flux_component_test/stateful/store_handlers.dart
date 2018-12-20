part of over_react.component_declaration.flux_component_test;

@Factory()
// ignore: undefined_identifier
UiFactory<TestStoreHandlersProps> TestStatefulStoreHandlers = $TestStatefulStoreHandlers;

@Props()
class _$TestStatefulStoreHandlersProps extends FluxUiProps<TestActions, TestStore> implements TestStoreHandlersProps {}

@State()
class _$TestStatefulStoreHandlersState extends UiState {}

@Component()
class TestStatefulStoreHandlersComponent extends FluxUiStatefulComponent<TestStatefulStoreHandlersProps, TestStatefulStoreHandlersState> {
  int numberOfHandlerCalls = 0;

  @override
  render() => Dom.div()();

  @override
  getStoreHandlers() => {props.store: increment};

  increment(Store store) {
    numberOfHandlerCalls += 1;
  }
}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class TestStatefulStoreHandlersProps extends _$TestStatefulStoreHandlersProps with _$TestStatefulStoreHandlersPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = $metaForTestStatefulStoreHandlersProps;
}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class TestStatefulStoreHandlersState extends _$TestStatefulStoreHandlersState with _$TestStatefulStoreHandlersStateAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const StateMeta meta = $metaForTestStatefulStoreHandlersState;
}
