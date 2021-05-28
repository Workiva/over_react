// Copyright 2020 Workiva Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:over_react/over_react.dart';

// ignore_for_file: uri_has_not_been_generated
part 'use_debug_value_example.over_react.g.dart';

class ChatAPI {
  static void subscribeToFriendStatus(int id, Function handleStatusChange) =>
      handleStatusChange({'isOnline': id % 2 == 0});

  static void unsubscribeFromFriendStatus(
          int? id, Function handleStatusChange) =>
      handleStatusChange({'isOnline': false});
}

// Custom Hook
StateHook<bool?> useFriendStatus(int? friendID) {
  final isOnline = useState(false);

  void handleStatusChange(Map status) {
    isOnline.set(status['isOnline'] as bool?);
  }

  useEffect(() {
    ChatAPI.subscribeToFriendStatus(friendID!, handleStatusChange);
    return () {
      ChatAPI.unsubscribeFromFriendStatus(friendID, handleStatusChange);
    };
  });

  // Use format function to avoid unnecessarily formatting `isOnline` when the hooks aren't inspected in React DevTools.
  useDebugValue<bool?>(
      isOnline.value, (isOnline) => isOnline! ? 'Online' : 'Not Online');

  return isOnline;
}

mixin FriendListItemProps on UiProps {
  Map<String, dynamic>? friend;
}

UiFactory<FriendListItemProps> FriendListItem = uiFunction(
  (props) {
    final isOnline = useFriendStatus(props.friend!['id'] as int?);

    return (Dom.li()..style = {'color': isOnline.value! ? 'green' : 'black'})(
      props.friend!['name'],
    );
  },
  _$FriendListItemConfig, // ignore: undefined_identifier
);

mixin UseDebugValueExampleProps on UiProps {}

UiFactory<UseDebugValueExampleProps> UseDebugValueExample = uiFunction(
  (props) => Fragment()(
    (FriendListItem()..friend = {'id': 1, 'name': 'user 1'})(),
    (FriendListItem()..friend = {'id': 2, 'name': 'user 2'})(),
    (FriendListItem()..friend = {'id': 3, 'name': 'user 3'})(),
    (FriendListItem()..friend = {'id': 4, 'name': 'user 4'})(),
  ),
  _$UseDebugValueExampleConfig, // ignore: undefined_identifier
);
