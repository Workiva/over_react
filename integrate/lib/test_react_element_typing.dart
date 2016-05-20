library test_react_element_typing;

import 'package:react/react_client.dart';

import './test_component_declaration.dart';

/// Verify that treating the invocation of the builder as an unparameterized [ReactElement]
/// does not result in the following analyzer warning:
/// > Unsound implicit cast from ReactElement<dynamic> to ReactElement<Component>
void _reactElementTypingTest() {
  ReactElement element = Foo()();
}
