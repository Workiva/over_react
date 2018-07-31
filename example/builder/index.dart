import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:react/react_dom.dart' as react_dom;

import 'abstract_inheritance.dart';
import 'basic.dart';
import 'generic_inheritance.dart';

main() {
  setClientConfiguration();
  react_dom.render(
      Dom.div()(
        (Basic()..basicProp = '<basicProp>')(),
        (Sub()
          ..superProp = '<superProp value>'
          ..subProp = '<subProp value>'
        )(),
        (GenericSuper()
          ..superProp = '<superProp>'
        )(),
        (GenericSub()
          ..superProp = '<superProp value>'
          ..subProp = '<subProp value>'
        )(),
      ), querySelector('#content')
  );

  <ComponentClassFactory>[
    () => new BasicComponent(),
    () => new SubComponent(),
//    () => new GenericSuperComponent(), // FIXME unsupported
    () => new BasicComponent(),
  ].forEach((componentClassFactory) {
    print('Default props: ${componentClassFactory().getDefaultProps()}');
  });
}

typedef UiComponent ComponentClassFactory();
