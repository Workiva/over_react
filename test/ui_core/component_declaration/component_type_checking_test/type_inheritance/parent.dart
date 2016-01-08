library test_component.type_inheritance.parent;

import 'package:web_skin_dart/ui_core.dart';

@Factory()
UiFactory<TestParentProps> TestParent;

@Props()
class TestParentProps extends UiProps {}

@Component()
class TestParentComponent extends UiComponent<TestParentProps> {
  @override
  render() => Dom.div()();
}
