import 'package:over_react/over_react.dart';

import 'package:todo_client/src/components/shared/material_ui.dart';

// ignore: uri_has_not_been_generated
part 'todo_item_text_field.over_react.g.dart';

/// Use the `TodoItemTextField` component to provide messaging to users about an empty set of results,
/// or an empty view such as a 404 error page.
@Factory()
UiFactory<TodoItemTextFieldProps> TodoItemTextField =
    // ignore: undefined_identifier
    _$TodoItemTextField;

@Props(keyNamespace: '') // No namespace so prop forwarding works when passing to the JS TextField / InputBase components.
class _$TodoItemTextFieldProps extends UiProps {
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

@State()
class _$TodoItemTextFieldState extends UiState {}

@Component2()
class TodoItemTextFieldComponent extends UiStatefulComponent2<TodoItemTextFieldProps, TodoItemTextFieldState> {
  @override
  get defaultProps => (newProps()
    ..fullWidth = true
    ..readOnly = true
    ..multiline = false
    ..variant = 'outlined'
  );

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

    return InputBase({
      ...propsToForward,
      'inputProps': {
        'style': {
          'whiteSpace': 'nowrap',
          'textOverflow': 'ellipsis',
        },
      },
    });
  }

  ReactElement _renderEditableInput() {
    final propsToForward = Map.of(props)..remove('onClickWhenEditable');

    return TextField({
      ...propsToForward,
      'onClick': props.onClickWhenEditable,
    });
  }
}

// ignore: mixin_of_non_class, undefined_class
class TodoItemTextFieldProps extends _$TodoItemTextFieldProps with _$TodoItemTextFieldPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = _$metaForTodoItemTextFieldProps;
}

// ignore: mixin_of_non_class, undefined_class
class TodoItemTextFieldState extends _$TodoItemTextFieldState with _$TodoItemTextFieldStateAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const StateMeta meta = _$metaForTodoItemTextFieldState;
}
