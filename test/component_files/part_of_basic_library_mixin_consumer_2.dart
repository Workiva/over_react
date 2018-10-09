part of basic.library;

@Factory()
UiFactory<OtherBasicWithMixinProps> OtherBasicWithMixin = $OtherBasicWithMixin;

@Props()
class OtherBasicWithMixinProps extends UiProps with ExamplePropsMixinClass {
  static const PropsMeta meta = $metaForOtherBasicWithMixinProps;

  String basicProp;
  String basic1;
  String basic2;
  String basic3;
  String basic4;
  String basic5;
}

@Component()
class OtherBasicWithMixinComponent extends UiComponent<OtherBasicWithMixinProps> {
  getDefaultProps() => newProps()..id = 'basic';

  @override
  render() {
    return Dom.div()(props.basicProp, props.basic5);
  }
}
