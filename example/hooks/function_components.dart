import 'dart:html';

import 'package:over_react/over_react.dart';

// ignore_for_file: uri_has_not_been_generated
part 'function_components.over_react.g.dart';

UiFactory<UiProps> UseStateTest = uiFunction((props) {
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
    FunctionComponentConfig(
      displayName: 'UseStateTest',
    ));

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
  FunctionComponentConfig(
    displayName: 'UseCallbackTest',
  ),
);

Context countContext = createContext(0);

final UseContextTest = uiFunction<UiProps>(
  (props) {
    final count = useContext(countContext);

    return Dom.div()(
      Dom.div()(
          'The count from context is $count'), // initially renders: 'The count from context is 0'
    );
  },
  FunctionComponentConfig(displayName: 'UseContextTest'),
);

//final UseContextTest = uiFunction<UiProps>((props) {
//  final context = useContext(TestNewContext);
//  return Dom.div()(
//    Dom.div()('useContext counter value is ${context['renderCount']}'),
//  );
//}, FunctionComponentConfig(displayName: 'UseContextTest'));
//
//int calculateChangedBits(currentValue, nextValue) {
//  int result = 1 << 1;
//  if (nextValue['renderCount'] % 2 == 0) {
//    result |= 1 << 2;
//  }
//  return result;
//}
//
//var TestNewContext =
//    createContext<Map>({'renderCount': 0}, calculateChangedBits);
//
//final NewContextProvider = uiFunction<UiProps>(
//  (props) {
//    final renderCount = useState(0);
//    final complexMap = useState(false);
//
//    _onButtonClick(event) {
//      renderCount.setWithUpdater((oldValue) => oldValue + 1);
//      complexMap.set(false);
//    }
//
//    final provideMap = {'renderCount': renderCount.value};
//
//    return (Dom.div()..style = {'marginTop': 20})(
//      (Dom.button()
//        ..className = 'btn btn-primary'
//        ..onClick = _onButtonClick)('Redraw'),
//      Dom.br()(),
//      'TestContext.Provider props.value: $provideMap',
//      Dom.br()(),
//      Dom.br()(),
//      (TestNewContext.Provider()..value = provideMap)(props.children),
//    );
//  },
//  FunctionComponentConfig(displayName: '_NewContextProvider'),
//);

UiFactory<UiProps> UseRefTest = uiFunction(
  (props) {
    final inputValue = useState('');

    final inputRef = useRef<InputElement>();
    final prevInputValueRef = useRef<String>();

    useEffect(() {
      prevInputValueRef.current = inputValue.value;
    });

    return Fragment()(
      Dom.p()('Current Input: ${inputValue.value}, '
          'Previous Input: ${prevInputValueRef.current}'),
      (Dom.input()..ref = inputRef)(),
      (Dom.button()
        ..onClick = (_) => inputValue.set(inputRef.current.value))('Update'),
    );
  },
  FunctionComponentConfig(displayName: 'UseRefTest'),
);

int fibonacci(int n) {
  if (n <= 1) {
    return 1;
  }
  return fibonacci(n - 1) + fibonacci(n - 2);
}

UiFactory<UiProps> UseMemoTest = uiFunction(
  (props) {
    final count = useState(0);

    final fib = useMemo(
      () => fibonacci(count.value),

      /// This dependency prevents [fib] from being re-calculated every time the component re-renders.
      [count.value],
    );

    return Fragment()(
      Dom.div()('Fibonacci of ${count.value} is $fib'),
      (Dom.button()
        ..onClick = (_) => count.setWithUpdater((prev) => prev + 1))('+'),
    );
  },
  FunctionComponentConfig(displayName: 'UseMemoTest'),
);

