part of over_react.component_declaration.redux_component_test;

@Factory()
// ignore: undefined_identifier
UiFactory<TestConnectProps> TestConnect = _$TestConnect;

@Props()
class _$TestConnectProps
    extends BuiltReduxUiProps<BaseState, BaseStateBuilder, BaseActions> {}

@Component()
class TestConnectComponent
    extends BuiltReduxUiComponent<BaseState, BaseStateBuilder, BaseActions, TestConnectProps, int> {
  int numberOfRedraws = 0;

  @override
  void componentDidUpdate(Map prevProps, Map prevState) {
    numberOfRedraws++;
  }

  @override
  render() => Dom.div()(connectedState);

  @override
  int connect(BaseState state) => state.count1;
}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class TestConnectProps extends _$TestConnectProps with _$TestConnectPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = _$metaForTestConnectProps;
}
