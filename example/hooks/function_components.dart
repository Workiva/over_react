import 'package:over_react/over_react.dart';
import 'package:over_react/react_dom.dart';

// ignore_for_file: uri_has_not_been_generated
part 'function_components.over_react.g.dart';

UiFactory<UiProps> UseStateTest = uiFunction(
  (props) {
    final count = useState(1);
    final evenOdd = useState('even');

    useEffect(() {
      if (count.value % 2 == 0) {
        print('count changed to ' + count.value.toString());
        evenOdd.set('even');
      } else {
        print('count changed to ' + count.value.toString());
        evenOdd.set('odd');
      }
      return () {
        print('count is changing... do some cleanup if you need to');
      };

      /// This dependency prevents the effect from running every time [evenOdd.value] changes.
    }, [count.value]);

    return Fragment()(
      (Dom.button()..onClick = (_) => count.set(1))('Reset'),
      (Dom.button()
        ..onClick = (_) => count.setWithUpdater((prev) => prev + 1))('+'),
      Dom.br()(),
      Dom.p()('${count.value} is ${evenOdd.value}'),
    );
  },
  null,
  displayName: 'UseStateTest',
);

Map initializeCount(int initialValue) {
  return {'count': initialValue};
}

Map reducer(Map state, Map action) {
  switch (action['type']) {
    case 'increment':
      return {...state, 'count': state['count'] + 1};
    case 'decrement':
      return {...state, 'count': state['count'] - 1};
    case 'reset':
      return initializeCount(action['payload']);
    default:
      return state;
  }
}

mixin UseReducerTestProps on UiProps {
  int initialCount;
}

UiFactory<UseReducerTestProps> UseReducerTest = uiFunction(
  (props) {
    final ReducerHook<Map, Map, int> state =
        useReducerLazy(reducer, props.initialCount, initializeCount);

    return Fragment()(
      state.state['count'],
      (Dom.button()
        ..onClick = (_) => state.dispatch({'type': 'increment'}))('+'),
      (Dom.button()
        ..onClick = (_) => state.dispatch({'type': 'decrement'}))('-'),
      (Dom.button()
        ..onClick = (_) => state.dispatch({
              'type': 'reset',
              'payload': props.initialCount,
            }))('reset'),
    );
  },
  $UseReducerTestConfig, // ignore: undefined_identifier
  displayName: 'UseReducerTest',
);

UiFactory<UiProps> UseCallbackTest = uiFunction(
  (props) {
    final count = useState(0);
    final delta = useState(1);

    var increment = useCallback((_) {
      count.setWithUpdater((prev) => prev + delta.value);
    }, [delta.value]);

    var incrementDelta = useCallback((_) {
      delta.setWithUpdater((prev) => prev + 1);
    }, []);

    return Fragment()(
      Dom.div()('Delta is ${delta.value}'),
      Dom.div()('Count is ${count.value}'),
      (Dom.button()..onClick = increment)('Increment count'),
      (Dom.button()..onClick = incrementDelta)('Increment delta'),
    );
  },
  null,
  displayName: 'UseCallbackTest',
);
