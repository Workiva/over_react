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
        Dom.h3()('Components'),
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
        Dom.h3()('getDefaultProps via component class constructors'),
        componentConstructorsByName.keys.map((name) => Dom.div()(
          'new $name()',
          ' - ',
          componentConstructorsByName[name]().getDefaultProps().toString(),
        )).toList(),
      ), querySelector('#content')
  );
}

typedef UiComponent ComponentClassConstructor();

final componentConstructorsByName = <String, ComponentClassConstructor>{
  'BasicComponent': () => new BasicComponent(),
  'SubComponent': () => new SubComponent(),
  'GenericSuperComponent': () => new GenericSuperComponent(),
  'GenericSubComponent': () => new GenericSubComponent(),
};
