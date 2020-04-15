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
