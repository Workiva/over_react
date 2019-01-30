part of over_react.component_declaration.redux_component_test;

@Factory()
// ignore: undefined_identifier
UiFactory<TestPureProps> TestPure = $TestPure;

@Props()
class _$TestPureProps extends BuiltReduxUiProps<BaseState, BaseStateBuilder, BaseActions> {}

@Component()
class TestPureComponent extends BuiltReduxUiComponent<BaseState, BaseStateBuilder, BaseActions, TestPureProps, BaseState> {
  int numberOfRedraws = 0;

  @override
  void componentDidUpdate(Map prevProps, Map prevState) {
    numberOfRedraws++;
  }

  @override
  bool get isPure => true;

  @override
  BaseState connect(BaseState state) => state;

  @override
  render() => Dom.div()();
}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class TestPureProps extends _$TestPureProps with _$TestPurePropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = $metaForTestPureProps;
}
