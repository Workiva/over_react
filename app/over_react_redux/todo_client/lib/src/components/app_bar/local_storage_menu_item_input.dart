import 'dart:html';

import 'package:over_react/over_react.dart';

import 'package:todo_client/src/local_storage.dart';
import 'package:todo_client/src/components/shared/material_ui.dart';

// ignore: uri_has_not_been_generated
part 'local_storage_menu_item_input.over_react.g.dart';

@Factory()
UiFactory<LocalStorageMenuItemInputProps> LocalStorageMenuItemInput =
    // ignore: undefined_identifier
    _$LocalStorageMenuItemInput;

@Props(keyNamespace: '')
class _$LocalStorageMenuItemInputProps extends UiProps {
  String initialValue;
  bool error;
  dynamic helperText;
  @requiredProp
  Function(String value) onSave;
  Function(SyntheticKeyboardEvent event) onCancel;
}

@State()
class _$LocalStorageMenuItemInputState extends UiState {
  String currentValue;
}

@Component2()
class LocalStorageMenuItemInputComponent
    extends UiStatefulComponent2<LocalStorageMenuItemInputProps, LocalStorageMenuItemInputState> {
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

    return TextField({
      'autoFocus': true,
      'variant': 'outlined',
      'size': 'small',
      'fullWidth': true,
      'inputProps': {
        'size': props.initialValue.length,
      },
      ...propsToForward,
      'value': state.currentValue,
      'error': props.error || !_isValidValue,
      'helperText': _inputHelperText,
      'onKeyDown': _handleInputKeyDown,
      'onClick': (SyntheticMouseEvent event) {
        // Prevent the menu from closing when clicking inside the input
        event.stopPropagation();
      },
      'onChange': (SyntheticFormEvent event) {
        setState(newState()..currentValue = event.target.value);
      }
    });
  }

  String get _trimmedValue => state.currentValue.trim();

  bool get _isValidValue {
    return _trimmedValue.isNotEmpty && !TodoAppLocalStorage.reservedStateKeys.contains(_trimmedValue);
  }

  dynamic get _inputHelperText {
    if (props.helperText != null) return props.helperText;
    if (_isValidValue || _trimmedValue.isEmpty) return 'Press ENTER to save or ESC to cancel';

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

// ignore: mixin_of_non_class, undefined_class
class LocalStorageMenuItemInputProps extends _$LocalStorageMenuItemInputProps with _$LocalStorageMenuItemInputPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = _$metaForLocalStorageMenuItemInputProps;
}

// ignore: mixin_of_non_class, undefined_class
class LocalStorageMenuItemInputState extends _$LocalStorageMenuItemInputState with _$LocalStorageMenuItemInputStateAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const StateMeta meta = _$metaForLocalStorageMenuItemInputState;
}
