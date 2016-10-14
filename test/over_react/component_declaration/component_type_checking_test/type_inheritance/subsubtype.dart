library test_component.type_inheritance.subsubtype;

import 'package:over_react/over_react.dart';

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
