library test_component.test_a;

import 'package:over_react/over_react.dart';

@Factory()
UiFactory<TestAProps> TestA;

@Props()
class TestAProps extends UiProps {}

@Component()
class TestAComponent extends UiComponent<TestAProps> {
  @override
  render() => Dom.div()();
}
