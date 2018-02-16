// ignore_for_file: deprecated_member_use

part of over_react.component_declaration.redux_component_test;

@Factory()
UiFactory<TestPureProps> TestPure;

@Props()
class TestPureProps extends BuiltReduxUiProps<BaseState, BaseStateBuilder, BaseActions> {}

@Component()
class TestPureComponent extends BuiltReduxUiComponent<BaseState, BaseStateBuilder, BaseActions, TestPureProps, BaseState> {
  int numberOfRedraws = 0;

  @override
  bool get isPure => true;

  @override
  BaseState connect(BaseState state) => state;

  @override
  render() => Dom.div()();

  @override
  void setState(_, [callback()]) {
    numberOfRedraws++;
    if (callback != null) callback();
  }
}
