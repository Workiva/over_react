import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';
// ignore: implementation_imports
import 'package:over_react/src/component/test_fixtures/redraw_counter_component_mixin.dart';
import 'package:react_material_ui/react_material_ui.dart';

import 'package:todo_client/src/actions.dart';
import 'package:todo_client/src/components/app_bar/app_bar_theme_menu.dart';
import 'package:todo_client/src/store.dart';
import 'package:todo_client/src/models/todo.dart';
import 'package:todo_client/src/models/user.dart';
import 'package:todo_client/src/components/app_bar/app_bar.dart';
import 'package:todo_client/src/components/create_input.dart';
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
      });
  },
  mapStateToProps: (state) {
    return TodoApp()..theme = state.theme;
  },
  forwardRef: true,
)(_$TodoApp); // ignore: undefined_identifier

mixin TodoAppPropsMixin on UiProps {
  Function(String description) createTodo;

  Function(String name) createUser;

  String theme;
}

class TodoAppProps = UiProps with TodoAppPropsMixin, ConnectPropsMixin;

class TodoAppComponent extends UiComponent2<TodoAppProps>
    with RedrawCounterMixin {
  MuiTheme get _neonTheme => MuiTheme({
        'palette': {
          'background': {'paper': '#5ec230', 'default': '#7930c2'},
          'primary': {'main': '#e834eb'},
          'secondary': {
            'main': '#34ebe5',
          },
        },
      });

  @override
  render() {
    return (ThemeProvider()..theme = getOuterTheme())(Fragment()(
      TodoAppBar()(),
      (Box()..className = 'app-content')(
        CssBaseline()(),
        (Container()..className = 'app-content__container')(
          (Grid()
            ..container = true
            ..direction = GridDirection.ROW
            ..spacing = GridSpacing.THREE
            ..className = 'app-content__container-grid')(
            renderTodosColumn(),
            (ThemeProvider()..theme = getInnerTheme())(renderUsersColumn()),
          ),
        ),
      ),
    ));
  }

  MuiTheme getInnerTheme() {
    if (props.theme == AppTheme.typography) {
      return MuiTheme({
        'typography': {'fontFamily': 'Impact', 'fontSize': 18}
      });
    } else if (props.theme == AppTheme.neonColors) {
      final neonInnerTheme = _neonTheme;
      neonInnerTheme.palette.background.paper = '#ff6ec7';

      return neonInnerTheme;
    }
    // default theme
    return MuiTheme({});
  }

  MuiTheme getOuterTheme() {
    if (props.theme == AppTheme.typography) {
      return MuiTheme({
        'typography': {'fontFamily': 'Comic Sans MS'}
      });
    } else if (props.theme == AppTheme.neonColors) {
      return _neonTheme;
    }
    // default theme
    return MuiTheme({});
  }

  ReactElement renderTodosColumn() {
    return (Grid()
      ..container = true
      ..item = true
      ..sm = GridNum.EIGHT
      ..direction = GridDirection.COLUMN
      ..alignItems = GridAlignItems.STRETCH
      ..style = {'height': '100%'})(
      (CreateInput()
        ..autoFocus = true
        ..label = 'New Todo'
        ..placeholder = 'Create new Todo'
        ..onCreate = props.createTodo
        ..addTestId('todo_client.createTodoInput'))(),
      (TodoList()..addTestId('todo_client.ConnectedTodoList'))(),
    );
  }

  ReactElement renderUsersColumn() {
    return (Grid()
      ..container = true
      ..item = true
      ..sm = GridNum.FOUR
      ..direction = GridDirection.COLUMN
      ..style = {'height': '100%'})(
      (CreateInput()
        ..label = 'New User'
        ..placeholder = 'Create new User'
        ..onCreate = props.createUser
        ..addTestId('todo_client.createUserInput'))(),
      (UserList()..addTestId('todo_client.ConnectedUserList'))(),
    );
  }
}
