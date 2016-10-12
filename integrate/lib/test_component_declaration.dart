library test_component_declaration;

import 'package:over_react/ui_core.dart';
import 'package:over_react/ui_components.dart';

@Factory()
UiFactory<FooProps> Foo;

@Props()
class FooProps extends UiProps {}

@State()
class FooState extends UiState {}

@Component()
class FooComponent extends UiStatefulComponent<FooProps, FooState> {
  @override
  render() {
    return Button()(
      'Child 1',
      'Child 2'
    );
  }
}
