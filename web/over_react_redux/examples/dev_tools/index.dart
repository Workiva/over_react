import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:over_react/components.dart' as v2;
import 'package:react/react_dom.dart' as react_dom;
import 'package:over_react/over_react_redux.dart';

import './components/counter.dart';
import './store.dart';

main() {
  react_dom.render(
    v2.ErrorBoundary()(
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
