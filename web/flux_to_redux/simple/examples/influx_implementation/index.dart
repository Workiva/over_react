import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:react/react_client.dart';
import 'package:react/react_dom.dart' as react_dom;
import 'package:over_react/over_react_redux.dart';

import './components/random_color.dart';
import './components/redux_random_color.dart';
import './components/connect_flux_random_color.dart';
import './components/should_not_update.dart';
import './store.dart';

main() {
  setClientConfiguration();

  react_dom.render(
      ErrorBoundary()(
        (ReduxProvider()..store = adaptedStore)(
          (RandomColor()
            ..store = randomColorStore
            ..actions = randomColorActions
          )(),
          ConnectedConnectFluxRandomColor()(),
          ConnectedReduxRandomColor()(),
          ConnectedShouldNotUpdate()(),
        ),
      ),
      querySelector('#content'));
}
