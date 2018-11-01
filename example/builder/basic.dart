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
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
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
  getDefaultProps() => newProps()..id = 'basic component'
      ..basicProp = 'defaultBasicProps';

  @override
  render() {
    return Dom.div()(
        Dom.div()('props for mixin in basic.dart: ${props.propMixin1}'),
        Dom.div()('default prop testing: ${props.basicProp}'),
    );
  }
}
