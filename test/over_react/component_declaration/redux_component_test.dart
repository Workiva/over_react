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

library over_react.component_declaration.redux_component_test;

import 'dart:async';

import 'package:test/test.dart';
import 'package:built_redux/built_redux.dart';
import 'package:over_react/over_react.dart';

import '../../test_util/test_util.dart';

import 'redux_component_test/test_reducer.dart';

part 'redux_component_test/default.dart';
part 'redux_component_test/connect.dart';
part 'redux_component_test/pure.dart';

part 'redux_component_test.over_react.g.dart';

void main() {
  ReducerBuilder<BaseState, BaseStateBuilder> baseReducerBuilder;
  BaseState baseState;
  BaseActions baseActions;

  setUp(() {
    baseReducerBuilder = (ReducerBuilder<BaseState, BaseStateBuilder>()
      ..add(BaseActionsNames.trigger1, increment1)
      ..add(BaseActionsNames.trigger2, increment2)
    );
    baseState = BaseState();
    baseActions = BaseActions();
  });

  tearDown(() {
    baseReducerBuilder = null;
    baseState = null;
    baseActions = null;
  });

  group('ReduxUiProps', () {
    test('exposes a store getter', () {
      var props = TestDefault();
      var baseStore = Store<BaseState, BaseStateBuilder, BaseActions>(
        baseReducerBuilder.build(),
        baseState,
        baseActions,
      );

      props.store = baseStore;

      expect(props.store, equals(baseStore));
      expect(props.actions, equals(baseActions));
      expect(props, containsPair('TestDefaultProps.store', baseStore),
          reason: 'should have a `store` getter with the a properly-namespaced prop key');
    });
  });

  group('ReduxUiComponent', () {
    test('subscribes to a single store by default', () async {
      var store = Store<BaseState, BaseStateBuilder, BaseActions>(
        baseReducerBuilder.build(),
        baseState,
        baseActions,
      );
      var renderedInstance = render(TestDefault()..store = store);
      TestDefaultComponent component = getDartComponent(renderedInstance);

      store.actions.trigger1();
      await Future.delayed(Duration.zero);

      expect(component.numberOfRedraws, 1);

      unmount(renderedInstance);

      store.actions.trigger1();
      await Future.delayed(Duration.zero);

      expect(component.numberOfRedraws, 1,
          reason: 'component should no longer be listening after unmount');
    });

    test('only the state changes subscribed to in connect', () async {
      var stores = Store<BaseState, BaseStateBuilder, BaseActions>(
        baseReducerBuilder.build(),
        baseState,
        baseActions,
      );
      var renderedInstance = render(TestConnect()..store = stores);
      TestConnectComponent component = getDartComponent(renderedInstance);

      stores.actions.trigger1();
      await Future.delayed(Duration.zero);
      expect(component.numberOfRedraws, 1);

      stores.actions.trigger2();
      await Future.delayed(Duration.zero);
      expect(component.numberOfRedraws, 1);
    });

    group('properly redraws when isPure is true', () {
      test('when an action is triggered', () async {
        var store = Store<BaseState, BaseStateBuilder, BaseActions>(
          baseReducerBuilder.build(),
          baseState,
          baseActions,
        );
        var jacket = mount<TestPureComponent>((TestPure()..store = store)());
        TestPureComponent component = jacket.getDartInstance();

        store.actions.trigger1();
        await Future.delayed(Duration.zero);
        expect(component.numberOfRedraws, 1);
      });

      test('by not redrawing when other props change', () async {
        var store = Store<BaseState, BaseStateBuilder, BaseActions>(
          baseReducerBuilder.build(),
          baseState,
          baseActions,
        );
        var jacket = mount<TestPureComponent>((TestPure()..store = store)());
        TestPureComponent component = jacket.getDartInstance();

        expect(component.numberOfRedraws, 0);

        jacket.rerender((TestPure()
          ..store = store
          ..id = 'new id'
        )());

        expect(component.numberOfRedraws, 0);
      });

      test('by redrawing when store changes', () async {
        var store = Store<BaseState, BaseStateBuilder, BaseActions>(
          baseReducerBuilder.build(),
          baseState,
          baseActions,
        );
        var updatedStore = Store<BaseState, BaseStateBuilder, BaseActions>(
          baseReducerBuilder.build(),
          BaseState(),
          BaseActions(),
        );
        var jacket = mount<TestPureComponent>((TestPure()..store = store)());
        TestPureComponent component = jacket.getDartInstance();

        expect(component.numberOfRedraws, 0);

        jacket.rerender((TestPure()..store = updatedStore)());

        expect(component.numberOfRedraws, 1);
      });

      test('when calling redraw', () {
        var store = Store<BaseState, BaseStateBuilder, BaseActions>(
          baseReducerBuilder.build(),
          baseState,
          baseActions,
        );
        var jacket = mount<TestPureComponent>((TestPure()..store = store)());
        TestPureComponent component = jacket.getDartInstance();

        expect(component.numberOfRedraws, 0);

        component.redraw();

        expect(component.numberOfRedraws, 1);
      });
    });

    test('updates subscriptions when new props are passed', () async {
      var store = Store<BaseState, BaseStateBuilder, BaseActions>(
        baseReducerBuilder.build(),
        baseState,
        baseActions,
      );
      var updatedStore = Store<BaseState, BaseStateBuilder, BaseActions>(
        baseReducerBuilder.build(),
        BaseState(),
        BaseActions(),
      );
      var jacket = mount<TestDefaultComponent>((TestDefault()..store = store)());
      TestDefaultComponent component = jacket.getDartInstance();

      store.actions.trigger1();
      await Future.delayed(Duration.zero);
      expect(component.numberOfRedraws, 1);

      jacket.rerender((TestDefault()..store = updatedStore)());

      expect(component.numberOfRedraws, 2);

      updatedStore.actions.trigger1();
      await Future.delayed(Duration.zero);
      expect(component.numberOfRedraws, 3);
    });
  });
}

increment1(BaseState state, Action<String> action, BaseStateBuilder builder) => builder.count1 = state.count1 + 1;
increment2(BaseState state, Action<String> action, BaseStateBuilder builder) => builder.count2 = state.count2 + 1;
