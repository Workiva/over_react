import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:react/react_client.dart';
import 'package:react/react_dom.dart' as react_dom;

import './components/random_color.dart';
import './store.dart';

main() {
  setClientConfiguration();

  react_dom.render(
      ErrorBoundary()(
        (RandomColor()
          ..store = randomColorStore
          ..actions = randomColorActions
        )(),
      ),
      querySelector('#content'));
}
