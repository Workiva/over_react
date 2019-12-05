import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';

import 'package:todo_client/src/actions.dart';
import 'package:todo_client/src/store.dart';
import 'package:todo_client/src/models/todo.dart';
import 'package:todo_client/src/models/user.dart';
import 'package:todo_client/src/components/app_bar/app_bar.dart';
import 'package:todo_client/src/components/create_input.dart';
import 'package:todo_client/src/components/shared/material_ui.dart';
import 'package:todo_client/src/components/todo_list.dart';
import 'package:todo_client/src/components/user_list.dart';

// ignore: uri_has_not_been_generated
part 'app.over_react.g.dart';

UiFactory<TodoAppProps> ConnectedTodoApp = connect<AppState, TodoAppProps>(
    mapDispatchToProps: (dispatch) {
      return (TodoApp()
        ..createTodo = (description) {
          dispatch(AddTodoAction(Todo(description: description)));
        }
        ..createUser = (name) {
          dispatch(AddUserAction(User(name: name)));
        }
      );
    },
)(TodoApp);

@Factory()
UiFactory<TodoAppProps> TodoApp =
    // ignore: undefined_identifier
    _$TodoApp;

@Props()
class _$TodoAppProps extends UiProps with ConnectPropsMixin {
  Function(String description) createTodo;

  Function(String name) createUser;
}

@Component2()
class TodoAppComponent extends UiComponent2<TodoAppProps> {
  @override
  render() {
    return Fragment()(
      (TodoAppBar()..key = 'appBar')(),
      Box({
        'key': 'appContent',
        'className': 'app-content',
      }, [
        CssBaseline({'key': 'cssBaseline'}),
        Container({'key': 'container', 'maxWidth': 'lg', 'className': 'app-content__container'},
          Grid({'container': true, 'direction': 'row', 'spacing': 3, 'className': 'app-content__container-grid'}, [
            renderTodosColumn(),
            renderUsersColumn(),
          ]),
        ),
      ])
    );
  }

  ReactElement renderTodosColumn() {
    return Grid(
      {
        'key': 'todos',
        'container': true,
        'item': true,
        'sm': 8,
        'direction': 'column',
        'alignItems': 'stretch',
        'style': {'height': '100%'},
      },
      [
        (CreateInput()
          ..key = 'todoInput'
          ..autoFocus = true
          ..label = 'New Todo'
          ..placeholder = 'Create new Todo'
          ..onCreate = props.createTodo
        )(),
        (ConnectedTodoList()..key = 'todoList')(),
      ],
    );
  }

  ReactElement renderUsersColumn() {
    return Grid(
      {
        'key': 'users',
        'container': true,
        'item': true,
        'sm': 4,
        'direction': 'column',
        'style': {'height': '100%'},
      },
      [
        (CreateInput()
          ..key = 'userInput'
          ..label = 'New User'
          ..placeholder = 'Create new user'
          ..onCreate = props.createUser
        )(),
        (ConnectedUserList()..key = 'userList')(),
      ],
    );
  }
}

// ignore: mixin_of_non_class, undefined_class
class TodoAppProps extends _$TodoAppProps with _$TodoAppPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = _$metaForTodoAppProps;
}
