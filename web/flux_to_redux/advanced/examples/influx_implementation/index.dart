import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:over_react/components.dart' as v2;
import 'package:over_react/over_react_flux.dart';
import 'package:react/react_client.dart';
import 'package:react/react_dom.dart' as react_dom;

import './components/big_block.dart';
import './components/redux_big_block.dart';
import './components/connect_flux_big_block.dart';
import 'components/should_not_update.dart';
import './store.dart';

main() {
  setClientConfiguration();

  react_dom.render(
      v2.ErrorBoundary()(
        // Note the use of the `ReduxMultiProvider` as opposed to a traditional
        // `ReduxProvider`, and that the stores being passed in are the
        // `FluxToReduxAdapterStore`s.
        (ReduxMultiProvider()
          ..storesByContext = {
            randomColorStoreContext: randomColorStoreAdapter,
            lowLevelStoreContext: lowLevelStoreAdapter,
            anotherColorStoreContext: anotherColorStoreAdapter,
          }
        )(
          (BigBlock()
            ..store = randomColorStore
            ..lowLevelStore = lowLevelStore
            ..secondStore = anotherColorStore
            ..actions = randomColorActions
          )(),
          // Note that the components being instantiated are the factories that
          // are returned from the corresponding `composeHocs` calls, and not the
          // original component factories.
          ConnectedConnectFluxBigBlock()(),
          ConnectedReduxBigBlock()(),
          ConnectedShouldNotUpdate()(),
        ),
      ),
      querySelector('#content'));
}
