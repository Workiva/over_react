import 'package:over_react/over_react.dart';
import 'props_mixin.dart' as pm;


part 'basic.overReact.g.dart';

@Factory()
UiFactory<BasicProps> Basic = $Basic;

// ignore: mixin_of_non_class,undefined_class
class BasicProps extends UiProps with _$BasicPropsAccessorsMixin implements _$BasicProps {}

@Props()
//// ignore: mixin_of_non_class,undefined_class
class _$BasicProps extends UiProps with pm.$ExamplePropsMixinClass, pm.ExamplePropsMixinClass {
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
  getDefaultProps() => newProps()..id = 'basic dude';

  @override
  render() {
    print(props);
    return Dom.div()('props for mixin in basic.dart: ${props.propMixin1}');
  }
}
