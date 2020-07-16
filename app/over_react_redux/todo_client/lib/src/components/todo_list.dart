import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';
import 'package:over_react/src/component/test_fixtures/redraw_counter_component_mixin.dart';

import 'package:todo_client/src/store.dart';
import 'package:todo_client/src/models/todo.dart';
import 'package:todo_client/src/components/shared/display_list.dart';
import 'package:todo_client/src/components/todo_list_item.dart';

part 'todo_list.over_react.g.dart';

UiFactory<TodoListProps> TodoList = connect<AppState, TodoListProps>(
    mapStateToProps: (state) {
      return (TodoList()
        ..todos = state.todos
      );
    },
    forwardRef: true,
)(_$TodoList); // ignore: undefined_identifier

mixin TodoListPropsMixin on UiProps {
  @requiredProp
  List<Todo> todos;
}

class TodoListProps = UiProps with TodoListPropsMixin, ConnectPropsMixin;

class TodoListComponent extends UiComponent2<TodoListProps> with RedrawCounterMixin {
  @override
  render() {
    return (DisplayList()
      ..listItemTypeDescription = 'todos'
      ..addTestId('todo_client.TodoList.DisplayList')
    )(
      props.todos.map(_renderItem).toList(),
    );
  }

  ReactElement _renderItem(Todo todo) {
    return (TodoListItem()
      ..key = todo.id
      ..model = todo
      ..addTestId('todo_client.TodoListItem.${todo.id}')
    )();
  }
}
