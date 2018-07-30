import 'package:over_react/over_react.dart';

part 'foo.g.dart';

//@Factory()
UiFactory<FooProps> Foo = $Foo;

//@Props()
class FooProps extends UiProps {
  String fooProp;
  String foo1;
  String foo2;
  String foo3;
  String foo4;
  String foo5;
  String foo6;
  String foo7;
  String foo8;
  String foo9;
  String foo10;
  String foo11;
  String foo12;
  String foo13;
  String foo14;
  String foo15;
  String foo16;
  String foo17;
  String foo18;
  String foo19;
  String foo20;
  String foo21;
  String foo22;
  String foo23;
  String foo24;
  String foo25;
  String foo26;
  String foo27;
  String foo28;
  String foo29;
}

//@Component()
class FooComponent extends UiComponent<FooProps> {
  // If you *really* need a constructor, do something like this.
  // Using constructors makes things more complicated:
  // - since you need the default constructor for the impl to call as well as a different named factory constructor
  // - when this class has generic props, the impl has a typedPropsFactory that doesn't meet those (need to check that the current is kosher in DDC)
  static _$FooComponentImpl construct() => new _$FooComponentImpl();

  @override
  render() {
    return Dom.div()(props.fooProp, props.foo22);
  }
}
