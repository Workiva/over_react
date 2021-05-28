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

import 'package:over_react/over_react.dart';

import '../context.dart';

part 'my_provider_component.over_react.g.dart';

UiFactory<MyProviderProps> MyProvider = castUiFactory(_$MyProvider); // ignore: undefined_identifier

mixin MyProviderProps on UiProps {}

mixin MyProviderState on UiState {
  String? latestValue;
}

class MyProviderComponent extends UiStatefulComponent2<MyProviderProps, MyProviderState> {
  @override
  render() {
    return Dom.div()(
      (Dom.button()..onClick = (_) { setState((newState()..latestValue = 'Hi Sydney')); })('Sydney'),
      (Dom.button()..onClick = (_) { setState((newState()..latestValue = 'Hi Keal')); })('Keal'),
      (someContext.Provider()..value = state.latestValue)(
        props.children
      )
    );
  }
}
