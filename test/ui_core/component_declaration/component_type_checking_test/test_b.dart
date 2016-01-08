library test_component.test_b;

import 'package:web_skin_dart/ui_core.dart';

@Factory()
UiFactory<TestBProps> TestB;

@Props()
class TestBProps extends UiProps {}

@Component()
class TestBComponent extends UiComponent<TestBProps> {
  @override
  render() => Dom.div()();
}
