import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:react/react_client.dart' show ReactDartComponentFactoryProxy;
import 'package:react/react_dom.dart' as react_dom;

import './builder/abstract_inheritance.dart';
import './builder/basic.dart';
import './builder/basic_library.dart';
import './builder/generic_inheritance_sub.dart';
import './builder/generic_inheritance_super.dart';

main() {
  setClientConfiguration();
  print('working...');
  react_dom.render(
      Dom.div()(
        Dom.h3()('Components'),
        (Basic()
          ..basic1 = '<basic prop>'
          ..id = 'the id of this component'
        )(),
        (Sub()
          ..superProp = '<superProp value>'
          ..subProp = '<subProp value>'
        )(),
        (GenericSub()
          ..superProp = '<superProp value>'
          ..subProp = '<subProp value>'
        )(),
        (GenericSuper()
          ..superProp = '<superProp>'
        )(),
        (BasicPartOfLib()
          ..basicProp = 'basic part of lib'
          ..propMixin1 = 'mixin to basic part of lib'
        )(),
        (SubPartOfLib()
          ..subProp = 'sub prop part of lib'
          ..superProp = 'super prop part of lib'
        )(),
        Dom.h3()('getDefaultProps via component factories'),
        componentConstructorsByName.keys.map((name) => Dom.div()(
          'new $name()',
          ' - ',
          componentConstructorsByName[name]().toString(),
        )).toList(),
      ), querySelector('#content')
  );
}

typedef Map GetDefaultProps();

final componentConstructorsByName = <String, GetDefaultProps>{
  'BasicComponent': () => getDefaultPropsFor(Basic),
  'SubComponent': () => getDefaultPropsFor(Sub),
  'GenericSuperComponent': () => getDefaultPropsFor(GenericSuper),
  'GenericSubComponent': () => getDefaultPropsFor(GenericSub),
};

/// FIXME move to over_react public API
Map getDefaultPropsFor(BuilderOnlyUiFactory factory) {
  final componentFactory = factory().componentFactory;
  if (componentFactory is ReactDartComponentFactoryProxy) {
    return componentFactory.defaultProps;
  }
  throw new ArgumentError.value(factory, 'factory', 'must be a ReactDartComponentFactoryProxy');
}
