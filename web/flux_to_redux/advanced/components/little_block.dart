import 'package:over_react/over_react.dart';

part 'little_block.over_react.g.dart';

@Factory()
UiFactory<LittleBlockProps> LittleBlock = _$LittleBlock;

@Props()
class _$LittleBlockProps extends UiProps {
  String backgroundColor;

  String colorString;

  String blockTitle;
}

@Component2()
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
