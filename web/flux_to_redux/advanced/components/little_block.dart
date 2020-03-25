import 'package:over_react/over_react.dart';

part 'little_block.over_react.g.dart';

UiFactory<LittleBlockProps> LittleBlock = _$LittleBlock;

mixin LittleBlockProps on UiProps {
  String backgroundColor;

  String colorString;

  String blockTitle;
}

class LittleBlockComponent extends UiComponent2<LittleBlockProps> {
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
      }
    )(
      Dom.div()(props.blockTitle),
      Dom.div()('The color is ${props.colorString}'),
    ));
  }
}
