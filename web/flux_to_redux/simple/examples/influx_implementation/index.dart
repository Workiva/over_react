import 'dart:html';

import 'package:over_react/components.dart';
import 'package:react/react_dom.dart' as react_dom;
import 'package:over_react/over_react_redux.dart';

import './components/big_block.dart';
import './components/redux_big_block.dart';
import './components/connect_flux_big_block.dart';
import './components/should_not_update.dart';
import './store.dart';

main() {
  react_dom.render(
      ErrorBoundary()(
        (ReduxProvider()..store = adaptedStore)(
          (BigBlock()
            ..store = randomColorStore
            ..actions = randomColorActions
          )(),
          // Note that the components being instantiated are the factories that
          // are returned from the corresponding `connect` calls, and not the
          // original component factories.
          ConnectedConnectFluxBigBlock()(),
          ConnectedReduxBigBlock()(),
          ConnectedShouldNotUpdate()(),
        ),
      ),
      querySelector('#content'));
}
