import 'package:over_react/over_react.dart';

fixes() {
  (Dom.div()
    ..key = new Object().hashCode
    ..id = '1'
    ..onClick = (_) => 'arrow function'
  )([
    'could be',
    'variadic children',
  ]);
}

class MyObject {
  String id;
}

dynamic functionThatReturnsDynamic() {}
