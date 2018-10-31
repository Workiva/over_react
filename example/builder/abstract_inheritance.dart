import 'package:over_react/over_react.dart';

//part 'abstract_inheritance.g.dart';
part 'abstract_inheritance.overReact.g.dart';

// ignore: mixin_of_non_class,undefined_class
class SuperProps extends UiProps with _$SuperPropsAccessorsMixin implements _$SuperProps {}

@AbstractProps()
class _$SuperProps extends UiProps {
  static const PropsMeta meta = $metaForSuperProps;

  String superProp;
}

@AbstractComponent()
abstract class SuperComponent<T extends SuperProps> extends UiComponent<T> {
  getDefaultProps() => newProps()..id = 'super';

  @override
  render() {
    return Dom.div()('Super', {
      'props.superProp': props.superProp,
//      'props': props.toString(),
    }.toString());
  }
}

@Factory()
UiFactory<SubProps> Sub = $Sub;

// ignore: mixin_of_non_class,undefined_class
class SubProps extends UiProps with _$SubPropsAccessorsMixin implements _$SubProps {}

@Props()
// Heads up: props class inheritance doesn't work properly currently
class _$SubProps extends SuperProps {
 static const PropsMeta meta = $metaForSubProps;

  String subProp;
}

@Component()
class SubComponent extends SuperComponent<SubProps> {
  getDefaultProps() => newProps()..id = 'sub';

  @override
  render() {
    return Dom.div()('Sub', {
      'props.subProp': props.subProp,
      'props.superProp': props.superProp,
//      'props': props.toString(),
    }.toString());
  }
}
