import 'dart:html';
import 'package:react/react.dart' as react;
import 'package:react/react_dom.dart' as react_dom;
import 'package:react/react_client.dart';
import 'package:over_react/over_react.dart';

import '../demos.dart';
import '../constants.dart';

main() {
  setClientConfiguration();

  react_dom.render(progressBasicDemo(),
      querySelector('$demoMountNodeSelectorPrefix--progress-basic'));

  react_dom.render(progressContextualDemo(),
      querySelector('$demoMountNodeSelectorPrefix--progress-contextual'));

  react_dom.render(progressStripedDemo(),
      querySelector('$demoMountNodeSelectorPrefix--progress-striped'));

  react_dom.render(progressAnimatedStripesDemo(),
      querySelector('$demoMountNodeSelectorPrefix--progress-animated-stripes'));
}
