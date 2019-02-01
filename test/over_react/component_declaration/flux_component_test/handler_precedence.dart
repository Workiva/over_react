part of over_react.component_declaration.flux_component_test;

@Factory()
// ignore: undefined_identifier
UiFactory<TestHandlerPrecedenceProps> TestHandlerPrecedence = _$TestHandlerPrecedence;

@Props()
class _$TestHandlerPrecedenceProps extends FluxUiProps<TestActions, TestStores> {}

@Component()
class TestHandlerPrecedenceComponent extends FluxUiComponent<TestHandlerPrecedenceProps> {
  int numberOfRedraws = 0;
  int numberOfHandlerCalls = 0;

  @override
  render() => Dom.div()();

  @override
  redrawOn() => [props.store.store1, props.store.store2];

  @override
  getStoreHandlers() => {props.store.store1: increment};

  increment(Store store) {
    numberOfHandlerCalls += 1;
  }

  @override
  void setState(_, [callback()]) {
    numberOfRedraws++;
    if (callback != null) callback();
  }
}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class TestHandlerPrecedenceProps extends _$TestHandlerPrecedenceProps with _$TestHandlerPrecedencePropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = _$metaForTestHandlerPrecedenceProps;
}
