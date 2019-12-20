import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:react/react_client.dart';
import 'package:react/react_dom.dart' as react_dom;

import 'components/big_block.dart';
import './store.dart';

main() {
  setClientConfiguration();

  react_dom.render(
      ErrorBoundary()(
        (BigBlock()
          ..store = bigStore
          ..store2 = littleStore
          ..actions = randomColorActions
        )(),
      ),
      querySelector('#content'));
}
