import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:react/react_client.dart';
import 'package:react/react_dom.dart' as react_dom;
import 'package:over_react/over_react_redux.dart';

import 'package:socketcluster_client/src/socket_platform.dart';
import 'package:socketcluster_client/src/socket_platform_http.dart';

import './components/counter.dart';
import './store.dart';

main() {
  setClientConfiguration();

//  globalSocketPlatform = HttpSocketPlatform();

  UiFactory<CounterProps> ConnectedCounter = connect<CounterState, CounterProps>(
    mapStateToProps: (state) => (Counter()..currentCount = state.count)
  )(Counter);

  UiFactory<CounterProps> ConnectedBigCounter = connect<BigCounterState, CounterProps>(
    mapStateToProps: (state) => (Counter()..currentCount = state.bigCount),
    mapDispatchToProps: (dispatch) => (
      Counter()
        ..increment = () { dispatch(IncrementAction(100)); }
        ..decrement = () { dispatch(DecrementAction(100)); }
    ),
    context: bigCounterContext,
  )(Counter);

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

