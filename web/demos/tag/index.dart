import 'dart:html';
import 'package:over_react/react_dom.dart' as react_dom;
import 'package:react/react_client.dart';

import '../demos.dart';
import '../constants.dart';

main() {
  setClientConfiguration();

  react_dom.render(tagBasicDemo(), querySelector('$demoMountNodeSelectorPrefix--tag-basic'));

  react_dom.render(tagContextualDemo(), querySelector('$demoMountNodeSelectorPrefix--tag-contextual'));

  react_dom.render(tagPillsDemo(), querySelector('$demoMountNodeSelectorPrefix--tag-pills'));
}
