import 'package:over_react/over_react.dart';
import 'props_mixin.dart';

part 'basic.overReactBuilder.g.dart';

@Factory()
UiFactory<BasicProps> Basic = $Basic;

// ignore: mixin_of_non_class,undefined_class
class BasicProps extends UiProps with _$BasicPropsMixin implements _$BasicProps {}

@Props()
class _$BasicProps extends UiProps with ExamplePropsMixinClass {
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
    return Dom.div()(props.basicProp);
  }
}
