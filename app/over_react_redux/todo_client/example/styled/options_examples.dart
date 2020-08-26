import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:react_material_ui/react_material_ui.dart';

part 'options_examples.over_react.g.dart'; // ignore: uri_has_not_been_generated

final backupTheme = MuiTheme()
  ..palette = MuiPalette({
    'primary': {
      'light': '#008000',
      'main': '#FFA500',
      'dark': '#0000FF',
    }
  });

Map<String, dynamic> themedStyles(MuiTheme theme) => {
      'backgroundColor': theme.palette.primary.dark,
    };

mixin CustomThemedButtonProps on UiProps {}

UiFactory<CustomThemedButtonProps> CustomThemedButton = uiFunction(
  (props) {
    return ((Button()..className = props.className)(
      'Themed Button',
    ));
  },
  $CustomThemedButtonConfig, // ignore: undefined_identifier
);

UiFactory<CustomThemedButtonProps> CustomThemedButtonWithStyles =
    styledWithTheme<CustomThemedButtonProps>(CustomThemedButton)((theme) {
  return {
    'backgroundColor': theme.palette.primary.main,
  };
}, options: MuiStyleOptions()..defaultTheme = backupTheme);

mixin CustomStyleElementProps on UiProps {}

UiFactory<CustomStyleElementProps> CustomStyleElement = uiFunction(
  (props) {
    return ((Button()..className = props.className)(
      'With a Custom Style Tag',
    ));
  },
  $CustomStyleElementConfig, // ignore: undefined_identifier
);

UiFactory<CustomStyleElementProps> CustomStyleElementWithStyles =
    styledWithTheme<CustomStyleElementProps>(CustomStyleElement)(themedStyles,
        options: MuiStyleOptions()
          ..element = (StyleElement()..id = 'custom-style-tag'));

mixin MediaOptionButtonProps on UiProps {}

UiFactory<MediaOptionButtonProps> MediaOptionButton = uiFunction(
  (props) {
    return ((Button()..className = props.className)(
      'With the Print Media Option',
    ));
  },
  $MediaOptionButtonConfig, // ignore: undefined_identifier
);

UiFactory<MediaOptionButtonProps> MediaOptionButtonWithStyles =
    styledWithTheme<MediaOptionButtonProps>(MediaOptionButton)(themedStyles,
        options: MuiStyleOptions()..media = 'print');

mixin SpecifiedIndexButtonProps on UiProps {}

UiFactory<SpecifiedIndexButtonProps> SpecifiedIndexButton = uiFunction(
  (props) {
    return ((Button()..className = props.className)(
      'With specified index',
    ));
  },
  $SpecifiedIndexButtonConfig, // ignore: undefined_identifier
);

UiFactory<SpecifiedIndexButtonProps> SpecifiedIndexButtonWithStyles =
    styledWithTheme<SpecifiedIndexButtonProps>(SpecifiedIndexButton)(
        themedStyles,
        options: MuiStyleOptions()
          ..index = 1
          ..meta = 'This should be the last style tag in the header');

class MiscOptionsProps = UiProps with MuiClassesMixin;

UiFactory<MiscOptionsProps> MiscOptions = uiFunction(
  (props) {
    return ((Button()..className = props.className)(
      'Button With Misc Options',
    ));
  },
  $MiscOptionsConfig, // ignore: undefined_identifier
);

UiFactory<MiscOptionsProps> MiscOptionsWithStyles =
    styledWithTheme<MiscOptionsProps>(MiscOptions)(themedStyles,
        options: MuiStyleOptions()
          ..name = 'this-is-a-custom-name'
          ..meta = 'this meta is set manually');
