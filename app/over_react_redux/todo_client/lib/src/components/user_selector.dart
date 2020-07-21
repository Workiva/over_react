library todo_client.src.components.user_selector;

import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';
import 'package:over_react/src/component/test_fixtures/redraw_counter_component_mixin.dart';

import 'package:todo_client/src/store.dart';
import 'package:todo_client/src/models/user.dart';
import 'package:todo_client/src/components/shared/avatar_with_colors.dart';
import 'package:todo_client/src/components/shared/material_ui.dart';
import 'package:todo_client/src/components/shared/menu_overlay.dart';

part 'user_selector_trigger.dart';
part 'user_selector.over_react.g.dart';

UiFactory<UserSelectorProps> UserSelector = connect<AppState, UserSelectorProps>(
    mapStateToPropsWithOwnProps: (state, ownProps) {
      return (UserSelector()
        ..selectedUser = ownProps.selectedUserId.isNotEmpty
            ? state.users.singleWhere((user) => user.id == ownProps.selectedUserId, orElse: () => null)
            : null
        ..users = state.users
      );
    },
    forwardRef: true
)(_$UserSelector); // ignore: undefined_identifier

mixin UserSelectorProps on UiProps {
  String selectedUserId;
  User selectedUser;
  @requiredProp List<User> users;
  @requiredProp Function(String userId) onUserSelect;
}

class UserSelectorComponent extends UiComponent2<UserSelectorProps> with RedrawCounterMixin {
  final _overlayRef = createRef<MenuOverlayComponent>();

  @override
  render() {
    return (MenuOverlay()
      ..modifyProps(addUnconsumedProps)
      ..trigger = _renderMenuTrigger()
      ..ref = _overlayRef
    )(
      props.users.map(_renderMenuItem).toList(),
    );
  }

  ReactElement _renderMenuTrigger() {
    return (UserSelectorTrigger()
      ..selectedUserName = props.selectedUser?.name
      ..disabled = props.users.isEmpty
    )();
  }

  ReactElement _renderMenuItem(User user) {
    return MenuItem({
      'key': user.id,
      'onClick': (SyntheticMouseEvent event) {
        // Don't expand / collapse the user list item
        event.stopPropagation();
        _handleUserSelect(user);
      },
    },
      Box({'mr': 1},
        (AvatarWithColors()..fullName = user.name)(),
      ),
      user.name,
    );
  }

  void _handleUserSelect(User user) {
    props.onUserSelect(user.id);
    _overlayRef.current.close();
  }
}
