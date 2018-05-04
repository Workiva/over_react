import 'dart:html';
import 'package:over_react/react_dom.dart' as react_dom;
import 'package:react/react_client.dart';

import '../demos.dart';
import '../constants.dart';

main() {
  setClientConfiguration();

  react_dom.render(listGroupBasicDemo(),
      querySelector('$demoMountNodeSelectorPrefix--list-group-basic'));

  react_dom.render(listGroupTagsDemo(),
      querySelector('$demoMountNodeSelectorPrefix--list-group-tags'));

  react_dom.render(listGroupAnchorsAndButtonsDemo(),
      querySelector('$demoMountNodeSelectorPrefix--list-group-anchors-and-buttons'));

  react_dom.render(listGroupContextualSkinDemo(),
      querySelector('$demoMountNodeSelectorPrefix--list-group-contextual'));

  react_dom.render(listGroupHeaderDemo(),
      querySelector('$demoMountNodeSelectorPrefix--list-group-header'));
}
