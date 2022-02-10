import 'package:over_react/over_react.dart';
import 'package:react_material_ui/src/unstable_components.dart' as mui;

import 'package:todo_client/src/components/app_bar/local_storage_menu_item_input.dart';

part 'save_as_menu_item.over_react.g.dart';

UiFactory<SaveAsMenuItemProps> SaveAsMenuItem =
    castUiFactory(_$SaveAsMenuItem); // ignore: undefined_identifier

mixin SaveAsMenuItemProps on UiProps {
  String initialValue;
  @requiredProp
  Function(String newName) onSave;
}

mixin SaveAsMenuItemState on UiState {
  bool isEditable;
}

class SaveAsMenuItemComponent
    extends UiStatefulComponent2<SaveAsMenuItemProps, SaveAsMenuItemState> {
  @override
  get defaultProps => (newProps()..initialValue = '');

  @override
  get initialState => (newState()..isEditable = false);

  @override
  render() {
    return (mui.MenuItem()..onClick = _handleMenuItemClick)(
        state.isEditable ? _renderSaveAsTextInput() : 'Save As...');
  }

  ReactElement _renderSaveAsTextInput() {
    return (LocalStorageMenuItemInput()
      ..initialValue = props.initialValue
      ..onSave = (newValue) {
        props.onSave(newValue);
        setState(newState()..isEditable = false);
      })();
  }

  void _handleMenuItemClick(_) {
    if (!state.isEditable) {
      setState(newState()..isEditable = true);
    }
  }
}
