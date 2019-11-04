library over_react.component_declaration.redux_component.reducer;

import 'package:built_redux/built_redux.dart';
import 'package:built_value/built_value.dart';

part 'test_reducer.g.dart';

abstract class BaseActions extends ReduxActions {
  factory BaseActions() => _$BaseActions();
  BaseActions._();

  ActionDispatcher<Null> trigger1;
  ActionDispatcher<Null> trigger2;
}

abstract class BaseState implements Built<BaseState, BaseStateBuilder> {
  factory BaseState() => _$BaseState._(count1: 0, count2: 0);
  BaseState._();

  int get count1;
  int get count2;
}
