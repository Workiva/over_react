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

import 'package:over_react/over_react.dart';

// ignore_for_file: uri_has_not_been_generated
part 'use_reducer_example.over_react.g.dart';

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

mixin UseReducerExampleProps on UiProps {
  int initialCount;
}

UiFactory<UseReducerExampleProps> UseReducerExample = uiFunction(
  (props) {
    final state = useReducerLazy<Map, Map, int>(
        reducer, props.initialCount, initializeCount);

    return Fragment()(
      state.state['count'],
      (Dom.button()
        ..onClick = (_) => state.dispatch({'type': 'increment'})
      )('+'),
      (Dom.button()
        ..onClick = (_) => state.dispatch({'type': 'decrement'})
      )('-'),
      (Dom.button()
        ..onClick = (_) => state.dispatch({
              'type': 'reset',
              'payload': props.initialCount,
            })
      )('reset'),
    );
  },
  $UseReducerExampleConfig, // ignore: undefined_identifier
);
