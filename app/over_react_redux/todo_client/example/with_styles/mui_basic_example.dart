import 'package:over_react/over_react.dart';
import 'package:react_material_ui/react_material_ui.dart';
import 'package:react/react_client/js_backed_map.dart';

part 'mui_basic_example.over_react.g.dart'; // ignore: uri_has_not_been_generated

const styles = {
  'root': {
    'background': 'linear-gradient(45deg, #FE6B8B 30%, #FF8E53 90%)',
    'border': 0,
    'borderRadius': 3,
    'boxShadow': '0 3px 5px 2px rgba(255, 105, 135, .3)',
    'color': 'white',
    'height': 48,
    'padding': '0 30px',
  },
};

class HigherOrderComponentProps = UiProps with WithStyleClassesPropsMixin;

UiFactory<HigherOrderComponentProps> HigherOrderComponent = uiFunction(
  (props) {
    return ((Button()..className = props.withStyleClasses['root'])(
      'Higher-order component',
    ));
  },
  $HigherOrderComponentConfig, // ignore: undefined_identifier
);

UiFactory<HigherOrderComponentProps> HigherOrderComponentWithStyles =
    withStyles<HigherOrderComponentProps>(styles)(HigherOrderComponent);

final dynamicStyles = {
  'root': {
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
  },
};

// TODO figure out how to be able to avoid having to do this for props that
// are consumed by style maps
@Props(keyNamespace: '')
mixin MyButtonRawPropsMixin on UiProps {
  String color;
}

class MyButtonRawProps = UiProps
    with MyButtonRawPropsMixin, WithStyleClassesPropsMixin;

UiFactory<MyButtonRawProps> MyButtonRaw = uiFunction(
  (props) {
    return ((Button()..className = props.withStyleClasses['root'])(
      props.children,
    ));
  },
  $MyButtonRawConfig, // ignore: undefined_identifier
);

UiFactory<MyButtonRawProps> MyButton = withStyles<MyButtonRawProps>(
  dynamicStyles,
  propsBuilder: $MyButtonRawConfig.propsFactory, // ignore: undefined_identifier
)(MyButtonRaw);

class NestedProps = UiProps with WithStyleClassesPropsMixin;

UiFactory<NestedProps> Nested = uiFunction(
  (props) {
    return ((Dom.button()..className = props.withStyleClasses['root'])(
      (Dom.span()..className = props.withStyleClasses['label'])(
        'Nested',
      ),
    ));
  },
  $NestedConfig, // ignore: undefined_identifier
);

const nestedStyles = {
  'root': {
    'backgroundColor': 'green',
  },
  'label': {
    'color': 'white',
  },
};

UiFactory<NestedProps> NestedWithStyles =
    withStyles<NestedProps>(nestedStyles)(Nested);

mixin ParentProps on UiProps {}

UiFactory<ParentProps> Parent = uiFunction(
  (props) {
    return (NestedWithStyles()..withStyleClasses = {'label': 'my-label'})();
  },
  $ParentConfig, // ignore: undefined_identifier
);

class ThemedButtonProps = UiProps with WithStyleClassesPropsMixin;

UiFactory<ThemedButtonProps> ThemedButton = uiFunction(
  (props) {
    return ((Button()..className = props.withStyleClasses['root'])(
      'Themed Button',
    ));
  },
  $ThemedButtonConfig, // ignore: undefined_identifier
);

UiFactory<ThemedButtonProps> ThemedButtonWithStyles =
    withThemedStyles<ThemedButtonProps>((theme) {
  return {
    'root': {
      'backgroundColor': theme.palette.primary.dark,
    }
  };
})(ThemedButton);
