import 'package:over_react/over_react.dart';
import 'props_mixin.dart';

//part 'basic.template.g.dart';
//part 'basic.template.overReactBuilder.g.dart';
part 'basic.overReactBuilder.g.dart';

@Factory()
UiFactory<_$BasicProps> Basic = $Basic;

@Props()
abstract class _$BasicProps extends UiProps {// with ExamplePropsMixinClass {
  static const PropsMeta meta = $metaForBasicProps;

  String basicProp;
  String basic1;
  String basic2;
  String basic3;
  String basic4;
  String basic5;
}

@Component()
class BasicComponent extends UiComponent<_$BasicProps> {
  getDefaultProps() => newProps()..id = 'basic';

  @override
  render() {
    return Dom.div()(props.basicProp);
  }
}
