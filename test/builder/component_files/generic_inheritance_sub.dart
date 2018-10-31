import 'package:over_react/over_react.dart';
import 'generic_inheritance_super.dart';

//part 'generic_inheritance_sub.g.dart';
part 'generic_inheritance_sub.overReact.g.dart';

@Factory()
UiFactory<GenericSubProps> GenericSub = $GenericSub;

// ignore: mixin_of_non_class,undefined_class
class GenericSubProps extends UiProps with _$GenericSubPropsAccessorsMixin implements _$GenericSubProps {}

@Props()
// Heads up: props class inheritance doesn't work properly currently
class _$GenericSubProps extends GenericSuperProps {
  static const PropsMeta meta = $metaForGenericSubProps;

  String subProp;
}

@Component()
class GenericSubComponent extends GenericSuperComponent<GenericSubProps> {
  getDefaultProps() => newProps()..id = 'generic_sub';

  @override
  render() {
    print(props.otherSuperProp);
    return Dom.div()('GenericSub', {
      'props.subProp': props.subProp,
//      'props.superProp': props.otherSuperProp,
//      'props': props.toString(),
    }.toString());
  }
}

