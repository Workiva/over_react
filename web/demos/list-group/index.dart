import 'dart:html';
import 'package:react/react_dom.dart' as react_dom;
import 'package:react/react_client.dart';
import 'package:over_react/over_react.dart';

main() {
  setClientConfiguration();

  var foo = Dom.div()(
    'foo'
  );

  // Mount / render your component.
  react_dom.render(foo, querySelector('.component-demo__mount'));
}
