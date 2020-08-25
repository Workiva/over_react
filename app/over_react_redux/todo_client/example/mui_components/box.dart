import 'package:over_react/over_react.dart';
import 'package:react_material_ui/react_material_ui.dart';

part 'box.over_react.g.dart'; // ignore: uri_has_not_been_generated

Map getBoxColored(String boxColor) {
  return {
    'backgroundColor': boxColor,
    'height': 100,
    'width': 100,
  };
}

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

final useFunctionStyles = makeStyles<FunctionStylesBoxWrapperProps>((theme) {
  return {
    'root': (FunctionStylesBoxWrapperProps props) {
      return {
        'backgroundColor': theme['palette']['primary']['dark'],
        'height': props.height,
        'width': props.width,
      };
    },
    'noProps': {
      'backgroundColor':  theme['palette']['primary']['light'],
      'height': 100,
      'width': 100,
    }
  };
},
  config: $FunctionStylesBoxWrapperConfig, // ignore: undefined_identifier
);

mixin FunctionStylesBoxWrapperProps on UiProps {
  int height;
  int width;
}

UiFactory<FunctionStylesBoxWrapperProps> FunctionStylesBoxWrapper = uiFunction((props) {
    final styles = useFunctionStyles(props);
    return (Box()..className = styles['root'])(props.children);
  },
  $FunctionStylesBoxWrapperConfig, // ignore: undefined_identifier
);

UiFactory<FunctionStylesBoxWrapperProps> FunctionStylesNoPropsBoxWrapper = uiFunction((props) {
  final styles = useFunctionStyles();
  return (Box()..className = styles['noProps'])(props.children);
},
  $FunctionStylesNoPropsBoxWrapperConfig, // ignore: undefined_identifier
);

final backupTheme = MuiTheme()..palette = MuiPalette({
  'primary': {
    'light': 'green',
    'main': 'orange',
    'dark': 'blue',
  }
})..direction='rtl';

final useStylesWithOptions = makeStyles((theme) => {
  'root': {
    'backgroundColor': theme['palette']['primary']['light'],
    'height': 100,
    'width': 100,
  },
});

mixin OptionsBoxWrapperProps on UiProps {}

UiFactory<NoPropsBoxWrapperProps> OptionsBoxWrapper = uiFunction((props) {
  final styles = useStylesWithOptions();

  return (Box()..className = styles['root'])(props.children);
},
  $OptionsBoxWrapperConfig, // ignore: undefined_identifier
);
