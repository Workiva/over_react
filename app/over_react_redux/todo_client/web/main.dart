import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:over_react/react_dom.dart' as react_dom;
import 'package:over_react/over_react_redux.dart';

import 'package:todo_client/todo_client.dart';

main() {
  setClientConfiguration();

  final container = querySelector('#todo-container');
  react_dom.render(
      (ReduxProvider()..store = store)(
        ConnectedTodoApp()(),
      ),
      container);
}
