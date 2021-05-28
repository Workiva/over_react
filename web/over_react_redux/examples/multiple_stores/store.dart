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
import 'package:over_react/over_react.dart';

/////////////////////////////// SHARED ///////////////////////////////

/// An action class can be created to add typing to the actions passed into dispatch.
class Action {
  Action({this.type, this.value});

  final String? type;
  final dynamic value;
}

/// Actions to be passed into `dispatch`.
class IncrementAction extends Action {
  IncrementAction([value]):super(type: 'INCREMENT', value:value);
}

class DecrementAction extends Action {
  DecrementAction([value]):super(type: 'DECREMENT', value:value);
}

/// A reducer that returns a new state object.
///
/// Note that this is a single reducer that takes in all actions for any state
/// update. This differs from both the reducer below and the reducer in the simple
/// example.
CounterState smallCountReducer(CounterState oldState, dynamic action) {
  if (action is DecrementAction) {
    return CounterState.updateState(oldState, count: oldState.count! - 1);
  } else if (action is IncrementAction) {
    return CounterState.updateState(oldState, count: oldState.count! + 1);
  } else {
    return oldState;
  }
}

/////////////////////////////// STORE 1 "Counter" ///////////////////////////////

Store store1 = Store<CounterState>(smallCountReducer, initialState: CounterState.defaultState());

class CounterState {
  final int? count;
  final String? name;

  CounterState({
    this.count,
    this.name,
  });

  CounterState.defaultState({this.count = 1, this.name = 'Counter'});

  CounterState.updateState(CounterState oldState, {int? count, String? name})
      : this.count = count ?? oldState.count,
        this.name = name ?? oldState.name;
}

/////////////////////////////// STORE 2 "BigCounter" ///////////////////////////////

/// A new context that is used to differentiate the second store from the first.
final bigCounterContext = createContext();

/// The second store
Store store2 = Store<CounterState>(smallCountReducer, initialState: CounterState.defaultState());
