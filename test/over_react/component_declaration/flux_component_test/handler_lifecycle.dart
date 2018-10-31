part of over_react.component_declaration.flux_component_test;

@Factory()
UiFactory<TestHandlerLifecycleProps> TestHandlerLifecycle;

@Props()
class TestHandlerLifecycleProps extends FluxUiProps<TestActions, TestStore> {}

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

