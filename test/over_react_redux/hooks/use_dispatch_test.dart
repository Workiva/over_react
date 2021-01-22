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

import 'package:over_react/over_react_redux.dart';
import 'package:redux/redux.dart';
import 'package:test/test.dart';

import '../../test_util/test_util.dart';
import '../fixtures/counter_fn.dart';
import '../fixtures/store.dart';

import 'utils.dart';

main() {
  group('useDispatch hook', () {
    TestJacket jacket;
    Store<CounterState> counterStore;
    Store<BigCounterState> bigCounterStore;

    setUp(() {
      jacket = null;

      counterStore = Store(counterStateReducer, initialState: CounterState());
      bigCounterStore = Store(bigCounterStateReducer, initialState: BigCounterState(bigCount: 9));
    });

    test('dispatches an action', () async {
      jacket = mount(
        (ReduxProvider()..store = counterStore)(
          CounterFn()(),
        ), attachedToDocument: true);

      expectCountValue(jacket, 0);
      await clickIncrementButton(jacket);
      expectCountValue(jacket, 1);
    });

    test('dispatches an action within a custom context when createDispatchHook is used', () async {
      jacket = mount(
          (ReduxProvider()..store = counterStore)(
            (ReduxProvider()
              ..store = bigCounterStore
              ..context = bigCounterContext
            )(
              CustomContextCounterFn()(),
            ),
          ), attachedToDocument: true);

      expectBigCountValue(jacket, 9);
      await clickBigIncrementButton(jacket);
      expectBigCountValue(jacket, 109);
    });
  });
}
