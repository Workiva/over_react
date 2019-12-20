@TestOn('browser')
import 'dart:convert';
import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';
import 'package:redux/redux.dart';
import 'package:test/test.dart';

import 'package:todo_client/src/actions.dart';
import 'package:todo_client/src/components/app.dart';
import 'package:todo_client/src/local_storage.dart';
import 'package:todo_client/src/models/base_model.dart';
import 'package:todo_client/src/models/todo.dart';
import 'package:todo_client/src/models/user.dart';
import 'package:todo_client/src/store.dart';

import '../../fixtures/mock_app_state_data.dart';

main() {
  setClientConfiguration();
  Store<AppState> testStore;

  Store<AppState> initializeTestStore() {
    return testStore = Store<AppState>(
      appStateReducer,
      initialState: initializeState(),
    );
  }

  String getLocalStorage() => window.localStorage[TodoAppLocalStorage.localStorageKey];

  Iterable<Map<String, dynamic>> getSerializedListOfModels(List<BaseModel> models) {
    models.map((model) => model.toJson());
  }

  group('AppState', () {
    setUp(() {
      expect(TodoAppLocalStorage.isInitialized(), isFalse, reason: 'test setup sanity check');
      initializeTestStore();
    });

    tearDown(() {
      testStore = null;
      localTodoAppStorage = null;
      window.localStorage[TodoAppLocalStorage.localStorageKey] = '';
    });

    test('requires a name', () {
      expect(() => AppState(null), throwsA(TypeMatcher<AssertionError>()));
      expect(() => AppState(''), throwsA(TypeMatcher<AssertionError>()));
    });

    group('fromJson()', () {
      test('does not throw', () {
        expect(() => AppState.fromJson(defaultAppState), returnsNormally);
      });
    });

    group('initializes via initialState with data', () {
      group('from defaultAppState when window.localStorage[${TodoAppLocalStorage.localStorageKey}] is unset', () {
        test('', () {
          final mockDefaultAppState = AppState.fromJson(defaultAppState);

          expect(getSerializedListOfModels(testStore.state.todos),
              getSerializedListOfModels(mockDefaultAppState.todos));
          expect(getSerializedListOfModels(testStore.state.users),
              getSerializedListOfModels(mockDefaultAppState.users));
          expect(testStore.state.selectedTodoIds, mockDefaultAppState.selectedTodoIds);
          expect(testStore.state.editableTodoIds, mockDefaultAppState.editableTodoIds);
          expect(testStore.state.highlightedTodoIds, mockDefaultAppState.highlightedTodoIds);
          expect(testStore.state.selectedUserIds, mockDefaultAppState.selectedUserIds);
          expect(testStore.state.editableUserIds, mockDefaultAppState.editableUserIds);
          expect(testStore.state.highlightedUserIds, mockDefaultAppState.highlightedUserIds);
        });

        test('and then initializes / persists the data to window.localStorage', () {
          expect(getLocalStorage(), isNotNull);

          final localStorageJson = json.decode(getLocalStorage());
          expect(localStorageJson['current'], defaultAppState);
          expect(localStorageJson['default'], defaultAppState);
          expect(localStorageJson['empty'], TodoAppLocalStorage.emptyState.toJson());
        });
      });

      group('from the "current" localStorage data set', () {
        setUp(() {
          expect(json.decode(getLocalStorage())['current'], defaultAppState,
              reason: 'test setup sanity check');

          localTodoAppStorage = TodoAppLocalStorage(TodoAppLocalStorage.emptyState);
          expect(json.decode(getLocalStorage())['current'], TodoAppLocalStorage.emptyState.toJson(),
              reason: 'test setup sanity check');

          initializeTestStore();
        });

        test('', () {
          expect(testStore.state.todos, isEmpty);
          expect(testStore.state.users, isEmpty);
          expect(testStore.state.selectedTodoIds, isEmpty);
          expect(testStore.state.editableTodoIds, isEmpty);
          expect(testStore.state.highlightedTodoIds, isEmpty);
          expect(testStore.state.selectedUserIds, isEmpty);
          expect(testStore.state.editableUserIds, isEmpty);
          expect(testStore.state.highlightedUserIds, isEmpty);
        });
      });
    });

    group('todosReducer updates state', () {
      test('when an AddTodoAction is dispatched', () {
        final initialTodos = testStore.state.todos;
        final newTodo = Todo(description: 'yo');
        testStore.dispatch(AddTodoAction(newTodo));
        expect(getSerializedListOfModels(testStore.state.todos),
            getSerializedListOfModels([newTodo, ...initialTodos]));
      });

      test('when a RemoveTodoAction is dispatched', () {
        final initialTodos = testStore.state.todos;
        final idOfTodoToRemove = testStore.state.todos.first.id;
        testStore.dispatch(RemoveTodoAction(idOfTodoToRemove));
        expect(getSerializedListOfModels(testStore.state.todos),
            getSerializedListOfModels([...initialTodos]..removeWhere((todo) => todo.id == idOfTodoToRemove)));
      });

      test('when an UpdateTodoAction is dispatched', () {
        final initialTodos = testStore.state.todos;
        final updatedTodo = Todo.from(initialTodos.first)..description += 'foooo';
        expect(testStore.state.todos.first.toJson(), isNot(updatedTodo.toJson()));

        testStore.dispatch(UpdateTodoAction(updatedTodo));
        expect(testStore.state.todos.first.toJson(), updatedTodo.toJson());
      });
    });

    group('editableTodosReducer updates state', () {
      void beginEdits() {
        final initialEditableTodoIds = testStore.state.editableTodoIds;
        expect(initialEditableTodoIds, isEmpty);

        final newEditableTodoId = testStore.state.todos.first.id;
        testStore.dispatch(BeginEditTodoAction(newEditableTodoId));
        expect(testStore.state.editableTodoIds, [newEditableTodoId]);

        final anotherNewEditableTodoId = testStore.state.todos[1].id;
        testStore.dispatch(BeginEditTodoAction(anotherNewEditableTodoId));
        expect(testStore.state.editableTodoIds, [newEditableTodoId, anotherNewEditableTodoId]);
      }

      test('when an BeginEditTodoAction is dispatched', beginEdits);

      test('when a FinishEditTodoAction is dispatched', () {
        beginEdits();

        final noLongerEditableTodoId = testStore.state.todos.first.id;
        testStore.dispatch(FinishEditTodoAction(noLongerEditableTodoId));
        expect(testStore.state.editableTodoIds, isNot(contains(noLongerEditableTodoId)));
      });
    });

    group('selectedTodosReducer updates state', () {
      void select() {
        final initialSelectedTodoIds = testStore.state.selectedTodoIds;
        expect(initialSelectedTodoIds, isEmpty);

        final newSelectedTodoId = testStore.state.todos.first.id;
        testStore.dispatch(SelectTodoAction(newSelectedTodoId));
        expect(testStore.state.selectedTodoIds, [newSelectedTodoId]);

        final anotherNewSelectedTodoId = testStore.state.todos[1].id;
        testStore.dispatch(SelectTodoAction(anotherNewSelectedTodoId));
        expect(testStore.state.selectedTodoIds, [newSelectedTodoId, anotherNewSelectedTodoId]);
      }

      test('when an SelectTodoAction is dispatched', select);

      test('when a DeselectTodoAction is dispatched', () {
        select();

        final noLongerSelectedTodoId = testStore.state.todos.first.id;
        testStore.dispatch(DeselectTodoAction(noLongerSelectedTodoId));
        expect(testStore.state.selectedTodoIds, isNot(contains(noLongerSelectedTodoId)));
      });
    });

    group('highlightedTodosReducer updates state', () {
      void highlight() {
        final initialHighlightedTodoIds = testStore.state.highlightedTodoIds;
        expect(initialHighlightedTodoIds, isEmpty);

        final newHighlightedTodoIds = [
          testStore.state.todos[0].id,
          testStore.state.todos[1].id,
        ];
        testStore.dispatch(HighlightTodosAction(newHighlightedTodoIds));
        expect(testStore.state.highlightedTodoIds, newHighlightedTodoIds);

        final anotherNewHighlightedTodoId = testStore.state.todos[2].id;
        testStore.dispatch(HighlightTodosAction([anotherNewHighlightedTodoId]));
        expect(testStore.state.highlightedTodoIds, [...newHighlightedTodoIds, anotherNewHighlightedTodoId]);
      }

      test('when an HighlightTodosAction is dispatched', highlight);

      test('when a UnHighlightTodosAction is dispatched', () {
        highlight();

        final noLongerHighlightedTodoId = testStore.state.todos.first.id;
        testStore.dispatch(UnHighlightTodosAction([noLongerHighlightedTodoId]));
        expect(testStore.state.highlightedTodoIds, isNot(contains(noLongerHighlightedTodoId)));
      });
    });

    group('usersReducer updates state', () {
      test('when an AddUserAction is dispatched', () {
        final initialUsers = testStore.state.users;
        final newUser = User(name: 'yo');
        testStore.dispatch(AddUserAction(newUser));
        expect(getSerializedListOfModels(testStore.state.users),
            getSerializedListOfModels([newUser, ...initialUsers]));
      });

      test('when a RemoveUserAction is dispatched', () {
        final initialUsers = testStore.state.users;
        final idOfUserToRemove = testStore.state.users.first.id;
        testStore.dispatch(RemoveUserAction(idOfUserToRemove));
        expect(getSerializedListOfModels(testStore.state.users),
            getSerializedListOfModels([...initialUsers]..removeWhere((todo) => todo.id == idOfUserToRemove)));
      });

      test('when an UpdateUserAction is dispatched', () {
        final initialUsers = testStore.state.users;
        final updatedUser = User.from(initialUsers.first)..name += 'foooo';
        expect(testStore.state.users.first.toJson(), isNot(updatedUser.toJson()));

        testStore.dispatch(UpdateUserAction(updatedUser));
        expect(testStore.state.users.first.toJson(), updatedUser.toJson());
      });
    });

    group('editableUsersReducer updates state', () {
      void beginEdits() {
        final initialEditableUserIds = testStore.state.editableUserIds;
        expect(initialEditableUserIds, isEmpty);

        final newEditableUserId = testStore.state.users.first.id;
        testStore.dispatch(BeginEditUserAction(newEditableUserId));
        expect(testStore.state.editableUserIds, [newEditableUserId]);

        final anotherNewEditableUserId = testStore.state.users[1].id;
        testStore.dispatch(BeginEditUserAction(anotherNewEditableUserId));
        expect(testStore.state.editableUserIds, [newEditableUserId, anotherNewEditableUserId]);
      }

      test('when an BeginEditUserAction is dispatched', beginEdits);

      test('when a FinishEditUserAction is dispatched', () {
        beginEdits();

        final noLongerEditableUserId = testStore.state.users.first.id;
        testStore.dispatch(FinishEditUserAction(noLongerEditableUserId));
        expect(testStore.state.editableUserIds, isNot(contains(noLongerEditableUserId)));
      });
    });

    group('selectedUsersReducer updates state', () {
      void select() {
        final initialSelectedUserIds = testStore.state.selectedUserIds;
        expect(initialSelectedUserIds, isEmpty);

        final newSelectedUserId = testStore.state.users.first.id;
        testStore.dispatch(SelectUserAction(newSelectedUserId));
        expect(testStore.state.selectedUserIds, [newSelectedUserId]);

        final anotherNewSelectedUserId = testStore.state.users[1].id;
        testStore.dispatch(SelectUserAction(anotherNewSelectedUserId));
        expect(testStore.state.selectedUserIds, [newSelectedUserId, anotherNewSelectedUserId]);
      }

      test('when an SelectUserAction is dispatched', select);

      test('when a DeselectUserAction is dispatched', () {
        select();

        final noLongerSelectedUserId = testStore.state.users.first.id;
        testStore.dispatch(DeselectUserAction(noLongerSelectedUserId));
        expect(testStore.state.selectedUserIds, isNot(contains(noLongerSelectedUserId)));
      });
    });
  });
}
