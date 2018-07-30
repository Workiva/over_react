import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:react/react_dom.dart' as react_dom;

import 'foo.dart' as foo;
import 'foo_generic.dart' as foo_generic;

main() {
  setClientConfiguration();
  react_dom.render(
      Dom.div()(
        (foo.Foo()..fooProp = '<fooProp>')(),
        (foo_generic.Super()
          ..superProp = '<superProp>'
        )(),
        (foo_generic.Foo()
          ..superProp = '<superProp value>'
          ..fooProp = '<fooProp value>'
        )(),
      ), querySelector('#content')
  );
}
