import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:react/react_dom.dart' as react_dom;

import 'basic.dart';
import 'generic_inheritance.dart';

main() {
  setClientConfiguration();
  react_dom.render(
      Dom.div()(
        (Basic()..basicProp = '<basicProp>')(),
        (GenericSuper()
          ..superProp = '<superProp>'
        )(),
        (GenericSub()
          ..superProp = '<superProp value>'
          ..subProp = '<subProp value>'
        )(),
      ), querySelector('#content')
  );
}
