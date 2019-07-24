import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:react/react_client.dart';
import 'package:react/react_dom.dart' as react_dom;
import './components/counter.dart';
import 'package:over_react/over_react_redux.dart';
import 'store.dart';

main() {
  setClientConfiguration();

  // Create a connected version of Counter with Counter Store
  UiFactory<CounterProps> ConnectedCounter = connect<CounterState, CounterProps>
    (mapStateToProps: (state) => (Counter()..intProp = state.count..customStyles = {'border': '1px solid blue'}))
    (Counter);

  // Create a connected version of Counter with BigCounter Store
  UiFactory<CounterProps> ConnectedBigCounter = connect<BigCounterState, CounterProps>
    (mapStateToProps: (state) => (Counter()..intProp = state.bigCount..customStyles = {'border': '1px solid red'}), context: bigCounterContext)
    (Counter);

  react_dom.render(
    Dom.div()(
      (ReduxProvider()..store = store1)(
        (ReduxProvider()
          ..store = store2
          ..context = bigCounterContext
        )(
          Dom.div()(
            Dom.h3()('ConnectedCounter Store1'),
            ConnectedCounter()('test'),
            Dom.h3()('counterContext Store1 context Consumer'),
            // bigCounterContext.Consumer()(
            //   (dynamic val) {
            //     print('counterContext.Consumer()');
            //     window.console.log(val.store.getState().value.count);
            //   }
            // )
          ),
          Dom.div()(
            Dom.h3()('ConnectedBigCounter Store2'),
            ConnectedBigCounter()(
              Dom.h4()('ConnectedCounter Store1'),
              ConnectedCounter()(),
            ),
          ),
        ),
      ),
    ), querySelector('#content')
  );
}
