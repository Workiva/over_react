// @dart=2.7
// ^ Do not remove until migrated to null safety. More info at https://wiki.atl.workiva.net/pages/viewpage.action?pageId=189370832
import 'dart:html';

import 'package:over_react/react_dom.dart' as react_dom;
import 'package:over_react/over_react_redux.dart';

import 'package:todo_client/todo_client.dart';

main() {
  final container = querySelector('#todo-container');

  final app = (ReduxProvider()..store = getStore())(
    TodoApp()(),
  );

  react_dom.render(app, container);
}
