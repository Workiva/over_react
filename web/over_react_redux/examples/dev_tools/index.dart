import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:react/react_client.dart';
import 'package:react/react_dom.dart' as react_dom;
import 'package:over_react/over_react_redux.dart';

import './components/counter.dart';
import './store.dart';

main() {
  setClientConfiguration();

  // Make the call to assign the store and connect the devtools.
  initDevtools();

  react_dom.render(
    ErrorBoundary()(
      (ReduxProvider()..store = store)(
        Dom.div()(
          Dom.h2()('ConnectedBigCounter'),
          ConnectedBigCounter()(),
          Dom.h2()('ConnectedCounter'),
          ConnectedCounter()(),
        ),
      ),
    ), querySelector('#content')
  );
}

