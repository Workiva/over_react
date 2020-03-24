import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';

import 'package:todo_client/src/store.dart';
import 'package:todo_client/src/models/user.dart';
import 'package:todo_client/src/components/shared/display_list.dart';
import 'package:todo_client/src/components/shared/redraw_counter_component_mixin.dart';
import 'package:todo_client/src/components/user_list_item.dart';

// ignore: uri_has_not_been_generated
part 'user_list.over_react.g.dart';

UiFactory<UserListProps> ConnectedUserList = connect<AppState, UserListProps>(
    mapStateToProps: (state) {
      return (UserList()
        ..users = state.users
      );
    },
    forwardRef: true,
)(UserList);

UiFactory<UserListProps> UserList =
    // ignore: undefined_identifier
    _$UserList;

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
    return (ConnectedUserListItem()
      ..key = user.id
      ..model = user
      ..addTestId('todo_client.UserListItem.${user.id}')
    )();
  }
}
