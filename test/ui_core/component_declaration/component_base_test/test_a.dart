library test_component.test_a;

import 'package:web_skin_dart/ui_core.dart';

@Factory()
UiFactory<TestAProps> TestA;

@Props()
class TestAProps extends UiProps {}

@Component()
class TestAComponent extends UiComponent<TestAProps> {
  @override
  render() => Dom.div()();
}
