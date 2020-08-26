import 'package:over_react/over_react.dart';
import 'package:react_material_ui/react_material_ui.dart';
import 'package:react/react_client/js_backed_map.dart';

part 'mui_basic_example.over_react.g.dart'; // ignore: uri_has_not_been_generated

const styles = {
  'background': 'linear-gradient(45deg, #FE6B8B 30%, #FF8E53 90%)',
  'border': 0,
  'borderRadius': 3,
  'boxShadow': '0 3px 5px 2px rgba(255, 105, 135, .3)',
  'color': 'white',
  'height': 48,
  'padding': '0 30px',
};

mixin HigherOrderComponentProps on UiProps {}

UiFactory<HigherOrderComponentProps> HigherOrderComponent = uiFunction(
  (props) {
    return ((Button()..className = props.className)(
      'Higher-order component',
    ));
  },
  $HigherOrderComponentConfig, // ignore: undefined_identifier
);

UiFactory<HigherOrderComponentProps> HigherOrderComponentWithStyles =
    styled(HigherOrderComponent)(styles);

final dynamicStyles = {
  'background': (props) => props.color == 'red'
      ? 'linear-gradient(45deg, #FE6B8B 30%, #FF8E53 90%)'
      : 'linear-gradient(45deg, #2196F3 30%, #21CBF3 90%)',
  'border': 0,
  'borderRadius': 3,
  'boxShadow': (props) => props.color == 'red'
      ? '0 3px 5px 2px rgba(255, 105, 135, .3)'
      : '0 3px 5px 2px rgba(33, 203, 243, .3)',
  'color': 'white',
  'height': 48,
  'padding': '0 30px',
  'margin': 8,
};

mixin MyButtonRawPropsMixin on UiProps {
  String color;
}

class MyButtonRawProps = UiProps with MyButtonRawPropsMixin;

UiFactory<MyButtonRawProps> MyButtonRaw = uiFunction(
  (props) {
    return ((Button()..className = props.className)(
      props.children,
    ));
  },
  $MyButtonRawConfig, // ignore: undefined_identifier
);

UiFactory<MyButtonRawProps> MyButton = styled<MyButtonRawProps>(MyButtonRaw)(
  dynamicStyles,
  propsBuilder: $MyButtonRawConfig.propsFactory, // ignore: undefined_identifier
);

mixin NestedProps on UiProps {}

UiFactory<NestedProps> Nested = uiFunction(
  (props) {
    return ((Dom.button()..style = {'backgroundColor': 'green'})(
      (Dom.span()..className = props.className)(
        'Nested',
      ),
    ));
  },
  $NestedConfig, // ignore: undefined_identifier
);

const nestedStyles = {
  'color': 'white',
};

UiFactory<NestedProps> NestedWithStyles =
    styled<NestedProps>(Nested)(nestedStyles);

final useStyles = makeStyles({
  'label': {
    'color': 'orange',
    'fontSize': 16,
  }
});

mixin ParentProps on UiProps {}

UiFactory<ParentProps> Parent = uiFunction(
  (props) {
    final classes = useStyles();

    return (NestedWithStyles()..className = classes['label'])();
  },
  $ParentConfig, // ignore: undefined_identifier
);

mixin ThemedButtonProps on UiProps {}

UiFactory<ThemedButtonProps> ThemedButton = uiFunction(
  (props) {
    return ((Button()..className = props.className)(
      'Themed Button',
    ));
  },
  $ThemedButtonConfig, // ignore: undefined_identifier
);

UiFactory<ThemedButtonProps> ThemedButtonWithStyles =
    styledWithTheme<ThemedButtonProps>(ThemedButton)((theme) {
  return {
    'backgroundColor': theme.palette.primary.dark,
  };
});
