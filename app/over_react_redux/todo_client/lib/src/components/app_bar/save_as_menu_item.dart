import 'package:over_react/over_react.dart';

import 'package:todo_client/src/components/app_bar/local_storage_menu_item_input.dart';
import 'package:todo_client/src/components/shared/material_ui.dart';

// ignore: uri_has_not_been_generated
part 'save_as_menu_item.over_react.g.dart';

@Factory()
UiFactory<SaveAsMenuItemProps> SaveAsMenuItem =
    // ignore: undefined_identifier
    _$SaveAsMenuItem;

@Props()
class _$SaveAsMenuItemProps extends UiProps {
  String initialValue;
  @requiredProp
  Function(String newName) onSave;
}

@State()
class _$SaveAsMenuItemState extends UiState {
  bool isEditable;
}

@Component2()
class SaveAsMenuItemComponent extends UiStatefulComponent2<SaveAsMenuItemProps, SaveAsMenuItemState> {
  @override
  get defaultProps => (newProps()..initialValue = '');

  @override
  get initialState => (newState()..isEditable = false);

  @override
  render() {
    return MenuItem({
      'onClick': _handleMenuItemClick,
      'style': {'minWidth': '300px'}
    },
      state.isEditable ? _renderSaveAsTextInput() : 'Save As...'
    );
  }

  ReactElement _renderSaveAsTextInput() {
    return (LocalStorageMenuItemInput()
      ..initialValue = props.initialValue
      ..onSave = (newValue) {
        if (newValue != props.initialValue) {
          props.onSave(newValue);
        }
        setState(newState()..isEditable = false);
      }
    )();
  }

  void _handleMenuItemClick(_) {
    if (!state.isEditable) {
      setState(newState()..isEditable = true);
    }
  }
}

// ignore: mixin_of_non_class, undefined_class
class SaveAsMenuItemProps extends _$SaveAsMenuItemProps with _$SaveAsMenuItemPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = _$metaForSaveAsMenuItemProps;
}

// ignore: mixin_of_non_class, undefined_class
class SaveAsMenuItemState extends _$SaveAsMenuItemState with _$SaveAsMenuItemStateAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const StateMeta meta = _$metaForSaveAsMenuItemState;
}
