@TestOn('browser')
import 'dart:convert';

import 'package:over_react/over_react.dart';
import 'package:test/test.dart';

import 'package:todo_client/src/actions.dart';
import 'package:todo_client/src/local_storage.dart';
import 'package:todo_client/src/models/todo.dart';
import 'package:todo_client/src/models/user.dart';
import 'package:todo_client/src/store.dart';

import '../fixtures/utils.dart';

main() {
  setClientConfiguration();
  const reasonCurrentSetShouldBePersisted =
        'The state update should be persisted as the "current" set in window.localStorage';

  group('AppState', () {
    setUp(() {
      expect(TodoAppLocalStorage.isInitialized(), isFalse, reason: 'test setup sanity check');
      initializeTestStore();
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
          expect(getCurrentLocalStorageSet(), defaultAppState, reason: 'test setup sanity check');

          initializeTestStore(TodoAppLocalStorage.emptyState);
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
        final expectedNewState = getSerializedListOfModels([newTodo, ...initialTodos]);
        testStore.dispatch(AddTodoAction(newTodo));

        expect(getSerializedListOfModels(testStore.state.todos), expectedNewState);
        expect(getCurrentLocalStorageSet()['todos'], expectedNewState,
            reason: reasonCurrentSetShouldBePersisted);
      });

      test('when a RemoveTodoAction is dispatched', () {
        final initialTodos = testStore.state.todos;
        final idOfTodoToRemove = testStore.state.todos.first.id;
        final expectedNewState = getSerializedListOfModels(
            [...initialTodos]..removeWhere((todo) => todo.id == idOfTodoToRemove));
        testStore.dispatch(RemoveTodoAction(idOfTodoToRemove));

        expect(getSerializedListOfModels(testStore.state.todos), expectedNewState);
        expect(getCurrentLocalStorageSet()['todos'], expectedNewState,
            reason: reasonCurrentSetShouldBePersisted);
      });

      test('when an UpdateTodoAction is dispatched', () {
        final initialTodos = testStore.state.todos;
        final updatedTodo = Todo.from(initialTodos.first)..description += 'foooo';
        final expectedNewState = updatedTodo.toJson();
        expect(testStore.state.todos.first.toJson(), isNot(expectedNewState), reason: 'test setup sanity check');
        testStore.dispatch(UpdateTodoAction(updatedTodo));

        expect(testStore.state.todos.first.toJson(), expectedNewState);
        expect(getCurrentLocalStorageSet()['todos'][0], expectedNewState,
            reason: reasonCurrentSetShouldBePersisted);
      });
    });

    group('editableTodosReducer updates state', () {
      void beginEdits() {
        final initialEditableTodoIds = testStore.state.editableTodoIds;
        expect(initialEditableTodoIds, isEmpty, reason: 'test setup sanity check');
        final newEditableTodoId = testStore.state.todos.first.id;
        var expectedNewState = [newEditableTodoId];
        testStore.dispatch(BeginEditTodoAction(newEditableTodoId));

        expect(testStore.state.editableTodoIds, expectedNewState);
        expect(getCurrentLocalStorageSet()['editableTodoIds'], expectedNewState,
            reason: reasonCurrentSetShouldBePersisted);

        final anotherNewEditableTodoId = testStore.state.todos[1].id;
        expectedNewState = [newEditableTodoId, anotherNewEditableTodoId];
        testStore.dispatch(BeginEditTodoAction(anotherNewEditableTodoId));

        expect(testStore.state.editableTodoIds, expectedNewState);
        expect(getCurrentLocalStorageSet()['editableTodoIds'], expectedNewState,
            reason: reasonCurrentSetShouldBePersisted);
      }

      test('when an BeginEditTodoAction is dispatched', beginEdits);

      test('when a FinishEditTodoAction is dispatched', () {
        beginEdits();

        final noLongerEditableTodoId = testStore.state.todos.first.id;
        testStore.dispatch(FinishEditTodoAction(noLongerEditableTodoId));

        expect(testStore.state.editableTodoIds, isNot(contains(noLongerEditableTodoId)));
        expect(getCurrentLocalStorageSet()['editableTodoIds'], isNot(contains(noLongerEditableTodoId)),
            reason: reasonCurrentSetShouldBePersisted);
      });
    });

    group('selectedTodosReducer updates state', () {
      void select() {
        final initialSelectedTodoIds = testStore.state.selectedTodoIds;
        expect(initialSelectedTodoIds, isEmpty, reason: 'test setup sanity check');
        final newSelectedTodoId = testStore.state.todos.first.id;
        var expectedNewState = [newSelectedTodoId];
        testStore.dispatch(SelectTodoAction(newSelectedTodoId));

        expect(testStore.state.selectedTodoIds, expectedNewState);
        expect(getCurrentLocalStorageSet()['selectedTodoIds'], expectedNewState,
            reason: reasonCurrentSetShouldBePersisted);

        final anotherNewSelectedTodoId = testStore.state.todos[1].id;
        expectedNewState = [newSelectedTodoId, anotherNewSelectedTodoId];
        testStore.dispatch(SelectTodoAction(anotherNewSelectedTodoId));

        expect(testStore.state.selectedTodoIds, expectedNewState);
        expect(getCurrentLocalStorageSet()['selectedTodoIds'], expectedNewState,
            reason: reasonCurrentSetShouldBePersisted);
      }

      test('when an SelectTodoAction is dispatched', select);

      test('when a DeselectTodoAction is dispatched', () {
        select();

        final noLongerSelectedTodoId = testStore.state.todos.first.id;
        testStore.dispatch(DeselectTodoAction(noLongerSelectedTodoId));

        expect(testStore.state.selectedTodoIds, isNot(contains(noLongerSelectedTodoId)));
        expect(getCurrentLocalStorageSet()['selectedTodoIds'], isNot(contains(noLongerSelectedTodoId)),
            reason: reasonCurrentSetShouldBePersisted);
      });
    });

    group('highlightedTodosReducer updates state', () {
      void highlight() {
        final initialHighlightedTodoIds = testStore.state.highlightedTodoIds;
        expect(initialHighlightedTodoIds, isEmpty, reason: 'test setup sanity check');
        var expectedNewState = [
          testStore.state.todos[0].id,
          testStore.state.todos[1].id,
        ];
        testStore.dispatch(HighlightTodosAction(expectedNewState));

        expect(testStore.state.highlightedTodoIds, expectedNewState);
        expect(getCurrentLocalStorageSet()['highlightedTodoIds'], expectedNewState,
            reason: reasonCurrentSetShouldBePersisted);

        final anotherNewHighlightedTodoId = testStore.state.todos[2].id;
        expectedNewState.add(anotherNewHighlightedTodoId);
        testStore.dispatch(HighlightTodosAction([anotherNewHighlightedTodoId]));

        expect(testStore.state.highlightedTodoIds, expectedNewState);
        expect(getCurrentLocalStorageSet()['highlightedTodoIds'], expectedNewState,
            reason: reasonCurrentSetShouldBePersisted);
      }

      test('when an HighlightTodosAction is dispatched', highlight);

      test('when a UnHighlightTodosAction is dispatched', () {
        highlight();

        final noLongerHighlightedTodoId = testStore.state.todos.first.id;
        testStore.dispatch(UnHighlightTodosAction([noLongerHighlightedTodoId]));

        expect(testStore.state.highlightedTodoIds, isNot(contains(noLongerHighlightedTodoId)));
        expect(getCurrentLocalStorageSet()['highlightedTodoIds'],
            isNot(contains(noLongerHighlightedTodoId)),
            reason: reasonCurrentSetShouldBePersisted);
      });
    });

    group('usersReducer updates state', () {
      test('when an AddUserAction is dispatched', () {
        final initialUsers = testStore.state.users;
        final newUser = User(name: 'yo');
        final expectedNewState = getSerializedListOfModels([newUser, ...initialUsers]);
        testStore.dispatch(AddUserAction(newUser));

        expect(getSerializedListOfModels(testStore.state.users), expectedNewState);
        expect(getCurrentLocalStorageSet()['users'], expectedNewState,
            reason: reasonCurrentSetShouldBePersisted);
      });

      test('when a RemoveUserAction is dispatched', () {
        final initialUsers = testStore.state.users;
        final idOfUserToRemove = testStore.state.users.first.id;
        final expectedNewState = getSerializedListOfModels(
            [...initialUsers]..removeWhere((todo) => todo.id == idOfUserToRemove));
        testStore.dispatch(RemoveUserAction(idOfUserToRemove));

        expect(getSerializedListOfModels(testStore.state.users), expectedNewState);
        expect(getCurrentLocalStorageSet()['users'], expectedNewState,
            reason: reasonCurrentSetShouldBePersisted);
      });

      test('when an UpdateUserAction is dispatched', () {
        final initialUsers = testStore.state.users;
        final updatedUser = User.from(initialUsers.first)..name += 'foooo';
        final expectedNewState = updatedUser.toJson();
        expect(testStore.state.users.first.toJson(), isNot(expectedNewState), reason: 'test setup sanity check');
        testStore.dispatch(UpdateUserAction(updatedUser));

        expect(testStore.state.users.first.toJson(), updatedUser.toJson());
        expect(getCurrentLocalStorageSet()['users'][0], expectedNewState,
            reason: reasonCurrentSetShouldBePersisted);
      });
    });

    group('editableUsersReducer updates state', () {
      void beginEdits() {
        final initialEditableUserIds = testStore.state.editableUserIds;
        expect(initialEditableUserIds, isEmpty, reason: 'test setup sanity check');
        final newEditableUserId = testStore.state.users.first.id;
        var expectedNewState = [newEditableUserId];
        testStore.dispatch(BeginEditUserAction(newEditableUserId));

        expect(testStore.state.editableUserIds, expectedNewState);
        expect(getCurrentLocalStorageSet()['editableUserIds'], expectedNewState,
            reason: reasonCurrentSetShouldBePersisted);

        final anotherNewEditableUserId = testStore.state.users[1].id;
        expectedNewState = [newEditableUserId, anotherNewEditableUserId];
        testStore.dispatch(BeginEditUserAction(anotherNewEditableUserId));

        expect(testStore.state.editableUserIds, expectedNewState);
        expect(getCurrentLocalStorageSet()['editableUserIds'], expectedNewState,
            reason: reasonCurrentSetShouldBePersisted);
      }

      test('when an BeginEditUserAction is dispatched', beginEdits);

      test('when a FinishEditUserAction is dispatched', () {
        beginEdits();

        final noLongerEditableUserId = testStore.state.users.first.id;
        testStore.dispatch(FinishEditUserAction(noLongerEditableUserId));

        expect(testStore.state.editableUserIds, isNot(contains(noLongerEditableUserId)));
        expect(getCurrentLocalStorageSet()['editableUserIds'], isNot(contains(noLongerEditableUserId)),
            reason: reasonCurrentSetShouldBePersisted);
      });
    });

    group('selectedUsersReducer updates state', () {
      void select() {
        final initialSelectedUserIds = testStore.state.selectedUserIds;
        expect(initialSelectedUserIds, isEmpty, reason: 'test setup sanity check');
        final newSelectedUserId = testStore.state.users.first.id;
        var expectedNewState = [newSelectedUserId];
        testStore.dispatch(SelectUserAction(newSelectedUserId));

        expect(testStore.state.selectedUserIds, expectedNewState);
        expect(getCurrentLocalStorageSet()['selectedUserIds'], expectedNewState,
            reason: reasonCurrentSetShouldBePersisted);

        final anotherNewSelectedUserId = testStore.state.users[1].id;
        expectedNewState = [newSelectedUserId, anotherNewSelectedUserId];
        testStore.dispatch(SelectUserAction(anotherNewSelectedUserId));

        expect(testStore.state.selectedUserIds, expectedNewState);
        expect(getCurrentLocalStorageSet()['selectedUserIds'], expectedNewState,
            reason: reasonCurrentSetShouldBePersisted);
      }

      test('when an SelectUserAction is dispatched', select);

      test('when a DeselectUserAction is dispatched', () {
        select();

        final noLongerSelectedUserId = testStore.state.users.first.id;
        testStore.dispatch(DeselectUserAction(noLongerSelectedUserId));

        expect(testStore.state.selectedUserIds, isNot(contains(noLongerSelectedUserId)));
        expect(getCurrentLocalStorageSet()['selectedUserIds'], isNot(contains(noLongerSelectedUserId)),
            reason: reasonCurrentSetShouldBePersisted);
      });
    });

    group('appStateReducer updates state', () {
      group('when a LoadStateFromLocalStorageAction action is dispatched', () {
        setUp(() {
          expect(getCurrentLocalStorageSet(), defaultAppState, reason: 'test setup sanity check');
          testStore.dispatch(LoadStateFromLocalStorageAction('empty'));
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

        test('and persists the state as the "current" set in window.localStorage', () {
          expect(getCurrentLocalStorageSet(), TodoAppLocalStorage.emptyState.toJson());
        });
      });

      group('when a SaveLocalStorageStateAsAction action is dispatched', () {
        const customPersistedDataSetName = 'custom';
        void addCustomPersistedDataSet() {
          expect(getCurrentLocalStorageSet(), defaultAppState, reason: 'test setup sanity check');
          final newTodo = Todo(description: 'yo');
          // Update the "current" persisted data set so that it differs from the default
          testStore.dispatch(AddTodoAction(newTodo));

          // Save a custom set based on the "current" persisted data set
          testStore.dispatch(SaveLocalStorageStateAsAction(customPersistedDataSetName));

          expect(getLocalStorageSetByKey(customPersistedDataSetName), testStore.state.toJson());
          expect(getCurrentLocalStorageSet(), getLocalStorageSetByKey(customPersistedDataSetName),
              reason: reasonCurrentSetShouldBePersisted);
        }

        setUp(() {
          expect(getCurrentLocalStorageSet(), defaultAppState, reason: 'test setup sanity check');
        });

        test('as a new custom persisted set when a previousName is not specified (save)', addCustomPersistedDataSet);

        test('as an updated custom persisted set when a previousName is specified (overwrite)', () {
          addCustomPersistedDataSet();
          final initialCustomPersistedDataSetValue = getLocalStorageSetByKey(customPersistedDataSetName);
          final newTodo = Todo(description: 'yo again');
          // Update the "current" persisted data set so that it differs from the custom persisted set
          testStore.dispatch(AddTodoAction(newTodo));

          // Save the existing custom set based on the "current" persisted data set
          testStore.dispatch(
              SaveLocalStorageStateAsAction(customPersistedDataSetName, previousName: customPersistedDataSetName));

          expect(getLocalStorageSetByKey(customPersistedDataSetName), isNot(initialCustomPersistedDataSetValue));
          expect(getLocalStorageSetByKey(customPersistedDataSetName), testStore.state.toJson());
          expect(getCurrentLocalStorageSet(), getLocalStorageSetByKey(customPersistedDataSetName),
              reason: reasonCurrentSetShouldBePersisted);
        });

        test('as a new custom persisted set with identical data when a previousName is specified (copy)', () {
          addCustomPersistedDataSet();
          const newCustomPersistedDataSetName = 'Copy of $customPersistedDataSetName';
          final initialCustomPersistedDataSetValue = getLocalStorageSetByKey(customPersistedDataSetName);

          // Save a copy of the existing custom set based on the "current" persisted data set
          testStore.dispatch(
              SaveLocalStorageStateAsAction(newCustomPersistedDataSetName, previousName: customPersistedDataSetName));

          expect(getLocalStorageSetByKey(newCustomPersistedDataSetName), testStore.state.toJson());
          expect(getCurrentLocalStorageSet(), getLocalStorageSetByKey(newCustomPersistedDataSetName),
              reason: reasonCurrentSetShouldBePersisted);
          expect(getLocalStorageSetByKey(customPersistedDataSetName), initialCustomPersistedDataSetValue,
              reason: 'The persisted "$customPersistedDataSetName" set should remain unchanged');
          expect(getLocalStorageSetByKey(customPersistedDataSetName)['name'],
              isNot(getLocalStorageSetByKey(newCustomPersistedDataSetName)['name']),
              reason: 'The two sets should have different names');
          expect(getLocalStorageSetByKey(customPersistedDataSetName)..remove('name'),
              getLocalStorageSetByKey(newCustomPersistedDataSetName)..remove('name'),
              reason: 'The "$newCustomPersistedDataSetName" set should be an '
                  'exact copy of "$customPersistedDataSetName" except for the name');
        });

        test('as a new custom persisted set with different data when a previousName is specified (save as)', () {
          addCustomPersistedDataSet();
          const newCustomPersistedDataSetName = 'Copy of $customPersistedDataSetName';
          final initialCustomPersistedDataSetValue = getLocalStorageSetByKey(customPersistedDataSetName);
          final newTodo = Todo(description: 'yo again');
          // Update the "current" persisted data set so that it differs from the custom persisted set
          testStore.dispatch(AddTodoAction(newTodo));

          // Save a copy of the existing custom set based on the "current" persisted data set
          testStore.dispatch(
              SaveLocalStorageStateAsAction(newCustomPersistedDataSetName, previousName: customPersistedDataSetName));

          expect(getLocalStorageSetByKey(newCustomPersistedDataSetName), testStore.state.toJson());
          expect(getCurrentLocalStorageSet(), getLocalStorageSetByKey(newCustomPersistedDataSetName),
              reason: reasonCurrentSetShouldBePersisted);
          expect(getLocalStorageSetByKey(customPersistedDataSetName), initialCustomPersistedDataSetValue,
              reason: 'The persisted "$customPersistedDataSetName" set should remain unchanged');
          expect(getLocalStorageSetByKey(customPersistedDataSetName)['name'],
              isNot(getLocalStorageSetByKey(newCustomPersistedDataSetName)['name']),
              reason: 'The two sets should have different names');
          expect(getLocalStorageSetByKey(customPersistedDataSetName),
              isNot(getLocalStorageSetByKey(newCustomPersistedDataSetName)),
              reason: 'The "$newCustomPersistedDataSetName" set should differ from "$customPersistedDataSetName"');
        });
      });
    });
  });
}
