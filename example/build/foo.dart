import 'package:over_react/over_react.dart';

part 'foo.g.dart';

@Factory()
UiFactory<FooProps> Foo = $Foo;

@Props()
class FooProps extends UiProps {
  String fooProp;
}

@Component()
class FooComponent extends UiComponent<FooProps> {
  // If you *really* need a constructor, do something like this.
  // Using constructors makes things more complicated:
  // - since you need the default constructor for the impl to call as well as a different named factory constructor
  // - when this class has generic props, the impl has a typedPropsFactory that doesn't meet those (need to check that the current is kosher in DDC)
  static _$FooComponentImpl construct() => new _$FooComponentImpl();

  @override
  render() {
    return Dom.div()(props.fooProp);
  }
}
