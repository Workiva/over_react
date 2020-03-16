import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:over_react/components.dart' as v2;
import 'package:react/react_client.dart';
import 'package:react/react_dom.dart' as react_dom;
import 'package:over_react/over_react_redux.dart';

import './components/should_not_update.dart';
import './components/big_block.dart';
import './store.dart';

main() {
  setClientConfiguration();

  react_dom.render(
      v2.ErrorBoundary()(
        (ReduxProvider()..store = randomColorStore)(
          ConnectedBigBlock()(),
          ConnectedShouldNotUpdate()(),
        ),
      ),
      querySelector('#content'));
}
