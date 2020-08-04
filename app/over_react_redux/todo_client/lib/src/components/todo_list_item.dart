import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';
import 'package:over_react/src/component/test_fixtures/redraw_counter_component_mixin.dart';

import 'package:todo_client/src/actions.dart';
import 'package:todo_client/src/models/todo.dart';
import 'package:todo_client/src/components/shared/list_item_expansion_panel_summary.dart';
import 'package:todo_client/src/components/shared/list_item_mixin.dart';
import 'package:react_material_ui/react_material_ui.dart';
import 'package:todo_client/src/components/shared/redraw_counter_component_mixin.dart';
import 'package:todo_client/src/components/shared/todo_item_text_field.dart';
import 'package:todo_client/src/components/user_selector.dart';
import 'package:todo_client/src/store.dart';

part 'todo_list_item.over_react.g.dart';

UiFactory<TodoListItemProps> TodoListItem = connect<AppState, TodoListItemProps>(
  mapDispatchToProps: (dispatch) {
    return (TodoListItem()
      ..onSelect = (id) { dispatch(SelectTodoAction(id)); }
      ..onDeselect = (id) { dispatch(DeselectTodoAction(id)); }
      ..onBeginEdit = (id) { dispatch(BeginEditTodoAction(id)); }
      ..onFinishEdit = (id) { dispatch(FinishEditTodoAction(id)); }
      ..onModelUpdate = (todo) { dispatch(UpdateTodoAction(todo)); }
      ..onRemove = (id) { dispatch(RemoveTodoAction(id)); }
    );
  },
  mapStateToPropsWithOwnProps: (state, ownProps) {
    final isEditable = state.editableTodoIds.contains(ownProps.model.id);
    final isSelected = isEditable || state.selectedTodoIds.contains(ownProps.model.id);
    final isHighlighted = state.highlightedTodoIds.contains(ownProps.model.id);

    return (TodoListItem()
      ..isSelected = isSelected
      ..isEditable = isEditable
      ..isHighlighted = isHighlighted
    );
  },
)(_$TodoListItem); // ignore: undefined_identifier

mixin TodoListItemPropsMixin on UiProps, ListItemPropsMixin {
  @requiredProp
  @override
  Todo model;
}

class TodoListItemProps = UiProps with ListItemPropsMixin, TodoListItemPropsMixin;

mixin TodoListItemStateMixin on UiState, ListItemStateMixin {
  @override
  Todo localModel;
}

class TodoListItemState = UiState with ListItemStateMixin, TodoListItemStateMixin;


