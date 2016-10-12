library test_component.type_inheritance.abstract;

import 'package:over_react/over_react.dart';

@AbstractProps()
abstract class TestAbstractProps extends UiProps {}

var $TestAbstractComponentFactory = registerAbstractComponent(TestAbstractComponent);

@AbstractComponent()
abstract class TestAbstractComponent<T extends TestAbstractProps> extends UiComponent<T> {}
