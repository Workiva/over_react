import 'dart:html';

import 'package:over_react/over_react.dart';

import 'package:react_material_ui/react_material_ui.dart';

part 'todo_item_text_field.over_react.g.dart';

/// Use the `TodoItemTextField` component to provide messaging to users about an empty set of results,
/// or an empty view such as a 404 error page.

UiFactory<TodoItemTextFieldProps> TodoItemTextField =
    _$TodoItemTextField; // ignore: undefined_identifier

@Props(keyNamespace: '') // No namespace so prop forwarding works when passing to the JS TextField / InputBase components.
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

class TodoItemTextFieldComponent extends UiStatefulComponent2<TodoItemTextFieldProps, TodoItemTextFieldState> {
  final textFieldRef = createRef<Element>();

  @override
  get defaultProps => (newProps()
    ..fullWidth = true
    ..readOnly = true
    ..multiline = false
    ..variant = 'outlined'
  );

  static final _onClickPropKey = getPropKey((p) => p.onClickWhenEditable, TodoItemTextField);

  @override
  Iterable<ConsumedProps> get consumedProps => [
    PropsMeta.forSimpleKey(_onClickPropKey)
  ];

  @override
  render() {
    if (props.readOnly) return _renderReadonlyBaseInput();

    return _renderEditableInput();
  }

  ReactElement _renderReadonlyBaseInput() {
    return (InputBase()
        ..modifyProps(addUnconsumedProps)
        ..inputRef = textFieldRef.jsRef
        ..inputProps = {
          'style': {
            'whiteSpace': 'nowrap',
            'textOverflow': 'ellipsis',
          },
        }
    )();
  }

  ReactElement _renderEditableInput() {
    return (TextField()
        ..modifyProps(addUnconsumedProps)
        ..inputRef = textFieldRef.jsRef
        ..onClick = props.onClickWhenEditable
    )();
  }
}
