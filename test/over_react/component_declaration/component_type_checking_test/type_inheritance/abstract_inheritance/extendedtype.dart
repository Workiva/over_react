library test_component.type_inheritance.extendedtype;

import 'package:web_skin_dart/ui_core.dart';
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
