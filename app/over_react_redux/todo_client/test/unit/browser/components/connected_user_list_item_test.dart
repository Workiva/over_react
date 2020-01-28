@TestOn('browser')
import 'dart:async';

import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';
import 'package:over_react_test/over_react_test.dart';
import 'package:test/test.dart';
import 'package:time/time.dart';

import 'package:todo_client/src/actions.dart';
import 'package:todo_client/src/components/app.dart';
import 'package:todo_client/src/components/user_list_item.dart';
import 'package:todo_client/src/models/user.dart';

import 'fixtures/utils.dart';

main() {
  initializeComponentTests();

  group('ConnectedUserListItem', () {
    Ref<TodoAppComponent> appRef;
    UserListItemComponent component;
    User model;

    setUp(() {
      initializeTestStore();
      appRef = createRef();
      mount((ReduxProvider()..store = testStore)(
        (ConnectedTodoApp()..ref = appRef)(),
      ));
      final appComponent = appRef.current;
      model = testStore.state.users.first;
      component = getComponentByTestId(appComponent, 'todo_client.UserListItem.${model.id}');
      expect(component, isA<UserListItemComponent>(), reason: 'test setup sanity check');
    });

    tearDown(() {
      appRef = null;
      component = null;
      model = null;
    });

    bool userShouldAppearSelected() => testStore.state.selectedUserIds.contains(model.id);
    bool userShouldAppearHighlighted() => testStore.state.highlightedUserIds.contains(model.id);
    bool userShouldBeEditable() => testStore.state.editableUserIds.contains(model.id);

    group('renders a UserListItem', () {
      group('with prop callbacks mapped to the expected Redux action', () {
        group('involving selection:', () {
          Future<Null> selectUser() async {
            expect(component.props.isSelected, isFalse, reason: 'test setup sanity check');
            component.props.onSelect(model.id);
            final redrawCount = await component.didRedraw().future.timeout(20.milliseconds);
            expect(redrawCount, 1);
            expect(component.props.isSelected, isTrue);
          }

          test('props.onSelect => SelectUserAction', selectUser);

          test('props.onDeselect => DeselectUserAction', () async {
            await selectUser();
            component.redrawCount = 0;

            component.props.onDeselect(model.id);
            final redrawCount = await component.didRedraw().future.timeout(20.milliseconds);
            expect(redrawCount, 1);
            expect(component.props.isSelected, isFalse);
          });
        });

        group('involving editability:', () {
          Future<Null> makeUserEditable() async {
            expect(component.props.isEditable, isFalse, reason: 'test setup sanity check');
            component.props.onBeginEdit(model.id);
            final redrawCount = await component.didRedraw().future.timeout(20.milliseconds);
            expect(redrawCount, 1);
            expect(component.props.isEditable, isTrue);
          }

          test('props.onBeginEdit => BeginEditUserAction', makeUserEditable);

          test('props.onFinishEdit => FinishEditUserAction', () async {
            await makeUserEditable();
            component.redrawCount = 0;

            component.props.onFinishEdit(model.id);
            final redrawCount = await component.didRedraw().future.timeout(20.milliseconds);
            expect(redrawCount, 1);
            expect(component.props.isEditable, isFalse);
          });
        });

        group('involving model CRUD:', () {
          test('props.onModelUpdate => UpdateUserAction', () async {
            const newName = 'Something Else';
            component.props.onModelUpdate(User.from(model)..name = newName);
            final redrawCount = await component.didRedraw().future.timeout(20.milliseconds);
            expect(redrawCount, 1);
            expect(component.props.model.name, newName);
          });

          test('props.onRemove => RemoveUserAction', () async {
            final todoRemovedCompleter = Completer<Null>();
            testStore.onChange.listen((newState) {
              todoRemovedCompleter.complete();
            });
            component.props.onRemove(model.id);
            await todoRemovedCompleter.future.timeout(10.milliseconds);
            expect(getByTestId(appRef.current, 'todo_client.UserListItem.${model.id}'), isNull);
          });
        });
      });

      group('with props.isSelected mapped to AppState.selectedUserIds', () {
        test('initially', () {
          expect(component.props.isSelected, userShouldAppearSelected());
        });

        test('when AppState.selectedUserIds is updated', () async {
          final wasSelected = userShouldAppearSelected();
          if (!wasSelected) {
            testStore.dispatch(SelectUserAction(model.id));
          } else {
            testStore.dispatch(DeselectUserAction(model.id));
          }

          final redrawCount = await component.didRedraw().future.timeout(20.milliseconds);
          expect(redrawCount, 1);
          expect(wasSelected, !userShouldAppearSelected());
          expect(component.props.isSelected, userShouldAppearSelected());
        });
      });

      group('with props.isEditable mapped to AppState.editableUserIds', () {
        test('initially', () {
          expect(component.props.isEditable, userShouldBeEditable());
        });

        test('when AppState.selectedUserIds is updated', () async {
          final wasEditable = userShouldBeEditable();
          if (!wasEditable) {
            testStore.dispatch(BeginEditUserAction(model.id));
          } else {
            testStore.dispatch(FinishEditUserAction(model.id));
          }

          final redrawCount = await component.didRedraw().future.timeout(20.milliseconds);
          expect(redrawCount, 1);
          expect(wasEditable, !userShouldBeEditable());
          expect(component.props.isEditable, userShouldBeEditable());
        });
      });

      group('with props.isHighlighted mapped to AppState.editableUserIds', () {
        test('initially', () {
          expect(component.props.isHighlighted, userShouldAppearHighlighted());
        });

        test('when AppState.selectedUserIds is updated', () async {
          final wasHighlighted = userShouldAppearHighlighted();
          if (!wasHighlighted) {
            testStore.dispatch(HighlightUsersAction([model.id]));
          } else {
            testStore.dispatch(UnHighlightUsersAction([model.id]));
          }

          final redrawCount = await component.didRedraw().future.timeout(20.milliseconds);
          expect(redrawCount, 1);
          expect(wasHighlighted, !userShouldAppearHighlighted());
          expect(component.props.isHighlighted, userShouldAppearHighlighted());
        });
      });
    });
  });
}
