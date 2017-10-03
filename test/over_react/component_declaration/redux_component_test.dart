library over_react.component_declaration.redux_component_test;

import 'package:test/test.dart';
import 'package:built_redux/built_redux.dart';
import 'package:over_react/over_react.dart';

import '../../test_util/test_util.dart';

import 'redux_component_test/test_reducer.dart';

part 'redux_component_test/default.dart';
part 'redux_component_test/redraw_on.dart';

void main() {
  ReducerBuilder<BaseState, BaseStateBuilder> baseReducerBuilder;
  ReducerBuilder<MultipleStates, MultipleStatesBuilder> statesReducerBuilder;
  BaseState baseState;
  MultipleStates states;
  BaseActions baseActions;
  MultipleStatesActions multipleStatesActions;

  setUp(() {
    baseReducerBuilder = (new ReducerBuilder<BaseState, BaseStateBuilder>()
      ..add(BaseActionsNames.trigger, increment)
    );
    statesReducerBuilder = new ReducerBuilder<MultipleStates, MultipleStatesBuilder>();
    baseState = new BaseState();
    states = new MultipleStates();
    baseActions = new BaseActions();
    multipleStatesActions = new MultipleStatesActions();
  });

  tearDown(() {
    baseReducerBuilder = null;
    statesReducerBuilder = null;
    baseState = null;
    states = null;
    baseActions = null;
    multipleStatesActions = null;
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

      store.actions.trigger('asdfasdfadfsasfd');
      await store.stream.first;

      expect(component.numberOfRedraws, 1);

      unmount(renderedInstance);

      store.actions.trigger('');
      await store.stream.first;

      expect(component.numberOfRedraws, 1,
          reason: 'component should no longer be listening after unmount');
    });

    test('subscribes to any stores returned in redrawOn', () async {
      var stores = new Store<MultipleStates, MultipleStatesBuilder, MultipleStatesActions>(
        statesReducerBuilder.build(),
        states,
        multipleStatesActions
      );
      var renderedInstance = render(TestRedrawOn()..store = stores);
      TestRedrawOnComponent component = getDartComponent(renderedInstance);

      stores.state.store1.actions.trigger('');
      await stores.state.store1.stream.first;
      expect(component.numberOfRedraws, 1);

      stores.state.store2.actions.trigger('');
      await stores.state.store2.stream.first;
      expect(component.numberOfRedraws, 2);

      stores.state.store3.actions.trigger('');
      await stores.state.store3.stream.first;
      expect(component.numberOfRedraws, 2,
          reason: 'should not redraw since `store3` is absent from the component\'s `redrawOn`');
    });

    test('should not attempt subscription if store is a composite of stores', () async {
      var stores = new Store<MultipleStates, MultipleStatesBuilder, MultipleStatesActions>(
        statesReducerBuilder.build(),
        states,
        multipleStatesActions,
      );
      var renderedInstance = render(TestDefault()..store = stores);
      TestDefaultComponent component = getDartComponent(renderedInstance);

      stores.state.store1.actions.trigger('');
      await stores.state.store1.stream.first;
      expect(component.numberOfRedraws, 0);

      stores.state.store2.actions.trigger('');
      await stores.state.store2.stream.first;
      expect(component.numberOfRedraws, 0);
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
      var renderedInstance = render((TestDefault()..store = store)());
      TestDefaultComponent component = getDartComponent(renderedInstance);

      store.actions.trigger('');
      await store.stream.first;
      expect(component.numberOfRedraws, 1);

      component.props = TestDefault()..store = updatedStore;
      component.redraw();

      updatedStore.actions.trigger('');
      await updatedStore.stream.first;
      expect(component.numberOfRedraws, 2);
    });
  });
}

increment(BaseState state, Action<String> action, BaseStateBuilder builder) => builder.count = state.count + 1;
