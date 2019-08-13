part of over_react.component_declaration.component2.flux_component_test;

@Factory()
UiFactory<TestHandlerLifecycleProps> TestHandlerLifecycle = _$TestHandlerLifecycle;

@Props()
class _$TestHandlerLifecycleProps extends FluxUiProps<TestActions, TestStore> {}

@Component2()
class TestHandlerLifecycleComponent extends FluxUiComponent2<TestHandlerLifecycleProps> {
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

