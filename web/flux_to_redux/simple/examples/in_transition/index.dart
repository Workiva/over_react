import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:react/react_client.dart';
import 'package:react/react_dom.dart' as react_dom;
import 'package:over_react/over_react_redux.dart';

import '../../components/random_color.dart';
import '../../components/random_color_redux.dart';
import '../../components/random_color_connect_flux.dart';
import '../../components/should_not_update.dart';
import '../../stores.dart';

main() {
  setClientConfiguration();

  react_dom.render(
      ErrorBoundary()(
        (ReduxProvider()..store = adaptedStore)(
          (RandomColor()
            ..store = store
            ..actions = actions
          )(),
          ConnectedRandomColorConnectFlux()(),
          ConnectedRandomColorRedux()(),
          ConnectedShouldNotUpdate()(),
        ),
      ),
      querySelector('#content'));
}
