// @dart=2.11
// This file is a non-null safe copy of playground examples to enable QAing backwards compatibility.
import 'package:over_react/over_react.dart';

fixes() {
  (Dom.div()
        ..key = new Object().hashCode
        ..onMouseEnter = (_) => 'arrow function' // should lint
          ..id = '1'
          ..onClick = (_) =>
              'arrow function' // should not lint once onMouseEnter arrow function is wrapped
      )([
    'could be',
    'variadic children',
  ]);
}

shouldNotLint() {
  return (Dom.div()..onClick = (_) => Dom.div()..id = 'foo')();
}

class MyObject {
  String id;
}

dynamic functionThatReturnsDynamic() {}
