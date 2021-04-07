// Copyright 2021 Workiva Inc.
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
import 'package:over_react/over_react_redux.dart';
import 'package:redux/redux.dart';

import 'over_react_redux/counter_fn.dart';
import 'over_react_redux/store.dart';

// ignore_for_file: uri_has_not_been_generated
part 'use_selector_example.over_react.g.dart';

final counterStore = Store(counterStateReducer, initialState: CounterState());
final bigCounterStore = Store(bigCounterStateReducer, initialState: BigCounterState());

mixin UseSelectorExampleProps on UiProps {}

UiFactory<UseSelectorExampleProps> UseSelectorExample = uiFunction(
  (props) {
    return (ReduxProvider()..store = counterStore)(
      Dom.h5()('Root Provider:'),
      ModelCounterFn()(),
      (ReduxProvider()
        ..store = bigCounterStore
        ..context = bigCounterContext
      )(
        Dom.h5()('Nested Provider:'),
        CustomContextCounterFn()(props.children),
      ),
    );
  },
  _$UseSelectorExampleConfig, // ignore: undefined_identifier
);
