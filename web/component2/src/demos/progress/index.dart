import 'dart:html';

import 'package:over_react/react_dom.dart' as react_dom;
import 'package:over_react/over_react.dart';

import '../../demos.dart';

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
