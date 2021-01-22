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
import '../fixtures/store.dart';

import 'utils.dart';

// ignore_for_file: uri_has_not_been_generated
part 'use_store_test.over_react.g.dart';

main() {
  group('useStore hook', () {
    void expectStoreCountValue(TestJacket jacket, int expectedValue) {
      expect(queryByTestId(jacket.mountNode, 'count-from-store').text, 'Store Count: $expectedValue');
    }

    void expectStoreBigCountValue(TestJacket jacket, int expectedValue) {
      expect(queryByTestId(jacket.mountNode, 'big-count-from-store').text, 'Big Store Count: $expectedValue');
    }

    test('provides access to the correct store', () {
      final counterStore = Store(counterStateReducer, initialState: CounterState(count: 12));
      final jacket = mount(
        (ReduxProvider()..store = counterStore)(
          UseStoreCounterFn()(),
        ), attachedToDocument: true);

      expectStoreCountValue(jacket, 12);
    });

    test('provides access to the correct store when custom context is specified via createStoreHook', () async {
      final counterStore = Store(counterStateReducer, initialState: CounterState());
      final bigCounterStore = Store(bigCounterStateReducer, initialState: BigCounterState(bigCount: 9));
      final jacket = mount(
          (ReduxProvider()..store = counterStore)(
            (ReduxProvider()
              ..store = bigCounterStore
              ..context = bigCounterContext
            )(
              CustomContextUseStoreCounterFn()(),
            ),
          ), attachedToDocument: true);

      expectStoreBigCountValue(jacket, 9);
    });
  });
}

mixin UseStoreCounterFnProps on UiProps {}

UiFactory<UseStoreCounterFnProps> UseStoreCounterFn = uiFunction(
  (props) {
    final store = useStore<CounterState>();

    return (Dom.div()
      ..addUnconsumedDomProps(props, const [])
      ..addTestId('use-store-counter-component')
    )(
      (Dom.div()..addTestId('count-from-store'))('Store Count: ${store.state.count}'),
      props.children,
    );
  },
  $UseStoreCounterFnConfig, // ignore: undefined_identifier
);

final useBigCountStore = createStoreHook<BigCounterState>(bigCounterContext);

mixin CustomContextUseStoreCounterFnProps on UiProps {}

UiFactory<CustomContextUseStoreCounterFnProps> CustomContextUseStoreCounterFn = uiFunction(
  (props) {
    final bigStore = useBigCountStore();

    return (Dom.div()
      ..addUnconsumedDomProps(props, const [])
      ..addTestId('use-big-store-counter-component')
    )(
      (Dom.div()..addTestId('big-count-from-store'))('Big Store Count: ${bigStore.state.bigCount}'),
      props.children,
    );
  },
  $CustomContextUseStoreCounterFnConfig, // ignore: undefined_identifier
);
