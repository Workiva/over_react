import 'package:over_react/over_react.dart';

//part 'abstract_inheritance.g.dart';
import 'abstract_inheritance.overReactBuilder.template.g.dart';

@AbstractProps()
class SuperProps extends UiProps {
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

@Props()
// Heads up: props class inheritance doesn't work properly currently
class SubProps extends SuperProps {
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
