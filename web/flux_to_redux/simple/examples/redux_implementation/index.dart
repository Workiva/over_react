import 'dart:html';

import 'package:over_react/components.dart';
import 'package:react/react_dom.dart' as react_dom;
import 'package:over_react/over_react_redux.dart';

import './components/should_not_update.dart';
import './components/big_block.dart';
import './store.dart';

main() {
  react_dom.render(
      ErrorBoundary()(
        (ReduxProvider()..store = randomColorStore)(
          ConnectedBigBlock()(),
          ConnectedShouldNotUpdate()(),
        ),
      ),
      querySelector('#content'));
}
