part of over_react.component_declaration.redux_component_test;

@Factory()
// ignore: undefined_identifier
UiFactory<TestDefaultProps> TestDefault = $TestDefault;

@Props()
class _$TestDefaultProps extends BuiltReduxUiProps<BaseState, BaseStateBuilder, BaseActions> {}

@Component()
class TestDefaultComponent extends BuiltReduxUiComponent<BaseState, BaseStateBuilder, BaseActions, TestDefaultProps, BaseState> {
  int numberOfRedraws = 0;

  @override
  void componentDidUpdate(Map prevProps, Map prevState) {
    numberOfRedraws++;
  }

  @override
  BaseState connect(BaseState state) => state;

  @override
  render() => Dom.div()();
}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class TestDefaultProps extends _$TestDefaultProps with _$TestDefaultPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = $metaForTestDefaultProps;
}
