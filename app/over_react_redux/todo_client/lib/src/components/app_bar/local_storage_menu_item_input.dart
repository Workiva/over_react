import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:react_material_ui/src/unstable_components.dart' as mui;

import 'package:todo_client/src/local_storage.dart';

part 'local_storage_menu_item_input.over_react.g.dart';

UiFactory<LocalStorageMenuItemInputProps> LocalStorageMenuItemInput =
    castUiFactory(_$LocalStorageMenuItemInput); // ignore: undefined_identifier

@Props(keyNamespace: '')
mixin LocalStorageMenuItemInputProps on UiProps {
  String initialValue;
  bool error;
  dynamic helperText;
  @requiredProp
  Function(String value) onSave;
  Function(SyntheticKeyboardEvent event) onCancel;
}

mixin LocalStorageMenuItemInputState on UiState {
  String currentValue;
}

class LocalStorageMenuItemInputComponent extends UiStatefulComponent2<
    LocalStorageMenuItemInputProps, LocalStorageMenuItemInputState> {
  @override
  get defaultProps => (newProps()..error = false);

  @override
  get initialState => (newState()..currentValue = props.initialValue);

  @override
  render() {
    final propsToForward = Map.of(props)
      ..remove('initialValue')
      ..remove('onSave')
      ..remove('onCancel');

    return (mui.TextField()
      ..autoFocus = true
      ..variant = mui.TextFieldVariant.outlined
      ..size = mui.TextFieldSize.small
      ..fullWidth = true
      ..inputProps = (Dom.input()..size = props.initialValue.length)
      ..addProps(propsToForward)
      ..value = state.currentValue
      ..error = props.error || !_isValidValue
      ..helperText = _inputHelperText
      ..onKeyDown = _handleInputKeyDown
      ..onClick = (SyntheticMouseEvent event) {
        // Prevent the menu from closing when clicking inside the input
        event.stopPropagation();
      }
      ..onChange = (SyntheticFormEvent event) {
        setState(newState()..currentValue = event.target.value);
      })();
  }

  String get _trimmedValue => state.currentValue.trim();

  bool get _isValidValue {
    return _trimmedValue.isNotEmpty &&
        !TodoAppLocalStorage.reservedStateKeys.contains(_trimmedValue);
  }

  dynamic get _inputHelperText {
    if (props.helperText != null) return props.helperText;
    if (_isValidValue || _trimmedValue.isEmpty)
      return 'Press ENTER to save or ESC to cancel';

    return '$_trimmedValue is a reserved value';
  }

  void _handleInputKeyDown(SyntheticKeyboardEvent event) {
    // Prevent menu item autofocus based on the key entered matching the first letter of a menu item.
    event.stopPropagation();
    if (event.keyCode == KeyCode.ENTER && _isValidValue) {
      props.onSave(_trimmedValue);
    } else if (event.keyCode == KeyCode.ESC && props.onCancel != null) {
      props.onCancel(event);
    }
  }
}
