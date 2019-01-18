import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:over_react/react_dom.dart' as react_dom;

import './demos/demos.dart';
import './demos/constants.dart';

void main() {
  setClientConfiguration();

  react_dom.render(
    buttonExamplesDemo(), querySelector('$demoMountNodeSelectorPrefix--button'));

  react_dom.render(
    listGroupBasicDemo(), querySelector('$demoMountNodeSelectorPrefix--list-group'));

  react_dom.render(
    progressBasicDemo(), querySelector('$demoMountNodeSelectorPrefix--progress'));

  react_dom.render(
    tagBasicDemo(), querySelector('$demoMountNodeSelectorPrefix--tag'));

  react_dom.render(
    checkboxToggleButtonDemo(), querySelector('$demoMountNodeSelectorPrefix--checkbox-toggle'));

  react_dom.render(
    radioToggleButtonDemo(), querySelector('$demoMountNodeSelectorPrefix--radio-toggle'));
}
