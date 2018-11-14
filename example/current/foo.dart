import 'package:over_react/over_react.dart';

//@Factory()
UiFactory<FooProps> Foo;

//@Props()
class FooProps extends UiProps {
  String fooProp;
}

//@Component()
class FooComponent extends UiComponent<FooProps> {
  @override
  render() {
    return Dom.div()();
  }
}
