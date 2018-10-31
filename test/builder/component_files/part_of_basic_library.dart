part of basic.library;

@Factory()
UiFactory<BasicPartOfLibProps> BasicPartOfLib = $BasicPartOfLib;

// ignore: mixin_of_non_class,undefined_class
class BasicPartOfLibProps extends UiProps with _$BasicPartOfLibPropsAccessorsMixin implements _$BasicPartOfLibProps {}

@Props()
class _$BasicPartOfLibProps extends UiProps with ExamplePropsMixinClass {
  static const PropsMeta meta = $metaForBasicPartOfLibProps;

  String basicProp;
  String basic1;
  String basic2;
  String basic3;
  String basic4;
  String basic5;
}

@Component()
class BasicPartOfLibComponent extends UiComponent<BasicPartOfLibProps> {
  getDefaultProps() => newProps()..id = 'BasicPartOfLib';

  @override
  render() {
    return Dom.div()('BasicPartOfLibComponent: ${props.basicProp}, ${props.propMixin1}');
  }
}