UiFactory<UiProps> UseLayoutEffectTest = uiFunction(
  (props) {
    final width = useState(0);
    final height = useState(0);

    Ref textareaRef = useRef();

    useLayoutEffect(() {
      width.set(textareaRef.current.clientWidth);
      height.set(textareaRef.current.clientHeight);
    });

    return Fragment()(
      Dom.div()('textarea width: ${width.value}'),
      Dom.div()('textarea height: ${height.value}'),
      (Dom.textarea()
        ..ref = textareaRef
        ..onClick = (_) => width.set(0))(),
    );
  },
  FunctionComponentConfig(displayName: 'UseLayoutEffectTest'),
);

mixin FancyInputProps on UiProps {
  String value;
  Function updater;
  Ref forwardedRef;
}

class FancyInputApi {
  final void Function() focus;
  FancyInputApi(this.focus);
}

UiFactory<FancyInputProps> FancyInput =
    forwardRef<FancyInputProps>((props, ref) {
  return (_FancyInput()
    ..forwardedRef = ref
    ..addProps(props))();
})(_FancyInput);

UiFactory<FancyInputProps> _FancyInput = uiFunction(
  (props) {
    final inputRef = useRef<InputElement>();

    useImperativeHandle(
      props.forwardedRef,
      () => FancyInputApi(() => inputRef.current.focus()),

      /// Because the return value of [createHandle] never changes, it is not necessary for [ref.current]
      /// to be re-set on each render so this dependency list is empty.
      [],
    );

    return (Dom.input()
      ..ref = inputRef
      ..value = props.value
      ..onChange = (e) => props.updater(e.target.value))();
  },
  $_FancyInputConfig, // ignore: undefined_identifier
);

UiFactory<UiProps> UseImperativeHandleTest = uiFunction(
  (props) {
    final inputValue = useState('');
    final fancyInputRef = useRef<FancyInputApi>();

    return Fragment()(
      (FancyInput()
        ..ref = fancyInputRef
        ..value = inputValue.value
        ..updater = inputValue.set)(),
      (Dom.button()
        ..onClick = (_) => fancyInputRef.current.focus())('Focus Input'),
    );
  },
  FunctionComponentConfig(displayName: 'UseImperativeHandleTest'),
);

class ChatAPI {
  static void subscribeToFriendStatus(int id, Function handleStatusChange) =>
      handleStatusChange({'isOnline': id % 2 == 0});

  static void unsubscribeFromFriendStatus(
          int id, Function handleStatusChange) =>
      handleStatusChange({'isOnline': false});
}

// Custom Hook
StateHook useFriendStatus(int friendID) {
  final isOnline = useState(false);

  void handleStatusChange(Map status) {
    isOnline.set(status['isOnline']);
  }

  useEffect(() {
    ChatAPI.subscribeToFriendStatus(friendID, handleStatusChange);
    return () {
      ChatAPI.unsubscribeFromFriendStatus(friendID, handleStatusChange);
    };
  });

  // Use format function to avoid unnecessarily formatting `isOnline` when the hooks aren't inspected in React DevTools.
  useDebugValue<bool>(
      isOnline.value, (isOnline) => isOnline ? 'Online' : 'Not Online');

  return isOnline;
}

mixin FriendListItemProps on UiProps {
  Map<String, dynamic> friend;
}

final FriendListItem = uiFunction<FriendListItemProps>(
  (props) {
    final isOnline = useFriendStatus(props.friend['id']);

    return (Dom.li()..style = {'color': isOnline.value ? 'green' : 'black'})(
        props.friend['name']);
  },
  $FriendListItemConfig,
);

final UseDebugValueTest = uiFunction<UiProps>(
  (props) => Fragment()(
    (FriendListItem()..friend = {'id': 1, 'name': 'user 1'})(),
    (FriendListItem()..friend = {'id': 2, 'name': 'user 2'})(),
    (FriendListItem()..friend = {'id': 3, 'name': 'user 3'})(),
    (FriendListItem()..friend = {'id': 4, 'name': 'user 4'})(),
  ),
  FunctionComponentConfig(displayName: 'UseDebugValueTest'),
);
