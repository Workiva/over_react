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
  group('useStore hook', () {
    test('subscribes to the store and redraws when it updates', () async {
      final counterStore = Store(counterStateReducer, initialState: CounterState());
      final jacket = mount(
        (ReduxProvider()..store = counterStore)(
          CounterFn()(),
        ), attachedToDocument: true);

      expectStoreCountValue(jacket, 0);
      await clickIncrementButton(jacket);
      expectStoreCountValue(jacket, 1);
    });

    test('subscribes to custom context when createStoreHook is used and redraws when it updates', () async {
      final counterStore = Store(counterStateReducer, initialState: CounterState());
      final bigCounterStore = Store(bigCounterStateReducer, initialState: BigCounterState(bigCount: 9));
      final jacket = mount(
          (ReduxProvider()..store = counterStore)(
            (ReduxProvider()
              ..store = bigCounterStore
              ..context = bigCounterContext
            )(
              CustomContextCounterFn()(),
            ),
          ), attachedToDocument: true);

      expectStoreBigCountValue(jacket, 9);
      await clickBigIncrementButton(jacket);
      expectStoreBigCountValue(jacket, 109);

      expectCountValue(jacket, 0);
      await clickIncrementButton(jacket);
      expectCountValue(jacket, 1);
    });
  });
}
