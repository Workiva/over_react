part of over_react.component_declaration.redux_component_test;

@Factory()
UiFactory<TestDefaultProps> TestDefault;

@Props()
class TestDefaultProps extends ReduxUiProps {}

@Component()
class TestDefaultComponent extends ReduxUiComponent {
  int numberOfRedraws = 0;

  @override
  render() => Dom.div()();

  @override
  void setState(_, [callback()]) {
    print('here');
    numberOfRedraws++;
    if (callback != null) callback();
  }
}
