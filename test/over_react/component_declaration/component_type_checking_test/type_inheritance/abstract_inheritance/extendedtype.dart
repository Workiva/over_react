library test_component.type_inheritance.extendedtype;

import 'package:over_react/over_react.dart';

import './abstract.dart';

@Factory()
UiFactory<TestExtendtypeProps> TestExtendtype;

@Props()
class TestExtendtypeProps extends TestAbstractProps {}

@Component(subtypeOf: TestAbstractComponent)
class TestExtendtypeComponent extends TestAbstractComponent<TestExtendtypeProps> {
  @override
  render() => Dom.div()();
}
