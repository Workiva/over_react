import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:over_react/react_dom.dart' as react_dom;

//import 'src/demos.dart';
import 'src/demo_components/simple.dart';
import 'src/demo_components/button.dart';
void main() {
  setClientConfiguration();

  react_dom.render(
    (Simple()..componentFactory = Button().componentFactory)(), querySelector('#test'));
}
