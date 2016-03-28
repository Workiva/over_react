import 'package:web_skin_dart/ui_core.dart';

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
    return Dom.div()();
  }
}
