library test_component.type_inheritance.abstract;

import 'package:web_skin_dart/ui_core.dart';

@AbstractProps()
abstract class TestAbstractProps extends UiProps {}

var $TestAbstractComponentFactory = registerAbstractComponent(TestAbstractComponent);

@AbstractComponent()
abstract class TestAbstractComponent<T extends TestAbstractProps> extends UiComponent<T> {}
