part of over_react.component_declaration.flux_component_test;

@Factory()
// ignore: undefined_identifier
UiFactory<TestHandlerLifecycleProps> TestHandlerLifecycle = $TestHandlerLifecycle;

@Props()
class _$TestHandlerLifecycleProps extends FluxUiProps<TestActions, TestStore> {}

@Component()
class TestHandlerLifecycleComponent extends FluxUiComponent<TestHandlerLifecycleProps> {
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
class TestHandlerLifecycleProps extends _$TestHandlerLifecycleProps with _$TestHandlerLifecyclePropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = $metaForTestHandlerLifecycleProps;
}
