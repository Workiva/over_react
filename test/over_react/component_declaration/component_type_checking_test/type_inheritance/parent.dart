library test_component.type_inheritance.parent;

import 'package:over_react/over_react.dart';

@Factory()
UiFactory<TestParentProps> TestParent;

@Props()
class TestParentProps extends UiProps {}

@Component()
class TestParentComponent extends UiComponent<TestParentProps> {
  @override
  render() => Dom.div()();
}
