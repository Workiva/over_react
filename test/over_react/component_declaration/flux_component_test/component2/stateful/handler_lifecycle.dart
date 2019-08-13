part of over_react.component_declaration.component2.flux_component_test;

@Factory()
UiFactory<TestStatefulHandlerLifecycleProps> TestStatefulHandlerLifecycle = _$TestStatefulHandlerLifecycle;

@Props()
class _$TestStatefulHandlerLifecycleProps extends FluxUiProps<TestActions, TestStore> implements TestHandlerLifecycleProps {}

@State()
class _$TestStatefulHandlerLifecycleState extends UiState {}

@Component2()
class TestStatefulHandlerLifecycleComponent extends FluxUiStatefulComponent2<TestStatefulHandlerLifecycleProps, TestStatefulHandlerLifecycleState> {
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

