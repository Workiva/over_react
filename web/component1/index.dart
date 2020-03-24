import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:over_react/components.dart' as v2;
import 'package:over_react/react_dom.dart' as react_dom;

import 'src/demos.dart';

void main() {
  setClientConfiguration();

  react_dom.render(
    v2.ErrorBoundary()(buttonExamplesDemo()), querySelector('$demoMountNodeSelectorPrefix--button'));

  react_dom.render(
    v2.ErrorBoundary()(listGroupBasicDemo()), querySelector('$demoMountNodeSelectorPrefix--list-group'));

  react_dom.render(
    v2.ErrorBoundary()(progressBasicDemo()), querySelector('$demoMountNodeSelectorPrefix--progress'));

  react_dom.render(
    v2.ErrorBoundary()(tagBasicDemo()), querySelector('$demoMountNodeSelectorPrefix--tag'));

  react_dom.render(
    v2.ErrorBoundary()(checkboxToggleButtonDemo()), querySelector('$demoMountNodeSelectorPrefix--checkbox-toggle'));

  react_dom.render(
    v2.ErrorBoundary()(radioToggleButtonDemo()), querySelector('$demoMountNodeSelectorPrefix--radio-toggle'));

  react_dom.render(
    (v2.ErrorBoundary()
      ..onComponentDidCatch = (error, info) {
        print('Consumer props.onComponentDidCatch($error, $info)');
      }
    )(Faulty()()),
    querySelector('$demoMountNodeSelectorPrefix--faulty-component'),
  );

  react_dom.render(
    Faulty()(), querySelector('$demoMountNodeSelectorPrefix--faulty-component-without-error-boundary'));
}
