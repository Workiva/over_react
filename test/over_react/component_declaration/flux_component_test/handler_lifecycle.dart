// ignore_for_file: deprecated_member_use_from_same_package
part of over_react.component_declaration.flux_component_test;

@Factory()
UiFactory<TestHandlerLifecycleProps> TestHandlerLifecycle = _$TestHandlerLifecycle;

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

