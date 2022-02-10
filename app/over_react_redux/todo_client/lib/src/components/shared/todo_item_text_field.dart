import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:react_material_ui/src/unstable_components.dart' as mui;

part 'todo_item_text_field.over_react.g.dart';

/// Use the `TodoItemTextField` component to provide messaging to users about an empty set of results,
/// or an empty view such as a 404 error page.

UiFactory<TodoItemTextFieldProps> TodoItemTextField =
    castUiFactory(_$TodoItemTextField); // ignore: undefined_identifier

@Props(
    keyNamespace:
        '') // No namespace so prop forwarding works when passing to the JS TextField / InputBase components.
mixin TodoItemTextFieldProps on UiProps {
  bool readOnly;
  bool fullWidth;
  bool multiline;
  bool autoFocus;
  String variant;
  String label;
  String placeholder;
  String defaultValue;
  String value;
  MouseEventCallback onClickWhenEditable;
}

mixin TodoItemTextFieldState on UiState {}

class TodoItemTextFieldComponent extends UiStatefulComponent2<
    TodoItemTextFieldProps, TodoItemTextFieldState> {
  final textFieldRef = createRef<Element>();

  @override
  get defaultProps => (newProps()
    ..fullWidth = true
    ..readOnly = true
    ..multiline = false
    ..variant = 'outlined');

  @override
  render() {
    if (props.readOnly) return _renderReadonlyBaseInput();

    return _renderEditableInput();
  }

  ReactElement _renderReadonlyBaseInput() {
    final propsToForward = Map.of(props)
      ..remove('variant')
      ..remove('label')
      ..remove('autoFocus')
      ..remove('onClickWhenEditable');

    return (mui.InputBase()
      ..addProps(propsToForward)
      ..inputRef = textFieldRef.jsRef
      ..inputProps = (Dom.input()
        ..style = {
          'whiteSpace': 'nowrap',
          'textOverflow': 'ellipsis',
        }))();
  }

  ReactElement _renderEditableInput() {
    final propsToForward = Map.of(props)..remove('onClickWhenEditable');

    return (mui.TextField()
      ..addProps(propsToForward)
      ..inputRef = textFieldRef.jsRef
      ..onClick = props.onClickWhenEditable)();
  }
}
