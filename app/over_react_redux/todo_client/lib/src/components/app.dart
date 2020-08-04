import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';
import 'package:over_react/src/component/test_fixtures/redraw_counter_component_mixin.dart';

import 'package:todo_client/src/actions.dart';
import 'package:todo_client/src/store.dart';
import 'package:todo_client/src/models/todo.dart';
import 'package:todo_client/src/models/user.dart';
import 'package:todo_client/src/components/app_bar/app_bar.dart';
import 'package:todo_client/src/components/create_input.dart';
import 'package:react_material_ui/react_material_ui.dart';
import 'package:todo_client/src/components/todo_list.dart';
import 'package:todo_client/src/components/user_list.dart';

part 'app.over_react.g.dart';

UiFactory<TodoAppProps> TodoApp = connect<AppState, TodoAppProps>(
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
    forwardRef: true,
)(_$TodoApp); // ignore: undefined_identifier

mixin TodoAppPropsMixin on UiProps {
  Function(String description) createTodo;

  Function(String name) createUser;
}

class TodoAppProps = UiProps with TodoAppPropsMixin, ConnectPropsMixin;

class TodoAppComponent extends UiComponent2<TodoAppProps> with RedrawCounterMixin {
  @override
  render() {
    return Fragment()(
      TodoAppBar()(),
      Box({'className': 'app-content'},
        CssBaseline({}),
        Container({
          'maxWidth': 'lg',
          'className': 'app-content__container'
        },
          Grid({
            'container': true,
            'direction': 'row',
            'spacing': 3,
            'className': 'app-content__container-grid'
          },
            renderTodosColumn(),
            renderUsersColumn(),
          ),
        ),
      ),
    );
  }

  ReactElement renderTodosColumn() {
    return Grid({
      'container': true,
      'item': true,
      'sm': 8,
      'direction': 'column',
      'alignItems': 'stretch',
      'style': {'height': '100%'},
    },
      (CreateInput()
        ..autoFocus = true
        ..label = 'New Todo'
        ..placeholder = 'Create new Todo'
        ..onCreate = props.createTodo
        ..addTestId('todo_client.createTodoInput')
      )(),
      (TodoList()..addTestId('todo_client.ConnectedTodoList'))(),
    );
  }

  ReactElement renderUsersColumn() {
    return Grid({
      'container': true,
      'item': true,
      'sm': 4,
      'direction': 'column',
      'style': {'height': '100%'},
    },
      (CreateInput()
        ..label = 'New User'
        ..placeholder = 'Create new User'
        ..onCreate = props.createUser
        ..addTestId('todo_client.createUserInput')
      )(),
      (UserList()..addTestId('todo_client.ConnectedUserList'))(),
    );
  }
}
