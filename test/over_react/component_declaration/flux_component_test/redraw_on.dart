// ignore_for_file: deprecated_member_use_from_same_package
part of over_react.component_declaration.flux_component_test;

@Factory()
UiFactory<TestRedrawOnProps> TestRedrawOn = _$TestRedrawOn;

@Props()
class _$TestRedrawOnProps extends FluxUiProps<TestActions, TestStores> {}

@Component()
class TestRedrawOnComponent extends FluxUiComponent<TestRedrawOnProps> {
  int numberOfRedraws = 0;

  @override
  render() => Dom.div()();

  @override
  redrawOn() => [props.store.store1, props.store.store2];

  @override
  void setState(_, [Function() callback]) {
    numberOfRedraws++;
    if (callback != null) callback();
  }
}

