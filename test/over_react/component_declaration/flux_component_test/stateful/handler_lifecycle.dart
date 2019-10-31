// ignore_for_file: deprecated_member_use_from_same_package
part of over_react.component_declaration.flux_component_test;

@Factory()
UiFactory<TestStatefulHandlerLifecycleProps> TestStatefulHandlerLifecycle = _$TestStatefulHandlerLifecycle;

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

