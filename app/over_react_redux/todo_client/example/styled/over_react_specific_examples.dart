import 'package:over_react/over_react.dart';
import 'package:react_material_ui/react_material_ui.dart';

part 'over_react_specific_examples.over_react.g.dart'; // ignore: uri_has_not_been_generated

UiFactory<ClassBasedComponentProps> StyledClassBasedComponent =
    styled<ClassBasedComponentProps>(ClassBasedComponent)(
  MuiStyleMap<ClassBasedComponentProps>()
    ..addFunctionRule('backgroundColor', (props) => props.color),
  propsBuilder: ClassBasedComponent, // ignore: undefined_identifier
);

UiFactory<ClassBasedComponentProps> ClassBasedComponent =
    _$ClassBasedComponent; // ignore: undefined_identifier

mixin ClassBasedComponentProps on UiProps {
  String color;
}

class ClassBasedComponentComponent
    extends UiComponent2<ClassBasedComponentProps> {
  @override
  render() {
    return (Button()..classes = {'root': props.className})(
      'Styled OverReact Button',
    );
  }
}
