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

part 'abstract_inheritance.over_react.g.dart';

mixin SuperPropsMixin on UiProps {
  String? superProp;
}

mixin SuperStateMixin on UiState {
  String? superState;
}

abstract class SuperComponent<T extends SuperPropsMixin, V extends SuperStateMixin> extends UiStatefulComponent2<T, V> {
  @override
  get defaultProps => newProps()..id = 'super';

  @override
  render() {
    return Dom.div()('Super', {
      'props.superProp': props.superProp,
    }.toString());
  }
}

//---------------------------- Sub Component ----------------------------

UiFactory<SubProps> Sub = castUiFactory(_$Sub); // ignore: undefined_identifier

mixin SubPropsMixin on UiProps {
  String? subProp;
}

mixin SubStateMixin on UiState {
  String? subState;
}

class SubProps = UiProps with SuperPropsMixin, SubPropsMixin;
class SubState = UiState with SuperStateMixin, SubStateMixin;

class SubComponent extends SuperComponent<SubProps, SubState> {
  @override
  get defaultProps => newProps()..id = 'sub';

  @override
  get initialState {
    return newState()
      ..superState = '<the super state value>'
      ..subState = '<the sub state value>';
  }

  @override
  render() {
    return Dom.div()('SubProps:', {
      'props.subProp': props.subProp,
      'props.superProp': props.superProp,
    }.toString(),
      'SubState:', {
      'state.subState': state.subState,
      'state.superState': state.superState,
    }.toString()
    );
  }
}
