import 'package:over_react/over_react.dart';
import 'package:react/react_client.dart';

//part 'generic_inheritance_super.g.dart';
part 'generic_inheritance_super.overReactBuilder.g.dart';

@Factory()
UiFactory<GenericSuperProps> GenericSuper = $GenericSuper;

@Props()
class GenericSuperProps extends UiProps {
  static const PropsMeta meta = $metaForGenericSuperProps;

  String superProp;
}

@Component()
class GenericSuperComponent<T extends GenericSuperProps> extends UiComponent<T> {
  getDefaultProps() => newProps()..id = 'generic_super';

  @override
  render() {
    return Dom.div()('GenericSuper', {
      'props.superProp': props.superProp,
//      'props': props.toString(),
    }.toString());
  }
}
