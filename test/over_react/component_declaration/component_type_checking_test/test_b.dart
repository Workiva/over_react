library test_component.test_b;

import 'package:over_react/ui_core.dart';

@Factory()
UiFactory<TestBProps> TestB;

@Props()
class TestBProps extends UiProps {}

@Component()
class TestBComponent extends UiComponent<TestBProps> {
  @override
  render() => Dom.div()();
}
