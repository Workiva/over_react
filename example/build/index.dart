import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:react/react_dom.dart' as react_dom;

import 'foo.dart';

main() {
  setClientConfiguration();
  react_dom.render((Foo()..fooProp = 'fooProp')(), querySelector('#content'));

  print(new AccessorOverride());
}



class Parent {
  int field;
}

class AccessorOverride extends Parent {
  int _field;

//  @override
//  int get field => _field;
//  @override
//  set field(int value) => _field = value;

  @override
  int field;

  AccessorOverride() {
    super.field = 1;
    field = 2;
    super.field = 3;
  }

  toString() => 'field: $field, super.field: ${super.field}';
}
