import 'package:over_react/over_react.dart';

part 'generic_inheritance.g.dart';

// @Factory()
UiFactory<GenericSuperProps> GenericSuper = $GenericSuper;

// @Props()
class GenericSuperProps extends UiProps {
  String superProp;
}

// @Component()
class GenericSuperComponent<T extends GenericSuperProps, OtherParam extends ArbitraryClass> extends UiComponent<T> {
  factory GenericSuperComponent() = _$GenericSuperComponent<T, OtherParam>;
  GenericSuperComponent._();

  getDefaultProps() => newProps()..id = 'generic_super';

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
class GenericSubComponent extends GenericSuperComponent<GenericSubProps, ArbitraryClass> {
  factory GenericSubComponent() = _$GenericSubComponent;
  GenericSubComponent._() : super._();

  getDefaultProps() => newProps()..id = 'generic_sub';

  @override
  render() {
    return Dom.div()('GenericSub', {
      'props.subProp': props.subProp,
      'props.superProp': props.superProp,
//      'props': props.toString(),
    }.toString());
  }
}


class ArbitraryClass {}
