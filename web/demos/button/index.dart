import 'dart:html';
import 'package:react/react.dart' as react;
import 'package:react/react_dom.dart' as react_dom;
import 'package:react/react_client.dart';
import 'package:over_react/over_react.dart';

import '../demos.dart';
import '../constants.dart';

main() {
  setClientConfiguration();

  react_dom.render(buttonExamplesDemo(),
      querySelector('$demoMountNodeSelectorPrefix--button-examples'));

  react_dom.render(buttonTypesDemo(),
      querySelector('$demoMountNodeSelectorPrefix--button-types'));

  react_dom.render(buttonOutlineDemo(),
      querySelector('$demoMountNodeSelectorPrefix--button-outline'));

  react_dom.render(buttonSizesDemo(),
      querySelector('$demoMountNodeSelectorPrefix--button-sizes'));

  react_dom.render(buttonBlockDemo(),
      querySelector('$demoMountNodeSelectorPrefix--button-block'));

  react_dom.render(buttonActiveDemo(),
      querySelector('$demoMountNodeSelectorPrefix--button-active'));

  react_dom.render(buttonDisabledDemo(),
      querySelector('$demoMountNodeSelectorPrefix--button-disabled'));
}
