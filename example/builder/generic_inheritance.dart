import 'package:over_react/over_react.dart';

part 'generic_inheritance.g.dart';

// @Factory()
UiFactory<GenericSuperProps> GenericSuper = $GenericSuper;

// @Props()
class GenericSuperProps extends UiProps {
  String superProp;
}

// @Component()
class GenericSuperComponent<T extends GenericSuperProps> extends UiComponent<T> {
  @override
  render() {
    return Dom.div()('GenericSuper', {
      'props.superProp': props.superProp,
//      'props': props.toString(),
    }.toString());
  }
}


// @Factory()
UiFactory<GenericSubProps> GenericSub = $GenericSub;

// @Props()
// Heads up: props class inheritance doesn't work properly currently
class GenericSubProps extends GenericSuperProps {
  String subProp;
}

// @Component()
class GenericSubComponent extends GenericSuperComponent<GenericSubProps> {
  @override
  render() {
    return Dom.div()('GenericSub', {
      'props.subProp': props.subProp,
      'props.superProp': props.superProp,
//      'props': props.toString(),
    }.toString());
  }
}
