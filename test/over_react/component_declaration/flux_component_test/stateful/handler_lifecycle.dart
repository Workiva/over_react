part of over_react.component_declaration.flux_component_test;

@Factory()
// ignore: undefined_identifier
UiFactory<TestStatefulHandlerLifecycleProps> TestStatefulHandlerLifecycle = $TestStatefulHandlerLifecycle;

@Props()
class _$TestStatefulHandlerLifecycleProps extends FluxUiProps<TestActions, TestStore> implements TestHandlerLifecycleProps {}

@State()
class _$TestStatefulHandlerLifecycleState extends UiState {}

@Component()
class TestStatefulHandlerLifecycleComponent extends FluxUiStatefulComponent<TestStatefulHandlerLifecycleProps, TestStatefulHandlerLifecycleState> {
  List<List<dynamic>> lifecycleCalls = [];

  @override
  void handleRedrawOn(Store store) {
    lifecycleCalls.add(['handleRedrawOn', store]);
    super.handleRedrawOn(store);
  }

  @override
  void listenToStoreForRedraw(Store store) {
    lifecycleCalls.add(['listenToStoreForRedraw', store]);
    super.listenToStoreForRedraw(store);
  }

  @override
  render() => Dom.div()();
}


// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class TestStatefulHandlerLifecycleProps extends _$TestStatefulHandlerLifecycleProps with _$TestStatefulHandlerLifecyclePropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = $metaForTestStatefulHandlerLifecycleProps;
}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class TestStatefulHandlerLifecycleState extends _$TestStatefulHandlerLifecycleState with _$TestStatefulHandlerLifecycleStateAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const StateMeta meta = $metaForTestStatefulHandlerLifecycleState;
}
