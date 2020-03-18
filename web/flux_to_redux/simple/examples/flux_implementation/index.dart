import 'dart:html';

import 'package:over_react/components.dart';
import 'package:react/react_dom.dart' as react_dom;

import './components/big_block.dart';
import './store.dart';

main() {
  react_dom.render(
      ErrorBoundary()(
        (BigBlock()
          ..store = randomColorStore
          ..actions = randomColorActions
        )(),
      ),
      querySelector('#content'));
}
