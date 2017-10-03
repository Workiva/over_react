library over_react.component_declaration.redux_component.reducer;

import 'package:built_redux/built_redux.dart';
import 'package:built_value/built_value.dart';

part 'test_reducer.g.dart';

abstract class BaseActions extends ReduxActions {
  factory BaseActions() => new _$BaseActions();
  BaseActions._();

  ActionDispatcher<String> trigger;
}

abstract class BaseState implements Built<BaseState, BaseStateBuilder> {
  factory BaseState() => new _$BaseState._(count: 0);
  BaseState._();

  int get count;
}

abstract class MultipleStatesActions extends ReduxActions {
  factory MultipleStatesActions() => new _$MultipleStatesActions();
  MultipleStatesActions._();
}

abstract class MultipleStates implements Built<MultipleStates, MultipleStatesBuilder> {
  factory MultipleStates() => new _$MultipleStates._(
    store1: new Store<BaseState, BaseStateBuilder, BaseActions>(
      (new ReducerBuilder<BaseState, BaseStateBuilder>()
        ..add(BaseActionsNames.trigger, increment)
      ).build(),
      new BaseState(),
      new BaseActions(),
    ),
    store2: new Store<BaseState, BaseStateBuilder, BaseActions>(
      (new ReducerBuilder<BaseState, BaseStateBuilder>()
        ..add(BaseActionsNames.trigger, increment)
      ).build(),
      new BaseState(),
      new BaseActions(),
    ),
    store3: new Store<BaseState, BaseStateBuilder, BaseActions>(
      (new ReducerBuilder<BaseState, BaseStateBuilder>()
        ..add(BaseActionsNames.trigger, increment)
      ).build(),
      new BaseState(),
      new BaseActions(),
    )
  );
  MultipleStates._();

  Store<BaseState, BaseStateBuilder, BaseActions> get store1;
  Store<BaseState, BaseStateBuilder, BaseActions> get store2;
  Store<BaseState, BaseStateBuilder, BaseActions> get store3;
}

increment(BaseState state, Action<String> action, BaseStateBuilder builder) => builder.count = state.count + 1;
