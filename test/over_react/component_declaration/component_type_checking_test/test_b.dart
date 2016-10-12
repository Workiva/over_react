library test_component.test_b;

import 'package:over_react/over_react.dart';

@Factory()
UiFactory<TestBProps> TestB;

@Props()
class TestBProps extends UiProps {}

@Component()
class TestBComponent extends UiComponent<TestBProps> {
  @override
  render() => Dom.div()();
}
