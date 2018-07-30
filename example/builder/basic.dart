import 'package:over_react/over_react.dart';

part 'basic.g.dart';

//@Factory()
UiFactory<BasicProps> Basic = $Basic;

//@Props()
class BasicProps extends UiProps {
  String basicProp;
  String basic1;
  String basic2;
  String basic3;
  String basic4;
  String basic5;
  String basic6;
  String basic7;
  String basic8;
  String basic9;
  String basic10;
  String basic11;
  String basic12;
  String basic13;
  String basic14;
  String basic15;
  String basic16;
  String basic17;
  String basic18;
  String basic19;
  String basic20;
  String basic21;
  String basic22;
  String basic23;
  String basic24;
  String basic25;
  String basic26;
  String basic27;
  String basic28;
  String basic29;
}

//@Component()
class BasicComponent extends UiComponent<BasicProps> {
  // If you *really* need a constructor, do something like this.
  // Using constructors makes things more complicated:
  // - since you need the default constructor for the impl to call as well as a different named factory constructor
  // - when this class has generic props, the impl has a typedPropsFactory that doesn't meet those (need to check that the current is kosher in DDC)
  static _$BasicComponentImpl construct() => new _$BasicComponentImpl();

  @override
  render() {
    return Dom.div()(props.basicProp, props.basic22);
  }
}
