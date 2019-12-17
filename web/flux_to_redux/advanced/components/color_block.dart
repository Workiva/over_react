import 'package:over_react/over_react.dart';

part 'color_block.over_react.g.dart';

@Factory()
UiFactory<ColorBlockProps> ColorBlock = _$ColorBlock;

@Props()
class _$ColorBlockProps extends UiProps {
  String backgroundColor;

  String colorString;

  String blockTitle;
}

@Component2()
class ColorBlockComponent extends UiComponent2<ColorBlockProps> {
  @override
  render() {
    return ((Dom.div()
      ..style = {
        'padding': '50px',
        'backgroundColor': props.backgroundColor,
        'color': 'white',
        'display': 'flex',
        'flexDirection': 'column',
        'justifyContent': 'space-evently'
      })(
      Dom.div()(props.blockTitle),
      Dom.div()('The color is ${props.colorString}'),
    ));
  }
}
