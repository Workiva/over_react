import 'package:over_react/over_react.dart';

import 'package:todo_client/src/local_storage.dart';
import 'package:todo_client/src/components/app_bar/local_storage_menu_item_input.dart';
import 'package:todo_client/src/components/shared/hoverable_item_mixin.dart';
import 'package:todo_client/src/components/shared/material_ui.dart';
import 'package:todo_client/src/components/shared/menu_overlay.dart';

// ignore: uri_has_not_been_generated
part 'saved_data_menu_item.over_react.g.dart';

@Factory()
UiFactory<SavedDataMenuItemProps> SavedDataMenuItem =
    // ignore: undefined_identifier
    _$SavedDataMenuItem;

@Props(keyNamespace: '')
class _$SavedDataMenuItemProps extends UiProps {
  @requiredProp
  String localStorageKey;
  @requiredProp
  Function(String localStorageKey) onSelect;
  @requiredProp
  Function(String localStorageKey) onDelete;
  @requiredProp
  Function(String localStorageKey) onRename;
}

@State()
class _$SavedDataMenuItemState extends MenuOverlayState
    with HoverableItemStateMixin,
         // ignore: mixin_of_non_class, undefined_class
         $HoverableItemStateMixin {
  bool isEditable;
}

@Component2()
class SavedDataMenuItemComponent extends UiStatefulComponent2<SavedDataMenuItemProps, SavedDataMenuItemState>
    with HoverableItemMixin<SavedDataMenuItemProps, SavedDataMenuItemState> {
  @override
  get initialState => (newState()
    ..addAll(super.initialState)
    ..isEditable = false
  );

  @override
  render() {
    final propsToForward = Map.of(props)
      ..remove('localStorageKey')
      ..remove('onSelect')
      ..remove('onDelete')
      ..remove('onRename');

    return MenuItem({
      ...propsToForward,
      'onClick': _handleMenuItemClick,
      'onMouseEnter': handleItemMouseEnter,
      'onMouseLeave': handleItemMouseLeave,
      'onFocus': handleChildFocus,
      'onBlur': handleChildBlur,
    },
      state.isEditable ? _renderRenameTextInput() : _renderNameWithOptions(),
    );
  }

  ReactElement _renderNameWithOptions() {
    return Grid({'container': true, 'direction': 'row', 'style': {'flexWrap': false}},
      Box({...grow, 'pr': 1, 'justifyContent': 'center', 'display': 'flex'},
        Box({'pr': 1, 'display': 'flex', 'justifyContent': 'center'},
          StorageIcon({'style': {'alignSelf': 'center'}}),
        ),
        Typography({
          'noWrap': true,
          'style': {
            'alignSelf': 'center',
            'flexGrow': 1,
          }
        },
          props.localStorageKey,
        ),
      ),
      IconButton({
        'size': 'small',
        'color': 'inherit',
        'aria-label': 'Rename',
        'aria-hidden': !isHovered,
        'className': 'hide-using-aria',
        'onClick': (SyntheticMouseEvent event) {
          event.stopPropagation(); // Do not trigger the onClick handler of the parent MenuItem
          setState(newState()..isEditable = true);
        }
      },
        EditPencilIcon(),
      ),
      _renderDeleteButton(),
    );
  }

  ReactElement _renderDeleteButton() {
    final isDisabled = localTodoAppStorage.currentStateJson['name'] == props.localStorageKey;

    return Tooltip({
      'title': isDisabled
          ? 'Cannot delete the currently loaded data set.'
          : 'Delete the ${props.localStorageKey} data set.',
      'enterDelay': 500,
    },
      Box({
        ...shrinkToFit,
        'color': 'error.main',
        'aria-hidden': !isHovered,
        'className': 'hide-using-aria',
      },
        IconButton({
          'size': 'small',
          'color': 'inherit',
          'aria-label': 'Delete',
          'disabled': isDisabled,
          'onClick': (SyntheticMouseEvent event) {
            event.stopPropagation(); // Do not trigger the onClick handler of the parent MenuItem
            props.onDelete(props.localStorageKey);
          }
        },
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

// ignore: mixin_of_non_class, undefined_class
class SavedDataMenuItemProps extends _$SavedDataMenuItemProps with _$SavedDataMenuItemPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = _$metaForSavedDataMenuItemProps;
}

// ignore: mixin_of_non_class, undefined_class
class SavedDataMenuItemState extends _$SavedDataMenuItemState with _$SavedDataMenuItemStateAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const StateMeta meta = _$metaForSavedDataMenuItemState;
}
