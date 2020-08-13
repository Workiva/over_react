import 'package:over_react/over_react.dart';
import 'package:react_material_ui/react_material_ui.dart';
import 'package:react/react_client/js_backed_map.dart';

part 'box.over_react.g.dart'; // ignore: uri_has_not_been_generated

Map getBoxColored(String boxColor) {
  return {
    'backgroundColor': boxColor,
    'height': 100,
    'width': 100,
  };
}

//final useStyles = makeStyles2({
//  'arbitrary': (BoxWrapperProps props) {
//    print(props.color);
//    return getBoxColored(props.color);
//  },
//  'arbitrary-2': getBoxColored('blue'),
//  'noProps': getBoxColored('red'),
//}, $BoxWrapperConfig);  // ignore: undefined_identifier

final useStyles = makeStyles<BoxWrapperProps>({
  'arbitrary': (props) {
    return getBoxColored(props.color);
  },
  'arbitrary-2': getBoxColored('blue'),
  'noProps': getBoxColored('red'),
},
  config: $BoxWrapperConfig, // ignore: undefined_identifier
);

mixin BoxWrapperProps on UiProps {
  String color;
}

UiFactory<BoxWrapperProps> BoxWrapper = uiFunction((props) {
  final styles = useStyles(props);

  return (Box()..className = styles['arbitrary'])(props.children);
  },
  $BoxWrapperConfig, // ignore: undefined_identifier
);

mixin NoPropsBoxWrapperProps on UiProps {}

UiFactory<NoPropsBoxWrapperProps> NoPropsBoxWrapper = uiFunction((props) {
  final styles = useStyles();

  return (Box()..className = styles['noProps'])(props.children);
},
  $NoPropsBoxWrapperConfig, // ignore: undefined_identifier
);

final useFunctionStyles = makeStyles((theme) {
  return {
    'root': (props) {
      return {
        'backgroundColor': theme.backgroundColor,
        'height': props.height,
        'width': props.width,
      };
    },
  };
});
