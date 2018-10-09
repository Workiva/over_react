part of basic.library;

@Factory()
UiFactory<BasicWithMixinProps> BasicWithMixin = $BasicWithMixin;

@Props()
class BasicWithMixinProps extends UiProps with ExamplePropsMixinClass {
  static const PropsMeta meta = $metaForBasicWithMixinProps;

  String basicProp;
  String basic1;
  String basic2;
  String basic3;
  String basic4;
  String basic5;
}

@Component()
class BasicWithMixinComponent extends UiComponent<BasicWithMixinProps> {
  getDefaultProps() => newProps()..id = 'basic';

  @override
  render() {
    return Dom.div()(props.basicProp, props.basic5);
  }
}
