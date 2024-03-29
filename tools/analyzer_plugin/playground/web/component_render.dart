import 'package:over_react/over_react.dart';

part 'component_render.over_react.g.dart';

UiFactory<BadRenderProps> BadRender =
    castUiFactory(_$BadRender); // ignore: undefined_identifier

mixin BadRenderProps on UiProps {}

class BadRenderComponent extends UiComponent2<BadRenderProps> {
  @override
  render() {
    if (props.id == 'something') {
      return 'Not a ReactElement';
    }

    if (props.children?.isEmpty ?? true) {
      // Uninvoked builder: has quick-fix
      return Dom.div();
    }

    return [
      Dom.div()(),
      Dom.span()(),
    ];
  }
}

final BadRenderFnComponent = uiFunction<UiProps>(
  (props) {
    if (props.id == 'something') {
      return false;
    }

    if (props.children == null) {
      // Uninvoked builder: has quick-fix
      return Dom.div();
    }

    return [
      Dom.div()(),
      Dom.span()(),
    ];
  },
  UiFactoryConfig(displayName: 'BadRenderFnComponent'),
);
