import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';
import 'package:over_react/src/component/test_fixtures/redraw_counter_component_mixin.dart';

import 'package:todo_client/src/actions.dart';
import 'package:todo_client/src/models/user.dart';
import 'package:todo_client/src/components/shared/avatar_with_colors.dart';
import 'package:todo_client/src/components/shared/list_item_expansion_panel_summary.dart';
import 'package:todo_client/src/components/shared/list_item_mixin.dart';
import 'package:react_material_ui/react_material_ui.dart';
import 'package:todo_client/src/components/shared/todo_item_text_field.dart';
import 'package:todo_client/src/components/task_count.dart';
import 'package:todo_client/src/store.dart';

part 'user_list_item.over_react.g.dart';

UiFactory<UserListItemProps> UserListItem = connect<AppState, UserListItemProps>(
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
)(_$UserListItem); // ignore: undefined_identifier

mixin UserListItemPropsMixin on UiProps, ListItemPropsMixin {
  @requiredProp
  @override
  User model;
}

class UserListItemProps = UiProps with ListItemPropsMixin, UserListItemPropsMixin;

mixin UserListItemStateMixin on UiState, ListItemStateMixin {
  @override
  User localModel;
}

class UserListItemState = UiState with ListItemStateMixin, UserListItemStateMixin;

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
      ...shrinkToFit,
      'ml': -1,
      'mr': 2,
      'alignSelf': 'center',
    },
      (TaskCountBadge()..user = model)(
        (AvatarWithColors()
          ..key = 'avatar'
          ..fullName = props.model.name
        )(),
      ),
    );
  }

  ReactElement _renderUserNameHeader() {
    return Box({
      ...grow,
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
          Box({...shrinkToFit},
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
        'title': 'Delete Todo'
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
    return (Button()
      ..size = ButtonSize.SMALL
      ..onClick = (_) { exitEditable(saveChanges: false); }
    )('Cancel');
  }

  ReactElement _renderEditableUserSaveButton() {
    return (Button()
      ..size = ButtonSize.SMALL
      ..onClick = (_) { exitEditable(saveChanges: true); }
      ..color = MuiColor.PRIMARY
    )('Save');
  }
}
