import 'dart:html';

import 'package:over_react/over_react.dart';

import 'package:todo_client/src/local_storage.dart';
import 'package:todo_client/src/components/app_bar/local_storage_menu_item_input.dart';
import 'package:todo_client/src/components/shared/hoverable_item_mixin.dart';
import 'package:react_material_ui/react_material_ui.dart';
import 'package:todo_client/src/components/shared/menu_overlay.dart';

part 'saved_data_menu_item.over_react.g.dart'; // ignore: uri_has_not_been_generated

UiFactory<SavedDataMenuItemProps> SavedDataMenuItem =
    castUiFactory(_$SavedDataMenuItem); // ignore: undefined_identifier

@Props(keyNamespace: '')
mixin SavedDataMenuItemProps on UiProps {
  @requiredProp
  String localStorageKey;
  @requiredProp
  Function(String localStorageKey) onSelect;
  @requiredProp
  Function(String localStorageKey) onDelete;
  @requiredProp
  Function(String localStorageKey) onRename;
}

mixin SavedDataMenuItemStateMixin on UiState {
  bool isEditable;
}

class SavedDataMenuItemState = UiState with MenuOverlayState, SavedDataMenuItemStateMixin, HoverableItemStateMixin;

class SavedDataMenuItemComponent extends UiStatefulComponent2<SavedDataMenuItemProps, SavedDataMenuItemState>
    with HoverableItemMixin<SavedDataMenuItemProps, SavedDataMenuItemState> {
  @override
  get itemNodeRef => createRef<Element>();

  @override
  get initialState => (newState()
    ..addAll(super.initialState)
    ..isEditable = false
  );

  @override
  Iterable<ConsumedProps> get consumedProps => [];

  @override
  render() {
    return (MenuItem()
        ..modifyProps(addUnconsumedProps)
        ..ref = itemNodeRef
        ..onClick = _handleMenuItemClick
        ..onMouseEnter = handleItemMouseEnter
        ..onMouseLeave = handleItemMouseLeave
        ..onFocus = handleChildFocus
        ..onBlur = handleChildBlur

    )(
      state.isEditable ? _renderRenameTextInput() : _renderNameWithOptions(),
    );
  }

  ReactElement _renderNameWithOptions() {
    return (Grid()
        ..container = true
        ..direction = GridDirection.ROW
        ..style = {'flexWrap': false}
    )(
      (Box()
          ..grow = true
          ..pr = 1
          ..justifyContent = 'center'
          ..display = 'flex'
      )(
        (Box()
            ..pr = 1
            ..display = 'flex'
            ..justifyContent = 'center'
        )(
          StorageIcon({
            'style': {'alignSelf': 'center'},
          }),
        ),
        (Typography()
            ..noWrap = true
            ..style = {
              'alignSelf': 'center',
              'flexGrow': 1,
            }
        )(
          props.localStorageKey,
        ),
      ),
      (IconButton()
          ..size = IconButtonSize.SMALL
          ..color = ButtonColor.INHERIT
          ..aria.label = 'Rename'
          ..aria.hidden = !isHovered
          ..className = 'hide-using-aria'
          ..onClick = (SyntheticMouseEvent event) {
            event.stopPropagation(); // Do not trigger the onClick handler of the parent MenuItem
            setState(newState()..isEditable = true);
          }
      )(
        EditPencilIcon(),
      ),
      _renderDeleteButton(),
    );
  }

  ReactElement _renderDeleteButton() {
    final isDisabled = localTodoAppStorage.currentStateJson['name'] == props.localStorageKey;

    return (Tooltip()
        ..enterDelay = 500
        ..title = isDisabled
            ? 'Cannot delete the currently loaded data set.'
            : 'Delete the ${props.localStorageKey} data set.'
    )(
      (Box()
          ..shrinkToFit = true
          ..color = 'error.main'
          ..aria.hidden = !isHovered
          ..className = 'hide-using-aria'
      )(
        (IconButton()
            ..size = IconButtonSize.SMALL
            ..color = ButtonColor.INHERIT
            ..aria.label = 'Delete'
            ..disabled = isDisabled
            ..onClick = (SyntheticMouseEvent event) {
              event.stopPropagation(); // Do not trigger the onClick handler of the parent MenuItem
              props.onDelete(props.localStorageKey);
            }
        )(
          TrashIcon(),
        ),
      ),
    );
  }

  ReactElement _renderRenameTextInput() {
    return (LocalStorageMenuItemInput()
      ..initialValue = props.localStorageKey
      ..onSave = (String newValue) {
        setState(newState()..isEditable = false, () {
          if (newValue != props.localStorageKey) {
            props.onRename(newValue);
          }
        });
      }
      ..onCancel = (SyntheticKeyboardEvent event) {
        // Prevent the entire menu from closing when the ESC key is pressed
        event.stopPropagation();
        setState(newState()..isEditable = false);
      }
    )();
  }

  void _handleMenuItemClick(_) {
    props.onSelect(props.localStorageKey);
  }
}
