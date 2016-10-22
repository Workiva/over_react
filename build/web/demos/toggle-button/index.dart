import 'dart:html';
import 'package:react/react.dart' as react;
import 'package:react/react_dom.dart' as react_dom;
import 'package:react/react_client.dart';
import 'package:over_react/over_react.dart';

import '../demos.dart';
import '../constants.dart';

main() {
  setClientConfiguration();

  react_dom.render(checkboxToggleButtonDemo(),
      querySelector('$demoMountNodeSelectorPrefix--toggle-button-checkbox'));

  react_dom.render(radioToggleButtonDemo(),
      querySelector('$demoMountNodeSelectorPrefix--toggle-button-radio'));
}
