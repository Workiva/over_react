import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:over_react/react_dom.dart' as react_dom;

import 'src/demos.dart';

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

  react_dom.render(
    (ErrorBoundary()
      ..onComponentDidCatch = (error, info) {
        print('Consumer props.onComponentDidCatch($error, $info)');
      }
    )(Faulty()()),
    querySelector('$demoMountNodeSelectorPrefix--faulty-component'),
  );

  react_dom.render(
    (ErrorBoundary()
      ..onComponentDidCatch = (error, info) {
        print('Consumer props.onComponentDidCatch($error, $info)');
      }
    )(FaultyOnMount()()),
    querySelector('$demoMountNodeSelectorPrefix--faulty-on-mount-component'),
  );

  react_dom.render(
    (ErrorBoundary()
      ..onComponentDidCatch = (error, info) {
        print('Consumer props.onComponentDidCatch($error, $info)');
      }
      ..fallbackUIRenderer = (_, __) {
        return (Dom.div()..id = 'FallbackUi')('I am a fallback.');
      }
    )(FaultyOnMount()()),
    querySelector('$demoMountNodeSelectorPrefix--faulty-on-mount-fallback-component'),
  );

  react_dom.render(
    (CustomErrorBoundary()
      ..onComponentDidCatch = (error, info) {
        print('Consumer props.onComponentDidCatch($error, $info)');
      }
    )(Faulty()()),
    querySelector('$demoMountNodeSelectorPrefix--faulty-component-with-custom-error-boundary'),
  );

  react_dom.render(
    Faulty()(), querySelector('$demoMountNodeSelectorPrefix--faulty-component-without-error-boundary'));

  react_dom.render(PropTypesWrap()(), querySelector('$demoMountNodeSelectorPrefix--proptypes-component'));
}
