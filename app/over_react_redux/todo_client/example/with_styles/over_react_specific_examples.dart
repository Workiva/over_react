import 'package:over_react/over_react.dart';
import 'package:react_material_ui/react_material_ui.dart';

part 'over_react_specific_examples.over_react.g.dart'; // ignore: uri_has_not_been_generated

UiFactory<ClassBasedComponentProps> StyledClassBasedComponent =
    withStyles<ClassBasedComponentProps>(
  MuiStyleMap<ClassBasedComponentProps>()
    ..addFunctionRule('root', (props) {
      return {'backgroundColor': props.color};
    }),
  propsBuilder: _$ClassBasedComponent, // ignore: undefined_identifier
)(ClassBasedComponent);

UiFactory<ClassBasedComponentProps> ClassBasedComponent =
    _$ClassBasedComponent; // ignore: undefined_identifier

@Props(keyNamespace: '')
mixin ClassBasedComponentPropsMixin on UiProps {
  String color;
}

class ClassBasedComponentProps = UiProps
    with ClassBasedComponentPropsMixin, WithStyleClassesPropsMixin;

class ClassBasedComponentComponent
    extends UiComponent2<ClassBasedComponentProps> {
  @override
  render() {
    return (Button()..classes = {'root': props.withStyleClasses['root']})(
        'Styled OverReact Button');
  }
}
