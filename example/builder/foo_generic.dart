import 'package:over_react/over_react.dart';

part 'foo_generic.g.dart';

// @Factory()
UiFactory<SuperProps> Super = $Super;

// @Props()
class SuperProps extends UiProps {
  String superProp;
}

// @Component()
abstract class SuperComponent<T extends SuperProps> extends UiComponent<T> {
  @override
  render() {
    return Dom.div()('Super', {
      'props.superProp': props.superProp,
//      'props': props.toString(),
    }.toString());
  }
}


// @Factory()
UiFactory<FooProps> Foo = $Foo;

// @Props()
// Heads up: props class inheritance doesn't work properly currently
class FooProps extends SuperProps {
  String fooProp;
}

// @Component()
class FooComponent extends SuperComponent<FooProps> {
  @override
  render() {
    return Dom.div()('Foo', {
      'props.fooProp': props.fooProp,
      'props.superProp': props.superProp,
//      'props': props.toString(),
    }.toString());
  }
}
