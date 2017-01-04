library test_component.type_inheritance.subsubtype;

import 'package:web_skin_dart/ui_core.dart';
import './subtype.dart';

@Factory()
UiFactory<TestSubsubtypeProps> TestSubsubtype;

@Props()
class TestSubsubtypeProps extends UiProps {}

@Component(subtypeOf: TestSubtypeComponent)
class TestSubsubtypeComponent extends UiComponent<TestSubsubtypeProps> {
  @override
  render() => Dom.div()();
}
