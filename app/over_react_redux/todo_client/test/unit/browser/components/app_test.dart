@TestOn('browser')
import 'dart:async';

import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';
import 'package:over_react_test/over_react_test.dart';
import 'package:test/test.dart';
import 'package:time/time.dart';

import 'package:todo_client/src/components/app.dart';
import 'package:todo_client/src/components/create_input.dart';
import 'package:todo_client/src/components/todo_list.dart';
import 'package:todo_client/src/components/user_list.dart';
import 'package:todo_client/src/models/todo.dart';
import 'package:todo_client/src/models/user.dart';

import 'fixtures/utils.dart';

main() {
  initializeComponentTests();

  group('ConnectedTodoApp', () {
    Ref<TodoAppComponent> componentRef;
    TodoAppComponent component;

    setUp(() {
      initializeTestStore();
      componentRef = createRef();
      mount((ReduxProvider()..store = testStore)(
        (TodoApp()..ref = componentRef)(),
      ));
      component = componentRef.current;
      expect(component, isNotNull, reason: 'ConnectedTodoApp should forward refs to the child TodoApp');
    });

    tearDown(() {
      componentRef = null;
      component = null;
    });

    group('renders a TodoApp', () {
      group('with prop callbacks mapped to the expected Redux action:', () {
        test('props.createTodo => AddTodoAction', () async {
          final todoAddedCompleter = Completer<Todo>();
          testStore.onChange.listen((newState) {
            todoAddedCompleter.complete(newState.todos.first);
          });
          component.props.createTodo('some description');
          final todoAdded = await todoAddedCompleter.future.timeout(10.milliseconds);
          expect(todoAdded.description, 'some description');
        });

        test('props.createUser => AddUserAction', () async {
          final userAddedCompleter = Completer<User>();
          testStore.onChange.listen((newState) {
            userAddedCompleter.complete(newState.users.first);
          });
          component.props.createUser('Joe Smith');
          final userAdded = await userAddedCompleter.future.timeout(10.milliseconds);
          expect(userAdded.name, 'Joe Smith');
        });
      });

      test('that does not rerender when AppState is updated', () async {
        component.props.createTodo('some description');
        final redrawCount = await component.didRedraw().future.timeout(20.milliseconds, onTimeout: () => 0);
        expect(redrawCount, 0);
      });

      group('that renders a CreateInput component for creating Todos', () {
        test('', () {
          final createInputInstance = getByTestId(component, 'todo_client.createTodoInput');
          expect(createInputInstance, isNotNull);
          expect(getDartComponent(createInputInstance), isA<CreateInputComponent>());

          final createInputProps = getDartComponent<CreateInputComponent>(createInputInstance).props;
          expect(createInputProps.autoFocus, isTrue);
          expect(createInputProps.label, 'New Todo');
          expect(createInputProps.placeholder, 'Create new Todo');
        });

        test('with a props.onCreate value that proxies props.createTodo', () async {
          CreateInputComponent createInputComponent = getComponentByTestId(component, 'todo_client.createTodoInput');
          final todoAddedCompleter = Completer<Todo>();
          testStore.onChange.listen((newState) {
            todoAddedCompleter.complete(newState.todos.first);
          });
          createInputComponent.props.onCreate('some description');
          final todoAdded = await todoAddedCompleter.future.timeout(10.milliseconds);
          expect(todoAdded.description, 'some description');
        });
      });

      test('that renders a ConnectedTodoList', () {
        final connectedTodoListInstance = getByTestId(component, 'todo_client.ConnectedTodoList');
        expect(connectedTodoListInstance, isNotNull);
        expect(getDartComponent(connectedTodoListInstance), isA<TodoListComponent>(),
            reason: 'ConnectedTodoList should forward refs to the child TodoList');
      });

      group('that renders a CreateInput component for creating Users', () {
        test('', () {
          final createInputInstance = getByTestId(component, 'todo_client.createUserInput');
          expect(createInputInstance, isNotNull);
          expect(getDartComponent(createInputInstance), isA<CreateInputComponent>());

          final createInputProps = getDartComponent<CreateInputComponent>(createInputInstance).props;
          expect(createInputProps.autoFocus, isFalse);
          expect(createInputProps.label, 'New User');
          expect(createInputProps.placeholder, 'Create new User');
        });

        test('with a props.onCreate value that proxies props.createUser', () async {
          CreateInputComponent createInputComponent = getComponentByTestId(component, 'todo_client.createUserInput');
          final userAddedCompleter = Completer<User>();
          testStore.onChange.listen((newState) {
            userAddedCompleter.complete(newState.users.first);
          });
          createInputComponent.props.onCreate('Joe Smith');
          final userAdded = await userAddedCompleter.future.timeout(10.milliseconds);
          expect(userAdded.name, 'Joe Smith');
        });
      });

      test('that renders a ConnectedUserList', () {
        final connectedUserListInstance = getByTestId(component, 'todo_client.ConnectedUserList');
        expect(connectedUserListInstance, isNotNull);
        expect(getDartComponent(connectedUserListInstance), isA<UserListComponent>(),
            reason: 'ConnectedUserList should forward refs to the child UserList');
      });
    });
  });
}
