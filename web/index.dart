import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:over_react/react_dom.dart' as react_dom;
import 'package:react/react_client.dart' show setClientConfiguration;
import './demos/demos.dart';
import './demos/constants.dart';
import 'src/demos/faulty-component.dart';

void main() {
  setClientConfiguration();

  react_dom.render(
    ErrorBoundary()(buttonExamplesDemo()), querySelector('$demoMountNodeSelectorPrefix--button'));

  react_dom.render(
    ErrorBoundary()(listGroupBasicDemo()), querySelector('$demoMountNodeSelectorPrefix--list-group'));

  react_dom.render(
    ErrorBoundary()(progressBasicDemo()), querySelector('$demoMountNodeSelectorPrefix--progress'));

  react_dom.render(
    ErrorBoundary()(tagBasicDemo()), querySelector('$demoMountNodeSelectorPrefix--tag'));

  react_dom.render(
    ErrorBoundary()(checkboxToggleButtonDemo()), querySelector('$demoMountNodeSelectorPrefix--checkbox-toggle'));

  react_dom.render(
    ErrorBoundary()(radioToggleButtonDemo()), querySelector('$demoMountNodeSelectorPrefix--radio-toggle'));

  react_dom.render(
    (ErrorBoundary()
      ..onComponentDidCatch = (error, info) {
        print('Consumer props.onComponentDidCatch($error, $info)');
      }
    )(Faulty()()),
    querySelector('$demoMountNodeSelectorPrefix--faulty-component'),
  );

  react_dom.render(
    Faulty()(), querySelector('$demoMountNodeSelectorPrefix--faulty-component-without-error-boundary'));
}
