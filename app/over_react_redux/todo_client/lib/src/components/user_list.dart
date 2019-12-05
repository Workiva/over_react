import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';

import 'package:todo_client/src/store.dart';
import 'package:todo_client/src/models/user.dart';
import 'package:todo_client/src/components/shared/display_list.dart';
import 'package:todo_client/src/components/user_list_item.dart';

// ignore: uri_has_not_been_generated
part 'user_list.over_react.g.dart';

UiFactory<UserListProps> ConnectedUserList = connect<AppState, UserListProps>(
    mapStateToProps: (state) {
      return (UserList()
        ..users = state.users
      );
    },
)(UserList);

@Factory()
UiFactory<UserListProps> UserList =
    // ignore: undefined_identifier
    _$UserList;

@Props()
class _$UserListProps extends UiProps with ConnectPropsMixin {
  @requiredProp
  List<User> users;
}

@Component2()
class UserListComponent extends UiComponent2<UserListProps> {
  @override
  render() {
    return (DisplayList()..listItemTypeDescription = 'users')(
      props.users.map(_renderUser).toList()
    );
  }

  ReactElement _renderUser(User user) {
    return (ConnectedUserListItem()
      ..key = user.id
      ..model = user
    )();
  }
}

// ignore: mixin_of_non_class, undefined_class
class UserListProps extends _$UserListProps with _$UserListPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = _$metaForUserListProps;
}
