import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:over_react/components.dart' as v2;
import 'package:react/react_client.dart';
import 'package:react/react_dom.dart' as react_dom;
import 'package:over_react/over_react_redux.dart';

import './components/counter.dart';
import './store.dart';

main() {
  setClientConfiguration();

  react_dom.render(
    v2.ErrorBoundary()(
      (ReduxProvider()..store = store1)(
        (ReduxProvider()
          ..store = store2
          ..context = bigCounterContext
        )(
          Dom.div()(
            Dom.h2()('ConnectedCounter Store1'),
            ConnectedCounter()(),
            Dom.h2()('ConnectedCounter Store2'),
            ConnectedCounterWithDifferentContext()(),
          ),
        ),
      ),
    ), querySelector('#content')
  );
}
