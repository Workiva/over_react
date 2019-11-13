import 'package:over_react/over_react_redux.dart';
import 'package:redux/redux.dart';

// Imports for the DevTools
import 'package:redux_dev_tools/redux_dev_tools.dart';

class Action {
  Action({this.type, this.value});

  final String type;
  final dynamic value;

  /// Used to encode the data structure for the Redux DevTools.
  ///
  /// The DevTools expect plain JavaScript objects with the `type` property. To
  /// facilitate that, a method such as [toJson] is necessary.
  /// > See: <https://github.com/MichaelMarner/dart-redux-remote-devtools#encoding-actions-and-state>
  toJson() {
    return {
      'type': this.type,
      'value': this.value,
    };
  }
}

class SmallIncrementAction extends Action {
  SmallIncrementAction():super(type: 'SMALL_INCREMENT_ACTION', value: 1);
}

class SmallDecrementAction extends Action {
  SmallDecrementAction():super(type: 'SMALL_DECREMENT_ACTION', value: 1);
}

class BigIncrementAction extends Action {
  BigIncrementAction():super(type: 'BIG_INCREMENT_ACTION', value: 100);
}

class BigDecrementAction extends Action {
  BigDecrementAction():super(type: 'BIG_DECREMENT_ACTION', value: 100);
}

/////////////////////////////// STORE 1 "Counter" ///////////////////////////////

/// A store connected to DevTools.
///
/// Note the use of the special class [DevToolsStore] and the middleware passed
/// into the store.
Store store = DevToolsStore<CounterState>(
  stateReducer,
  initialState: CounterState.defaultState(),
  middleware: [overReactReduxDevToolsMiddleware],
);

class CounterState {
  final int smallCount;
  final int bigCount;
  final String name;

  CounterState({
    this.smallCount,
    this.bigCount,
    this.name,
  });

  CounterState.defaultState({this.smallCount = 1, this.bigCount = 100, this.name = 'Counter'});

  CounterState.updateState(CounterState oldState, {int smallCount, int bigCount, String name})
      : this.smallCount = smallCount ?? oldState.smallCount,
        this.bigCount = bigCount ?? oldState.bigCount,
        this.name = name ?? oldState.name;

  toJson() {
    return {
      'smallCount': this.smallCount,
      'bigCount': this.bigCount,
      'name': this.name
    };
  }
}

int smallCountReducer(CounterState oldState, dynamic action) {
  if (action is SmallDecrementAction) {
    return oldState.smallCount - action.value;
  } else if (action is SmallIncrementAction) {
    return oldState.smallCount + action.value;
  } else {
    return oldState.smallCount;
  }
}

int bigCountReducer(CounterState oldState, dynamic action) {
  if (action is BigDecrementAction) {
    return oldState.bigCount - action.value;
  } else if (action is BigIncrementAction) {
    return oldState.bigCount + action.value;
  } else {
    return oldState.bigCount;
  }
}

CounterState stateReducer([CounterState state, dynamic action]) => CounterState(
    bigCount: bigCountReducer(state, action),
    smallCount: smallCountReducer(state, action),
);
