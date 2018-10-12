import 'package:over_react/over_react.dart';

//part 'basic.g.dart';
import 'basic.overReactBuilder.template.g.dart';

@Factory()
UiFactory<BasicProps> Basic = $Basic;

@Props()
class BasicProps extends UiProps {
  static const PropsMeta meta = $metaForBasicProps;

  String basicProp;
  String basic1;
  String basic2;
  String basic3;
  String basic4;
  String basic5;
}

@Component()
class BasicComponent extends UiComponent<BasicProps> {
  getDefaultProps() => newProps()..id = 'basic';

  @override
  render() {
    return Dom.div()(props.basicProp, props.basic5);
  }
}
