import 'package:over_react/over_react.dart';

import 'foo.dart';

validChildren() {
  Dom.div()(
    //
    // Valid child types
    //
    Dom.div()(),
    1,
    1.2,
    'Hello world!',
    null,
    false,
    functionThatReturnsDynamic(),
    [1, 2, 3],
    ['foo', 2, true],
    [new MyObject(), new MyObject()].map((obj) => obj.id),
  );
}

invalidChildren() {
  Dom.div()(
    //
    // Valid child types
    //
    Dom.div()(),
    1,
    1.2,
    'Hello world!',
    null,
    false,
    functionThatReturnsDynamic(),
    [1, 2, 3],
    ['foo', 2, true],
    [new MyObject(), new MyObject()].map((obj) => obj.id),

    //
    // Unsupported types
    //
    {'just': 'a map'},
    new MyObject(),
    new Future(() {}),
    // Iterable type parameters are checked
    [new MyObject()],
    [1, 2, 3].map((_) => new MyObject()),
    [1, 2, 3].map((number) async => Dom.div()(number)),


    // Unsupported types, uninvoked builders: has quick fix
    Foo(),
    (Foo()),
    (Foo()..id = 'hi'),
    Foo()..id = 'hi',
  );
}

class MyObject {
  String id;
}

dynamic functionThatReturnsDynamic() {}
