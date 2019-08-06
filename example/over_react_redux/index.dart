import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:react/react_client.dart';
import 'package:react/react_dom.dart' as react_dom;
import './components/counter.dart';
import 'package:over_react/over_react_redux.dart';
import 'store.dart';

main() {
  setClientConfiguration();

  UiFactory<CounterProps> ConnectedCounter = connect<CounterState, CounterProps>(
    mapStateToProps: (state) => (Counter()..intProp = state.count)
  )(Counter);

  UiFactory<CounterProps> ConnectedBigCounter = connect<BigCounterState, CounterProps>(
    mapStateToProps: (state) => (Counter()..intProp = state.bigCount),
    context: bigCounterContext,
  )(Counter);

  react_dom.render(
    Dom.div()(
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
