import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:react/react_client.dart';
import 'package:react/react_dom.dart' as react_dom;
import 'package:over_react/over_react_redux.dart';

import '../../components/counter.dart';
import './store.dart';

main() {
  setClientConfiguration();

  // Spin up Redux DevTools
  initDevtools();

  react_dom.render(
    ErrorBoundary()(
      (ReduxProvider()..store = store1)(
        (ReduxProvider()
          ..store = store2
          ..context = bigCounterContext
        )(
          Dom.div()(
            Dom.h2()('ConnectedBigCounter Store2'),
            ConnectedBigCounter()(
              Dom.h2()('ConnectedCounter Store1'),
              ConnectedCounter()(),
            ),
          ),
        ),
      ),
    ), querySelector('#content')
  );
}

