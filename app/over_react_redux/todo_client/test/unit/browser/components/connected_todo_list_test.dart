// @dart=2.7
// ^ Do not remove until migrated to null safety. More info at https://wiki.atl.workiva.net/pages/viewpage.action?pageId=189370832
@TestOn('browser')
import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';
import 'package:over_react_test/over_react_test.dart';
import 'package:test/test.dart';
import 'package:time/time.dart';

import 'package:todo_client/src/actions.dart';
import 'package:todo_client/src/components/app.dart';
import 'package:todo_client/src/components/shared/display_list.dart';
import 'package:todo_client/src/components/shared/empty_view.dart';
import 'package:todo_client/src/components/todo_list.dart';
import 'package:todo_client/src/components/todo_list_item.dart';
import 'package:todo_client/src/local_storage.dart';
import 'package:todo_client/src/models/todo.dart';

import 'fixtures/utils.dart';

main() {
  initializeComponentTests();

  group('ConnectedTodoList', () {
    Ref<TodoAppComponent> appRef;
    TodoListComponent component;
    TestJacket jacket;

    setUp(() {
      initializeTestStore();
      appRef = createRef();
      jacket = mount((ReduxProvider()..store = testStore)(
        (TodoApp()..ref = appRef)(),
      ));
      final appComponent = appRef.current;
      component = getComponentByTestId(appComponent, 'todo_client.ConnectedTodoList');
      expect(component, isA<TodoListComponent>(), reason: 'test setup sanity check');
    });

    tearDown(() {
      appRef = null;
      component = null;
      jacket = null;
    });

    group('renders a TodoList', () {
      group('with props.todos mapped to AppState.todos', () {
        test('initially', () {
          expect(component.props.todos, testStore.state.todos);
        });

        test('when AppState.todos is updated', () async {
          final newTodo = Todo(description: 'foo');
          testStore.dispatch(AddTodoAction(newTodo));
          final redrawCount = await component.didRedraw().future.timeout(20.milliseconds);
          expect(component.props.todos.first.toJson(), newTodo.toJson());
          expect(redrawCount, 1);
        });
      });

      group('with ConnectedTodoListItems for each todo in the model within a DisplayList', () {
        dynamic displayListInstance;
        setUp(() {
          displayListInstance = getByTestId(component, 'todo_client.TodoList.DisplayList');
          expect(displayListInstance, isNotNull);
          expect(getDartComponent(displayListInstance), isA<DisplayListComponent>());
          expect(component.props.todos, isNotEmpty, reason: 'test setup sanity check');
        });

        tearDown(() {
          displayListInstance = null;
        });

        test('', () {
          for (var todo in component.props.todos) {
            final listItemComponent = getComponentByTestId(displayListInstance, 'todo_client.TodoListItem.${todo.id}');
            expect(listItemComponent, isA<TodoListItemComponent>());
            TodoListItemProps props = listItemComponent.props;
            expect(props.model, todo);
          }
        });

        test('unless props.todos is empty', () {
          initializeTestStore(TodoAppLocalStorage.emptyState);
          jacket.rerender((ReduxProvider()..store = testStore)(
            (TodoApp()..ref = appRef)(),
          ));
          expect(testStore.state.todos, isEmpty, reason: 'test setup sanity check');

          expect(findDomNode(displayListInstance).children, hasLength(1));
          expect(getComponentByTestId(displayListInstance, 'todo_client.DisplayList.EmptyView'),
              isA<EmptyViewComponent>());
        });
      });
    });
  });
}
