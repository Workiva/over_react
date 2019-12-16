import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_flux.dart';
import 'package:react/react_client.dart';
import 'package:react/react_dom.dart' as react_dom;
import 'package:over_react/over_react_redux.dart';

import './components/random_color.dart';
import './components/random_color_redux.dart';
import './components/random_color_connect_flux.dart';
import '../../components/stores.dart';

main() {
  setClientConfiguration();

  react_dom.render(
      ErrorBoundary()(
          (ReduxMultiProvider()..storesByContext = {
            inTransitionTopLevelStoreContext: inTransitionTopLevelAdapter,
            inTransitionLowLevelStoreContext: inTransitionLowLevelAdapter,
            inTransitionSecondStoreContext: inTransitionSecondStoreAdapter,
          })(
            (RandomColor()
              ..store = inTransitionTopLevelStore
              ..lowLevelStore = inTransitionLowLevelStore
              ..secondStore = inTransitionSecondStore
              ..actions = inTransitionActions)(),
            ConnectedRandomColorConnectFlux()(),
            (ConnectedRandomColorRedux())(),
          )
      ), querySelector('#content')
  );
}
