// Copyright 2020 Workiva Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:redux/redux.dart';

/// An action class can be created to add typing to the actions passed into dispatch.
///
/// While it can make life easier, this practice is optional as all as the
/// reducer receives a valid type and value parameter.
class Action<T> {
  Action({this.type, required this.value});

  final String? type;
  final T value;

  /// Used to encode the data structure for the Redux DevTools.
  ///
  /// The DevTools expect plain JavaScript objects with the `type` property. To
  /// facilitate that, a method such as [toJson] is necessary.
  /// > See: <https://github.com/MichaelMarner/dart-redux-remote-devtools#encoding-actions-and-state>
  toJson() {
    return {'type': this.type, 'value': this.value};
  }
}

/// Actions to be passed into `dispatch`.
///
/// Note that the value can be hardcoded or passed into the constructor.
class SmallIncrementAction extends Action<int> {
  SmallIncrementAction():super(type: 'SMALL_INCREMENT_ACTION', value: 1);
}

class SmallDecrementAction extends Action<int> {
  SmallDecrementAction():super(type: 'SMALL_DECREMENT_ACTION', value: 1);
}

class BigIncrementAction extends Action<int> {
  BigIncrementAction():super(type: 'BIG_INCREMENT_ACTION', value: 100);
}

class BigDecrementAction extends Action<int> {
  BigDecrementAction():super(type: 'BIG_DECREMENT_ACTION', value: 100);
}

/////////////////////////////// STORE 1 "Counter" ///////////////////////////////

/// The application store.
///
/// It takes in a reducer and the initial state.
Store store = Store<CounterState>(stateReducer, initialState: CounterState.defaultState());

/// The store state class with the properties that make up the entire store.
class CounterState {
  final int smallCount;
  final int bigCount;
  final String name;

  CounterState({
    required this.smallCount,
    required this.bigCount,
    required this.name,
  });

  /// A default state constructor.
  ///
  /// This is optional and is just useful for creating the initial state or
  /// resetting the state to default (if you ever need to).
  CounterState.defaultState({this.smallCount = 1, this.bigCount = 100, this.name = 'Counter'});

  /// Used for syntactically simple updates within the reducer.
  ///
  /// Because Redux is pure and does not allow direct state mutations, a constructor
  /// that defaults to setting properties to the old state allows for DRYer code
  /// in the reducers.
  CounterState.updateState(CounterState oldState, {int? smallCount, int? bigCount, String? name})
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

/// The reducer used to update the store.
///
/// Ultimately the reducer needs to return a new state object. This can be done
/// with a simple if / switch that returns the object explicitly,
/// [combineReducers], or as done below. See the multiple_stores example to see
/// the implementation of the other two options.
int? smallCountReducer(CounterState? oldState, dynamic action) {
  if (action is SmallDecrementAction) {
    return oldState!.smallCount - action.value;
  } else if (action is SmallIncrementAction) {
    return oldState!.smallCount + action.value;
  } else {
    return oldState!.smallCount;
  }
}

int? bigCountReducer(CounterState? oldState, dynamic action) {
  if (action is BigDecrementAction) {
    return oldState!.bigCount - action.value;
  } else if (action is BigIncrementAction) {
    return oldState!.bigCount + action.value;
  } else {
    return oldState!.bigCount;
  }
}

CounterState stateReducer(CounterState state, action) => CounterState(
    bigCount: bigCountReducer(state, action) ?? state.bigCount,
    smallCount: smallCountReducer(state, action) ?? state.smallCount,
    name: state.name,
);
