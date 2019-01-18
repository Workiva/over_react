import 'package:over_react/over_react.dart';
import 'props_mixin.dart' as pm;

part 'basic.over_react.g.dart';

@Factory()
UiFactory<BasicProps> Basic = _$Basic;

// ignore: mixin_of_non_class,undefined_class
class BasicProps extends _$BasicProps with _$BasicPropsAccessorsMixin {}

@Props()
//// ignore: mixin_of_non_class,undefined_class
class _$BasicProps extends UiProps with pm.ExamplePropsMixinClass, pm.$ExamplePropsMixinClass, pm.MixesInOtherMixinMixin, pm.$MixesInOtherMixinMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = _$metaForBasicProps;

  String basicProp;
  String basic1;
  String basic2;
  String basic3;
  String basic4;
  String basic5;
}

@Component()
class BasicComponent extends UiComponent<BasicProps> {
  @override
  Map getDefaultProps() => newProps()..id = 'basic component'
      ..basicProp = 'defaultBasicProps'
      ..otherPropMixin = '<mixin from other mixin class>'
      ..propMixin1 = '<mixin prop from example mixin>';

  @override
  render() {
    return Dom.div()(
        Dom.div()('props for mixin in basic.dart: ${props.propMixin1}'),
        Dom.div()('prop id: ${props.id}'),
        Dom.div()('default prop testing: ${props.basicProp}'),
        Dom.div()('default prop testing: ${props.basic1}'),
        Dom.div()('Mixin from other props mixin class on basic.dart: ${props.otherPropMixin}'),
    );
  }
}


