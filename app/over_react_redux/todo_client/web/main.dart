import 'dart:html';

import 'package:over_react/react_dom.dart' as react_dom;
import 'package:over_react/over_react_redux.dart';

import 'package:todo_client/todo_client.dart';

main() {
  final container = querySelector('#todo-container');

  final app = (ReduxProvider()..store = getStore())(
    TodoApp()(),
  );

  final root = react_dom.createRoot(container);

  root.render(app);
}
