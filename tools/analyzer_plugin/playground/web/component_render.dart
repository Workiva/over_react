import 'package:over_react/over_react.dart';

part 'component_render.over_react.g.dart';

UiFactory<BadRenderProps> BadRender = castUiFactory(_$BadRender); // ignore: undefined_identifier

mixin BadRenderProps on UiProps {}

class BadRenderComponent extends UiComponent2<BadRenderProps> {
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
