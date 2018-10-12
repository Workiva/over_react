import 'package:over_react/over_react.dart';
import 'generic_inheritance_super.dart';

//part 'generic_inheritance_sub.g.dart';
import 'generic_inheritance_sub.overReactBuilder.template.g.dart';

@Factory()
UiFactory<GenericSubProps> GenericSub = $GenericSub;

@Props()
// Heads up: props class inheritance doesn't work properly currently
class GenericSubProps extends GenericSuperProps {
  static const PropsMeta meta = $metaForGenericSubProps;

  String subProp;
}

@Component()
class GenericSubComponent extends GenericSuperComponent<GenericSubProps> {
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

