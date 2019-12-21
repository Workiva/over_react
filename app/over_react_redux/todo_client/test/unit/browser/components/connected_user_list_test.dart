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
import 'package:todo_client/src/components/user_list.dart';
import 'package:todo_client/src/components/user_list_item.dart';
import 'package:todo_client/src/local_storage.dart';
import 'package:todo_client/src/models/user.dart';

import 'fixtures/utils.dart';

main() {
  initializeComponentTests();

  group('ConnectedUserList', () {
    Ref<TodoAppComponent> appRef;
    UserListComponent component;
    TestJacket jacket;

    setUp(() {
      initializeTestStore();
      appRef = createRef();
      jacket = mount((ReduxProvider()..store = testStore)(
        (ConnectedTodoApp()..ref = appRef)(),
      ));
      final appComponent = appRef.current;
      component = getComponentByTestId(appComponent, 'todo_client.ConnectedUserList');
      expect(component, isA<UserListComponent>(), reason: 'test setup sanity check');
    });

    tearDown(() {
      appRef = null;
      component = null;
      jacket = null;
    });

    group('renders a UserList', () {
      group('with props.users mapped to AppState.users', () {
        test('initially', () {
          expect(component.props.users, testStore.state.users);
        });

        test('when AppState.users is updated', () async {
          final newUser = User(name: 'foo');
          testStore.dispatch(AddUserAction(newUser));
          final redrawCount = await component.didRedraw().future.timeout(20.milliseconds);
          expect(component.props.users.first.toJson(), newUser.toJson());
          expect(redrawCount, 1);
        });
      });

      group('with ConnectedUserListItems for each todo in the model within a DisplayList', () {
        dynamic displayListInstance;
        setUp(() {
          displayListInstance = getByTestId(component, 'todo_client.UserList.DisplayList');
          expect(displayListInstance, isNotNull);
          expect(getDartComponent(displayListInstance), isA<DisplayListComponent>());
          expect(component.props.users, isNotEmpty, reason: 'test setup sanity check');
        });

        tearDown(() {
          displayListInstance = null;
        });

        test('', () {
          for (var user in component.props.users) {
            final listItemComponent = getComponentByTestId(displayListInstance, 'todo_client.UserListItem.${user.id}');
            expect(listItemComponent, isA<UserListItemComponent>());
            UserListItemProps props = listItemComponent.props;
            expect(props.model, user);
          }
        });

        test('unless props.users is empty', () {
          initializeTestStore(TodoAppLocalStorage.emptyState);
          jacket.rerender((ReduxProvider()..store = testStore)(
            (ConnectedTodoApp()..ref = appRef)(),
          ));
          expect(testStore.state.users, isEmpty, reason: 'test setup sanity check');

          expect(findDomNode(displayListInstance).children, hasLength(1));
          expect(getComponentByTestId(displayListInstance, 'todo_client.DisplayList.EmptyView'),
              isA<EmptyViewComponent>());
        });
      });
    });
  });
}
