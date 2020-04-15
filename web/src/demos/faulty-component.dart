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

import '../../component1/src/demo_components.dart';

part 'faulty-component.over_react.g.dart';

// ignore: undefined_identifier
UiFactory<FaultyProps> Faulty = _$Faulty;

mixin FaultyProps on UiProps {}

mixin FaultyState on UiState {
  bool hasErrored;
}

class FaultyComponent extends UiStatefulComponent2<FaultyProps, FaultyState> {
  @override
  get initialState => (newState()..hasErrored = false);

  @override
  getSnapshotBeforeUpdate(Map prevProps, Map prevState) {
    final tPrevState = typedStateFactory(prevState);
    if (state.hasErrored && !tPrevState.hasErrored) {
      throw Error();
    }
  }

  @override
  render() {
    return (Dom.div()..className = 'btn-toolbar')(
      (Button()..onClick = (_) {
        setState(newState()..hasErrored = true);
      })('Click me to throw an error'),
    );
  }
}
