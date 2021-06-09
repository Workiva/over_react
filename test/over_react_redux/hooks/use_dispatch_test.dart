// @dart=2.7
// ^ Do not remove until migrated to null safety. More info at https://wiki.atl.workiva.net/pages/viewpage.action?pageId=189370832
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
import 'package:test/test.dart';

import '../../test_util/test_util.dart';
import '../fixtures/counter_fn.dart' show CounterFn, CustomContextCounterFn;
import '../fixtures/redux_actions.dart';
import '../fixtures/store.dart';

import 'utils.dart';

// ignore_for_file: uri_has_not_been_generated
part 'use_dispatch_test.over_react.g.dart';

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
          UseDispatchCounterFn()(),
        ), attachedToDocument: true);

      expectCountValue(jacket, 0);
      final incrementButton = queryByTestId(jacket.mountNode, 'button-increment');
      incrementButton.click();
      await pumpEventQueue();
      expectCountValue(jacket, 1);
    });

    test('dispatches an action within a custom context when createDispatchHook is used', () async {
      jacket = mount(
          (ReduxProvider()..store = counterStore)(
            (ReduxProvider()
              ..store = bigCounterStore
              ..context = bigCounterContext
            )(
              CustomContextUseDispatchCounterFn()(),
            ),
          ), attachedToDocument: true);

      expectBigCountValue(jacket, 9);
      final incrementButton = queryByTestId(jacket.mountNode, 'button-big-increment');
      incrementButton.click();
      await pumpEventQueue();
      expectBigCountValue(jacket, 109);
    });
  });
}

mixin UseDispatchCounterFnProps on UiProps {}

UiFactory<UseDispatchCounterFnProps> UseDispatchCounterFn = uiFunction(
  (props) {
    final dispatch = useDispatch();

    return (CounterFn()..addTestId('use-dispatch-counter-component'))(
      Dom.div()(
        'Mutate Count:',
        (Dom.button()
          ..addTestId('button-increment')
          ..onClick = (_) {
            dispatch(IncrementAction());
          }
        )('+'),
        (Dom.button()
          ..addTestId('button-decrement')
          ..onClick = (_) {
            dispatch(DecrementAction());
          }
        )('-'),
      ),
    );
  },
  _$UseDispatchCounterFnConfig, // ignore: undefined_identifier
);

final useBigCountDispatch = createDispatchHook(bigCounterContext);

mixin CustomContextUseDispatchCounterFnProps on UiProps {}

UiFactory<CustomContextUseDispatchCounterFnProps> CustomContextUseDispatchCounterFn = uiFunction(
  (props) {
    final bigDispatch = useBigCountDispatch();

    return (CustomContextCounterFn()
      ..addTestId('use-big-store-counter-component')
    )(
      Dom.div()(
        'Mutate Big Count:',
        (Dom.button()
          ..addTestId('button-big-increment')
          ..onClick = (_) {
            bigDispatch(IncrementAction());
          }
        )('+'),
        (Dom.button()
          ..addTestId('button-big-decrement')
          ..onClick = (_) {
            bigDispatch(DecrementAction());
          }
        )('-'),
      ),
    );
  },
  _$CustomContextUseDispatchCounterFnConfig, // ignore: undefined_identifier
);
