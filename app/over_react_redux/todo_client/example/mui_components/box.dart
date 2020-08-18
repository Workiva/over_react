import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:react_material_ui/react_material_ui.dart';

part 'box.over_react.g.dart'; // ignore: uri_has_not_been_generated

const standardHeightAndWidth = {
  'height': 100,
  'width': 100,
};

Map<String, dynamic> getBoxColored(String boxColor) {
  return {
    'backgroundColor': boxColor,
    ...standardHeightAndWidth,
  };
}

final useStyles = makeStyles<BoxWrapperProps>(
  styleMap: MuiStyleMap<BoxWrapperProps>()
    ..addFunctionRule('arbitrary', (props) {
      return getBoxColored(props.color);
    })
    ..addRule('arbitrary-2', getBoxColored('blue'))
    ..addRule('noProps', getBoxColored('red')),
  config: $BoxWrapperConfig, // ignore: undefined_identifier
);

mixin BoxWrapperProps on UiProps {
  String color;
}

UiFactory<BoxWrapperProps> BoxWrapper = uiFunction(
  (props) {
    final styles = useStyles(props);

    return (Box()..className = styles['arbitrary'])(props.children);
  },
  $BoxWrapperConfig, // ignore: undefined_identifier
);

mixin NoPropsBoxWrapperProps on UiProps {}

UiFactory<NoPropsBoxWrapperProps> NoPropsBoxWrapper = uiFunction(
  (props) {
    final styles = useStyles();

    return (Box()..className = styles['noProps'])(props.children);
  },
  $NoPropsBoxWrapperConfig, // ignore: undefined_identifier
);

final useFunctionStyles = makeStyles<FunctionStylesBoxWrapperProps>(
  styleFunction: (theme) {
    return MuiStyleMap<FunctionStylesBoxWrapperProps>()
      ..addFunctionRule('root', (props) {
        return {
          'backgroundColor': theme.palette.primary.dark,
          'height': props.height,
          'width': props.width,
        };
      })
      ..addRule('noProps', {
        'backgroundColor': theme.palette.primary.light,
        ...standardHeightAndWidth,
      });
  },
  config: $FunctionStylesBoxWrapperConfig, // ignore: undefined_identifier
);

mixin FunctionStylesBoxWrapperProps on UiProps {
  int height;
  int width;
}

UiFactory<FunctionStylesBoxWrapperProps> FunctionStylesBoxWrapper = uiFunction(
  (props) {
    final styles = useFunctionStyles(props);
    return (Box()..className = styles['root'])(props.children);
  },
  $FunctionStylesBoxWrapperConfig, // ignore: undefined_identifier
);

UiFactory<FunctionStylesBoxWrapperProps> FunctionStylesNoPropsBoxWrapper =
    uiFunction(
  (props) {
    final styles = useFunctionStyles();
    return (Box()..className = styles['noProps'])(props.children);
  },
  $FunctionStylesNoPropsBoxWrapperConfig, // ignore: undefined_identifier
);

final backupTheme = MuiTheme()
  ..palette = MuiPalette({
    'primary': {
      'light': '#008000',
      'main': '#FFA500',
      'dark': '#0000FF',
    }
  });

// When inspecting the DOM, this `<style>` tag should be last because
// of the index.
final useStylesWithOptions = makeStyles(
    styleFunction: (theme) => MuiStyleMap({
          'root': {
            'backgroundColor': theme.palette.primary.light,
            'height': 100,
            'width': 100,
          },
        }),
    options: (MakeStylesOptions()
      ..name = 'this-is-a-custom-name'
      ..defaultTheme = backupTheme
      ..meta = 'the_last_tag_because_of_index'
      ..index = 1));

mixin OptionsBoxWrapperProps on UiProps {}

UiFactory<NoPropsBoxWrapperProps> OptionsBoxWrapper = uiFunction(
  (props) {
    final styles = useStylesWithOptions();

    return (Box()..className = styles['root'])();
  },
  $OptionsBoxWrapperConfig, // ignore: undefined_identifier
);

final stylesWithElementOption = makeStyles(
    styleMap: {
      'root': {
        'backgroundColor': 'orange',
        'color': 'white',
        ...standardHeightAndWidth,
      }
    },
    options: MakeStylesOptions()
      ..element = (StyleElement()..id = 'a_custom_style_tag'));

UiFactory<NoPropsBoxWrapperProps> BoxWithElement = uiFunction(
  (props) {
    final styles = stylesWithElementOption();

    return (Box()..className = styles['root'])(props.children);
  },
  $BoxWithMediaConfig, // ignore: undefined_identifier
);

final stylesWithMediaOption = makeStyles(styleMap: {
  'root': {
    ...standardHeightAndWidth,
  }
}, options: MakeStylesOptions()..media = 'print');

UiFactory<NoPropsBoxWrapperProps> BoxWithMedia = uiFunction(
  (props) {
    final styles = stylesWithMediaOption();

    return (Box()..className = styles['root'])(props.children);
  },
  $BoxWithMediaConfig, // ignore: undefined_identifier
);
