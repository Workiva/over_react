import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';
// ignore: implementation_imports
import 'package:over_react/src/component/test_fixtures/redraw_counter_component_mixin.dart';

import 'package:todo_client/src/store.dart';
import 'package:todo_client/src/models/user.dart';
import 'package:todo_client/src/components/shared/display_list.dart';
import 'package:todo_client/src/components/user_list_item.dart';

part 'user_list.over_react.g.dart';

UiFactory<UserListProps> UserList = connect<AppState, UserListProps>(
    mapStateToProps: (state) {
      return (UserList()
        ..users = state.users
      );
    },
    forwardRef: true,
)(_$UserList); // ignore: undefined_identifier

mixin UserListPropsMixin on UiProps {
  @requiredProp
  List<User> users;
}

class UserListProps = UiProps with UserListPropsMixin, ConnectPropsMixin;

class UserListComponent extends UiComponent2<UserListProps> with RedrawCounterMixin {
  @override
  render() {
    return (DisplayList()
      ..listItemTypeDescription = 'users'
      ..addTestId('todo_client.UserList.DisplayList')
    )(
      props.users.map(_renderUser).toList(),
    );
  }

  ReactElement _renderUser(User user) {
    return (UserListItem()
      ..key = user.id
      ..model = user
      ..addTestId('todo_client.UserListItem.${user.id}')
    )();
  }
}
