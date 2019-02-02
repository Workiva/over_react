import 'package:over_react/over_react.dart';

// ignore: uri_has_not_been_generated
part 'component_render.over_react.g.dart';

@Factory()
// ignore: undefined_identifier
UiFactory<BadRenderProps> BadRender = $BadRender;

@Props()
class _$BadRenderProps extends UiProps {}

// ignore: mixin_of_non_class, undefined_class
class BadRenderProps extends _$BadRenderProps with _$BadRenderPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = $metaForBadRenderProps;
}

@Component()
class BadRenderComponent extends UiComponent<BadRenderProps> {
  @override
  render() {
    if (props.id == 'something') {
      return 'Not a ReactElement';
    }

    if (props.children.isEmpty) {
      // Uninvoked builder: has quick-fix
      return Dom.div();
    }

    return [
      Dom.div()(),
      Dom.span()(),
    ];
  }
}