class TodoListItemComponent extends UiStatefulComponent2<TodoListItemProps, TodoListItemState>
    with ListItemMixin<Todo, TodoListItemProps, TodoListItemState>, RedrawCounterMixin {
  @override
  bool get hasDetails => model.notes != null && model.notes.isNotEmpty;

  @override
  render() {
    return ExpansionPanel({
      ...sharedExpansionPanelProps,
      'className': model.isCompleted ? 'Mui-disabled' : null,
    },
      (ListItemExpansionPanelSummary()
        ..modelId = model.id
        ..allowExpansion = allowExpansion
        ..isEditable = props.isEditable
        ..onToggleEditable = toggleEditable
      )(
        _renderTaskCheckbox(),
        _renderTaskHeader(),
        _renderUserSelector(),
      ),
      ExpansionPanelDetails({},
        _renderTaskNotes(),
      ),
      _renderEditableTaskActions(),
    );
  }

  ReactElement _renderTaskCheckbox() {
    return Box({
      ...shrinkToFit,
      'ml': -2,
      'mr': 1,
      'alignSelf': 'center',
    },
      Tooltip({
        'enterDelay': 500,
        'title': model.isCompleted ? 'Mark as not completed' : 'Mark as completed',
      },
        Checkbox({
          'checked': model.isCompleted,
          'inputProps': {
            'aria-label': 'Complete Task',
          },
          'value': 'isCompleted',
          'onChange': (_) { updateModel(Todo.from(model)..isCompleted = !model.isCompleted); },
          'onClick': (SyntheticEvent e) { e.stopPropagation(); },
          'onFocus': (SyntheticEvent e) { e.stopPropagation(); },
        }),
      ),
    );
  }

  ReactElement _renderTaskHeader() {
    return Box({
      ...grow,
      'key': 'taskHeader',
      'mr': 1,
      'alignSelf': 'center',
    },
      (TodoItemTextField()
        ..readOnly = !props.isEditable
        ..autoFocus = props.isEditable
        ..label = 'Description'
        ..onChange = _updateDescriptionValue
        ..placeholder = 'Describe the task...'
        ..value = model.description
        ..onClickWhenEditable = (event) { event.stopPropagation(); }
        ..addTestId('todo_client.TodoListItem.descriptionTextField')
        ..['inputProps'] = {
          'style': props.isEditable ? null : {
            'cursor': allowExpansion ? 'pointer' : 'default',
          },
        }
      )(),
    );
  }

  void _updateDescriptionValue(SyntheticFormEvent event) {
    InputElement target = event.target;
    updateModel(Todo.from(model)..description = target.value);
  }

  ReactElement _renderUserSelector() {
    return Box({
      ...shrinkToFit,
      'alignSelf': 'center',
    },
      (UserSelector()
        ..selectedUserId = model.assignedUserId
        ..onUserSelect = (userId) { updateModel(Todo.from(model)..assignedUserId = userId); }
        ..addTestId('todo_client.TodoListItem.ConnectedUserSelector')
      )(),
    );
  }

  ReactElement _renderTaskNotes() {
    return (TodoItemTextField()
      ..readOnly = !props.isEditable
      ..label = 'Notes'
      ..multiline = true
      ..['rows'] = 3
      ..onChange = _updateNoteValue
      ..placeholder = 'Add some notes about the task'
      ..value = model.notes
      ..addTestId('todo_client.TodoListItem.notesTextField')
    )();
  }

  void _updateNoteValue(SyntheticFormEvent event) {
    TextAreaElement target = event.target;
    updateModel(Todo.from(model)..notes = target.value);
  }

  ReactElement _renderEditableTaskActions() {
    if (!props.isEditable) return null;

    return Fragment()(
      Divider({}),
      ExpansionPanelActions({},
        Grid({
          'container': true,
          'direction': 'row'
        },
          Box({
            'flexGrow': 1,
            'display': 'flex'
          },
            _renderEditableTaskDeleteButton(),
            _renderEditableTaskPrivacyToggleButton(),
          ),
          Box({...shrinkToFit},
            _renderEditableTaskCancelButton(),
            _renderEditableTaskSaveButton(),
          ),
        ),
      ),
    );
  }

  ReactElement _renderEditableTaskDeleteButton() {
    return Tooltip({
      'enterDelay': 500,
      'title': 'Delete Todo',
    },
      Box({'color': 'error.main'},
        IconButton({
          'size': 'small',
          'aria-label': 'delete todo',
          'color': 'inherit',
          'disabled': model.isCompleted,
          'onClick': (_) { remove(); },
        },
          TrashIcon(),
        ),
      ),
    );
  }

  ReactElement _renderEditableTaskPrivacyToggleButton() {
    final tooltipTitle = model.isPublic ? 'Make Private' : 'Make Public';

    return Tooltip({
      'enterDelay': 500,
      'title': tooltipTitle,
    },
      IconButton({
        'size': 'small',
        'aria-label': model.isPublic ? 'Make Private' : 'Make Public',
        'onClick': (_) { updateModel(Todo.from(model)..isPublic = !model.isPublic); },
      },
        model.isPublic ? VisibilityIcon() : VisibilityOffIcon(),
      ),
    );
  }

  ReactElement _renderEditableTaskCancelButton() {
    return Button({
      'size': 'small',
      'onClick': (_) { exitEditable(saveChanges: false); },
    }, 'Cancel');
  }

  ReactElement _renderEditableTaskSaveButton() {
    return Button({
      'size': 'small',
      'color': 'primary',
      'onClick': (_) { exitEditable(saveChanges: true); },
    }, 'Save');
  }
}
