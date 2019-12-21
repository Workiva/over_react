import 'dart:async';
import 'dart:html';

@TestOn('browser')
import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';
import 'package:over_react_test/over_react_test.dart';
import 'package:test/test.dart';
import 'package:time/time.dart';
import 'package:todo_client/src/actions.dart';

import 'package:todo_client/src/components/app.dart';
import 'package:todo_client/src/components/shared/todo_item_text_field.dart';
import 'package:todo_client/src/components/todo_list_item.dart';
import 'package:todo_client/src/components/user_selector.dart';
import 'package:todo_client/src/models/todo.dart';
import 'package:todo_client/src/models/user.dart';

import 'fixtures/utils.dart';

main() {
  initializeComponentTests();

  group('TodoListItem', () {
    Ref<TodoAppComponent> appRef;
    TodoListItemComponent component;
    Todo model;
    const localModelSynchronizationTimingReason =
        'state.localModel should only be synchronized with persisted state '
        'as a result of the component entering an editable state';
    const modelGetterReturnsPersistedStateReason =
        'When props.isEditable is false, the component\'s model getter should '
        'return the value of props.model instead of state.localModel.';

    setUp(() {
      initializeTestStore();
      appRef = createRef();
      mount((ReduxProvider()..store = testStore)(
        (ConnectedTodoApp()..ref = appRef)(),
      ));
      final appComponent = appRef.current;
      model = testStore.state.todos.first;
      component = getComponentByTestId(appComponent, 'todo_client.TodoListItem.${model.id}');
      expect(component, isA<TodoListItemComponent>(), reason: 'test setup sanity check');
    });

    tearDown(() {
      appRef = null;
      component = null;
      model = null;
    });

    Future<Null> enterEditable() async {
      expect(component.props.isEditable, isFalse, reason: 'test setup sanity check');
      component.redrawCount = 0;
      // ignore: invalid_use_of_protected_member
      component.enterEditable();
      await component.didRedraw().future.timeout(10.milliseconds);
      expect(component.props.isEditable, isTrue, reason: 'test setup sanity check');
    }

    Future<Null> exitEditable({bool saveChanges = true}) async {
      expect(component.props.isEditable, isTrue, reason: 'test setup sanity check');
      component.redrawCount = 0;
      // ignore: invalid_use_of_protected_member
      component.exitEditable(saveChanges: saveChanges);
      await component.didRedraw().future.timeout(10.milliseconds);
      expect(component.props.isEditable, isFalse, reason: 'test setup sanity check');
    }

    group('renders', () {
      group('a description text field', () {
        TodoItemTextFieldComponent descriptionTextFieldComponent() {
          final textFieldComponent = getComponentByTestId(component, 'todo_client.TodoListItem.descriptionTextField');
          expect(textFieldComponent, isA<TodoItemTextFieldComponent>(), reason: 'test setup sanity check');
          return textFieldComponent;
        }
        InputElement descriptionTextFieldNode() => descriptionTextFieldComponent().textFieldRef.current;

        group('with its props set as expected', () {
          test('', () {
            expect(descriptionTextFieldComponent().props.label, 'Description');
            expect(descriptionTextFieldComponent().props.placeholder, 'Describe the task...');
            expect(descriptionTextFieldComponent().props.value, model.description);
          });

          group('based on props.isEditable', () {
            setUp(() {
              expect(component.props.isEditable, isFalse, reason: 'test setup sanity check');
            });

            test('initially', () {
              expect(descriptionTextFieldComponent().props.readOnly, isTrue);
              expect(descriptionTextFieldComponent().props.autoFocus, isFalse);
              expect(descriptionTextFieldComponent().props['inputProps']['style'], isNotNull);
            });

            test('when props.isEditable is updated', () async {
              await enterEditable();
              expect(descriptionTextFieldComponent().props.readOnly, isFalse);
              expect(descriptionTextFieldComponent().props.autoFocus, isTrue);
              expect(descriptionTextFieldComponent().props['inputProps']['style'], isNull);
            });
          });
        });

        group('with a props.onChange callback that updates', () {
          const String newDescription = 'Something different entirely that was not the description before';

          setUp(() {
            expect(component.model.description, isNot(newDescription), reason: 'test setup sanity check');
          });

          group('state.localModel when props.isEditable is true', () {
            Future<Null> storeDescriptionUpdateLocally() async {
              await enterEditable();
              descriptionTextFieldNode().value = newDescription;
              change(descriptionTextFieldNode());
            }

            test('', () async {
              await storeDescriptionUpdateLocally();

              expect(descriptionTextFieldComponent().props.value, newDescription);
              expect(component.state.localModel.description, newDescription);
              expect(component.props.model.description, isNot(newDescription),
                  reason: 'The change should not have been persisted yet');
            });

            test('- and then synchronizes props.model with state.localModel'
                'when exitEditable() is called', () async {
              await storeDescriptionUpdateLocally();
              await exitEditable();
              expect(descriptionTextFieldComponent().props.value, newDescription);
              expect(component.props.model.description, newDescription);
            });
          });
        });
      });

      group('a notes text field', () {
        TodoItemTextFieldComponent notesTextFieldComponent() {
          final textFieldComponent = getComponentByTestId(component, 'todo_client.TodoListItem.notesTextField');
          expect(textFieldComponent, isA<TodoItemTextFieldComponent>(), reason: 'test setup sanity check');
          return textFieldComponent;
        }
        TextAreaElement notesTextFieldNode() => notesTextFieldComponent().textFieldRef.current;

        group('with its props set as expected', () {
          test('', () {
            expect(notesTextFieldComponent().props.label, 'Notes');
            expect(notesTextFieldComponent().props.placeholder, 'Add some notes about the task');
            expect(notesTextFieldComponent().props.value, model.notes);
            expect(notesTextFieldComponent().props.multiline, isTrue);
            expect(notesTextFieldComponent().props['rows'], 3);
          });

          group('based on props.isEditable', () {
            setUp(() {
              expect(component.props.isEditable, isFalse, reason: 'test setup sanity check');
            });

            test('initially', () {
              expect(notesTextFieldComponent().props.readOnly, isTrue);
            });

            test('when props.isEditable is updated', () async {
              await enterEditable();
              expect(notesTextFieldComponent().props.readOnly, isFalse);
            });
          });
        });

        group('with a props.onChange callback that updates', () {
          const String newNotes = 'Something different entirely that was not the notes before';

          setUp(() {
            expect(component.model.notes, isNot(newNotes), reason: 'test setup sanity check');
          });

          group('state.localModel when props.isEditable is true', () {
            Future<Null> storeDescriptionUpdateLocally() async {
              await enterEditable();
              notesTextFieldNode().value = newNotes;
              change(notesTextFieldNode());
            }

            test('', () async {
              await storeDescriptionUpdateLocally();

              expect(notesTextFieldComponent().props.value, newNotes);
              expect(component.state.localModel.notes, newNotes);
              expect(component.props.model.notes, isNot(newNotes),
                  reason: 'The change should not have been persisted yet');
            });

            test('- and then synchronizes props.model with state.localModel'
                'when exitEditable() is called', () async {
              await storeDescriptionUpdateLocally();
              await exitEditable();
              expect(notesTextFieldComponent().props.value, newNotes);
              expect(component.props.model.notes, newNotes);
            });
          });
        });
      });

      group('a ConnectedUserSelector', () {
        UserSelectorProps connectedUserSelectorProps() {
          return UserSelector(getProps(getByTestId(component, 'todo_client.TodoListItem.ConnectedUserSelector')));
        }

        group('with props.model.assignedUserId forwarded to props.selectedUserId', () {
          test('initially', () {
            expect(connectedUserSelectorProps().selectedUserId, component.props.model.assignedUserId);
          });

          test('when props.assignedUserId is updated', () async {
            final newAssignedUser = testStore.state.users[1];
            expect(component.props.model.assignedUserId, isNot(newAssignedUser.id), reason: 'test setup sanity check');

            testStore.dispatch(UpdateTodoAction(Todo.from(component.props.model)..assignedUserId = newAssignedUser.id));
            await component.didRedraw().future.timeout(10.milliseconds);
            expect(component.props.model.assignedUserId, newAssignedUser.id);
            expect(connectedUserSelectorProps().selectedUserId, component.props.model.assignedUserId);
          });
        });

        group('with a props.onUserSelect callback that updates', () {
          User newAssignedUser;

          group('the persisted model data immediately when props.isEditable is false', () {
            Future<Null> persistSelectedUpdate() async {
              newAssignedUser = testStore.state.users[1];
              expect(component.model.assignedUserId, isNot(newAssignedUser.id), reason: 'test setup sanity check');
              expect(component.props.isEditable, isFalse, reason: 'test setup sanity check');

              connectedUserSelectorProps().onUserSelect(newAssignedUser.id);
              await component.didRedraw().future.timeout(10.milliseconds);
            }

            test('', () async {
              await persistSelectedUpdate();

              expect(connectedUserSelectorProps().selectedUserId, newAssignedUser.id);
              expect(component.state.localModel.assignedUserId, isNot(component.props.model.assignedUserId),
                  reason: localModelSynchronizationTimingReason);
              expect(component.model.assignedUserId, component.props.model.assignedUserId,
                  reason: modelGetterReturnsPersistedStateReason);
            });

            test('- and then synchronizes props.model with state.localModel'
                'when enterEditable() is called', () async {
              await persistSelectedUpdate();
              await enterEditable();
              expect(connectedUserSelectorProps().selectedUserId, newAssignedUser.id);
              expect(component.state.localModel.assignedUserId, component.props.model.assignedUserId);
            });
          });

          group('state.localModel when props.isEditable is true', () {
            Future<Null> storeSelectedUpdateLocally() async {
              newAssignedUser = testStore.state.users[1];
              await enterEditable();
              expect(component.model.assignedUserId, isNot(newAssignedUser.id), reason: 'test setup sanity check');
              connectedUserSelectorProps().onUserSelect(newAssignedUser.id);
            }

            test('', () async {
              await storeSelectedUpdateLocally();

              expect(connectedUserSelectorProps().selectedUserId, newAssignedUser.id);
              expect(component.state.localModel.assignedUserId, newAssignedUser.id);
              expect(component.props.model.assignedUserId, isNot(newAssignedUser.id),
                  reason: 'The change should not have been persisted yet');
            });

            test('- and then synchronizes props.model with state.localModel'
                'when exitEditable() is called', () async {
              await storeSelectedUpdateLocally();
              await exitEditable();
              expect(connectedUserSelectorProps().selectedUserId, newAssignedUser.id);
              expect(component.props.model.assignedUserId, newAssignedUser.id);
            });
          });
        });
      });

      // TODO: Add tests for cancel / save button, and the footer area itself that contains them that is only visible when the item is editable
    });
  });
}
