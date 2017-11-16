library over_react.component_declaration.redux_component_test;

import 'dart:async';

import 'package:test/test.dart';
import 'package:built_redux/built_redux.dart';
import 'package:over_react/over_react.dart';

import '../../test_util/test_util.dart';

import 'redux_component_test/test_reducer.dart';

part 'redux_component_test/default.dart';
part 'redux_component_test/connect.dart';

void main() {
  ReducerBuilder<BaseState, BaseStateBuilder> baseReducerBuilder;
  BaseState baseState;
  BaseActions baseActions;

  setUp(() {
    baseReducerBuilder = (new ReducerBuilder<BaseState, BaseStateBuilder>()
      ..add(BaseActionsNames.trigger1, increment1)
      ..add(BaseActionsNames.trigger2, increment2)
    );
    baseState = new BaseState();
    baseActions = new BaseActions();
  });

  tearDown(() {
    baseReducerBuilder = null;
    baseState = null;
    baseActions = null;
  });

  group('ReduxUiProps', () {
    test('exposes a store getter', () {
      var props = TestDefault();
      var baseStore = new Store<BaseState, BaseStateBuilder, BaseActions>(
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
      var store = new Store<BaseState, BaseStateBuilder, BaseActions>(
        baseReducerBuilder.build(),
        baseState,
        baseActions,
      );
      var renderedInstance = render(TestDefault()..store = store);
      TestDefaultComponent component = getDartComponent(renderedInstance);

      store.actions.trigger1();
      await new Future.delayed(Duration.ZERO);

      expect(component.numberOfRedraws, 1);

      unmount(renderedInstance);

      store.actions.trigger1();
      await new Future.delayed(Duration.ZERO);

      expect(component.numberOfRedraws, 1,
          reason: 'component should no longer be listening after unmount');
    });

    test('only the state changes subscribed to in connect', () async {
      var stores = new Store<BaseState, BaseStateBuilder, BaseActions>(
        baseReducerBuilder.build(),
        baseState,
        baseActions,
      );
      var renderedInstance = render(TestConnect()..store = stores);
      TestConnectComponent component = getDartComponent(renderedInstance);

      stores.actions.trigger1();
      await new Future.delayed(Duration.ZERO);
      expect(component.numberOfRedraws, 1);

      stores.actions.trigger2();
      await new Future.delayed(Duration.ZERO);
      expect(component.numberOfRedraws, 1);
    });

    test('updates subscriptions when new props are passed', () async {
      var store = new Store<BaseState, BaseStateBuilder, BaseActions>(
        baseReducerBuilder.build(),
        baseState,
        baseActions,
      );
      var updatedStore = new Store<BaseState, BaseStateBuilder, BaseActions>(
        baseReducerBuilder.build(),
        new BaseState(),
        new BaseActions(),
      );
      var jacket = mount<TestDefaultComponent>((TestDefault()..store = store)());
      TestDefaultComponent component = jacket.getDartInstance();

      store.actions.trigger1();
      await new Future.delayed(Duration.ZERO);
      expect(component.numberOfRedraws, 1);

      jacket.rerender((TestDefault()..store = updatedStore)());

      updatedStore.actions.trigger1();
      await new Future.delayed(Duration.ZERO);
      expect(component.numberOfRedraws, 2);
    });
  });
}

increment1(BaseState state, Action<String> action, BaseStateBuilder builder) => builder.count1 = state.count1 + 1;
increment2(BaseState state, Action<String> action, BaseStateBuilder builder) => builder.count2 = state.count2 + 1;
