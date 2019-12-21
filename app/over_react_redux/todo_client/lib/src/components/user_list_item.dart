import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';
import 'package:todo_client/src/actions.dart';
import 'package:todo_client/src/components/shared/redraw_counter_component_mixin.dart';

import 'package:todo_client/src/models/user.dart';
import 'package:todo_client/src/components/shared/avatar_with_colors.dart';
import 'package:todo_client/src/components/shared/list_item_expansion_panel_summary.dart';
import 'package:todo_client/src/components/shared/list_item_mixin.dart';
import 'package:todo_client/src/components/shared/material_ui.dart';
import 'package:todo_client/src/components/shared/todo_item_text_field.dart';
import 'package:todo_client/src/components/task_count.dart';
import 'package:todo_client/src/store.dart';

// ignore: uri_has_not_been_generated
part 'user_list_item.over_react.g.dart';

UiFactory<UserListItemProps> ConnectedUserListItem = connect<AppState, UserListItemProps>(
  mapDispatchToProps: (dispatch) {
    return (UserListItem()
      ..onSelect = (id) { dispatch(SelectUserAction(id)); }
      ..onDeselect = (id) { dispatch(DeselectUserAction(id)); }
      ..onBeginEdit = (id) { dispatch(BeginEditUserAction(id)); }
      ..onFinishEdit = (id) { dispatch(FinishEditUserAction(id)); }
      ..onModelUpdate = (user) { dispatch(UpdateUserAction(user)); }
      ..onRemove = (id) { dispatch(RemoveUserAction(id)); }
    );
  },
  mapStateToPropsWithOwnProps: (state, ownProps) {
    final isEditable = state.editableUserIds.contains(ownProps.model.id);
    final isSelected = isEditable || state.selectedUserIds.contains(ownProps.model.id);
    final isHighlighted = state.highlightedUserIds.contains(ownProps.model.id);

    return (UserListItem()
      ..isSelected = isSelected
      ..isEditable = isEditable
      ..isHighlighted = isHighlighted
    );
  },
)(UserListItem);

@Factory()
UiFactory<UserListItemProps> UserListItem =
    // ignore: undefined_identifier
    _$UserListItem;

@Props()
class _$UserListItemProps extends UiProps
    with ListItemPropsMixin,
         // ignore: mixin_of_non_class, undefined_class
         $ListItemPropsMixin {
  @requiredProp
  @override
  User model;
}

@State()
class _$UserListItemState extends UiState
    with ListItemStateMixin,
         // ignore: mixin_of_non_class, undefined_class
         $ListItemStateMixin {
  @override
  User localModel;
}

@Component2()
class UserListItemComponent extends UiStatefulComponent2<UserListItemProps, UserListItemState>
    with ListItemMixin<User, UserListItemProps, UserListItemState>, RedrawCounterMixin {
  @override
  bool get hasDetails => model.bio != null && model.bio.isNotEmpty;

  @override
  render() {
    return ExpansionPanel(sharedExpansionPanelProps,
      (ListItemExpansionPanelSummary()
        ..modelId = model.id
        ..allowExpansion = allowExpansion
        ..isEditable = props.isEditable
        ..onToggleEditable = toggleEditable
      )(
        _renderUserAvatar(),
        _renderUserNameHeader(),
      ),
      ExpansionPanelDetails({},
        _renderUserBio(),
      ),
      _renderEditableUserActions(),
    );
  }

  ReactElement _renderUserAvatar() {
    return Box({
      ...shrinkToFitProps,
      'ml': -1,
      'mr': 2,
      'alignSelf': 'center',
    },
      (ConnectedTaskCountBadge()..user = model)(
        (AvatarWithColors()
          ..key = 'avatar'
          ..fullName = props.model.name
        )(),
      ),
    );
  }

  ReactElement _renderUserNameHeader() {
    return Box({
      ...growProps,
      'mr': 1,
      'alignSelf': 'center',
    },
      (TodoItemTextField()
        ..readOnly = !props.isEditable
        ..autoFocus = props.isEditable
        ..label = 'Name'
        ..onChange = _updateNameValue
        ..placeholder = 'Enter a name...'
        ..value = model.name
        ..onClickWhenEditable = (event) { event.stopPropagation(); }
        ..['inputProps'] = {
          'style': props.isEditable ? null : {
            'cursor': allowExpansion ? 'pointer' : 'default',
          },
        }
      )(),
    );
  }

  void _updateNameValue(SyntheticFormEvent event) {
    InputElement target = event.target;
    updateModel(User.from(model)..name = target.value);
  }

  ReactElement _renderUserBio() {
    return (TodoItemTextField()
      ..readOnly = !props.isEditable
      ..label = 'Biography'
      ..multiline = true
      ..['rows'] = 3
      ..onChange = _updateBioValue
      ..placeholder = 'Tell us a little bit about ${model.name}'
      ..value = model.bio
    )();
  }

  void _updateBioValue(SyntheticFormEvent event) {
    TextAreaElement target = event.target;
    updateModel(User.from(model)..bio = target.value);
  }

  ReactElement _renderEditableUserActions() {
    if (!props.isEditable) return null;

    return Fragment()(
      Divider({}),
      ExpansionPanelActions({},
        Grid({
          'container': true,
          'direction': 'row',
        },
          Box({
            'flexGrow': 1,
            'display': 'flex',
          },
            _renderEditableUserDeleteButton(),
          ),
          Box({...shrinkToFitProps},
            _renderEditableUserCancelButton(),
            _renderEditableUserSaveButton(),
          ),
        ),
      ),
    );
  }

  ReactElement _renderEditableUserDeleteButton() {
    return Tooltip({
      'enterDelay': 500,
      'title': 'Delete Todo',
    },
      Box({'color': 'error.main'},
        IconButton({
          'size': 'small',
          'aria-label': 'delete todo',
          'color': 'inherit',
          'onClick': (_) { remove(); },
        },
          TrashIcon(),
        ),
      ),
    );
  }

  ReactElement _renderEditableUserCancelButton() {
    return Button({
      'size': 'small',
      'onClick': (_) { exitEditable(saveChanges: false); },
    }, 'Cancel');
  }

  ReactElement _renderEditableUserSaveButton() {
    return Button({
      'size': 'small',
      'color': 'primary',
      'onClick': (_) { exitEditable(saveChanges: true); },
    }, 'Save');
  }
}

// ignore: mixin_of_non_class, undefined_class
class UserListItemProps extends _$UserListItemProps with _$UserListItemPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = _$metaForUserListItemProps;
}

// ignore: mixin_of_non_class, undefined_class
class UserListItemState extends _$UserListItemState with _$UserListItemStateAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const StateMeta meta = _$metaForUserListItemState;
}
