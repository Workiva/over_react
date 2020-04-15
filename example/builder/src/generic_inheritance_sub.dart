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
import 'generic_inheritance_super.dart';

part 'generic_inheritance_sub.over_react.g.dart';

UiFactory<GenericSubProps> GenericSub = _$GenericSub; // ignore: undefined_identifier

mixin GenericSubPropsMixin on UiProps, GenericSuperPropsMixin {
  String subProp;
}

mixin GenericSubStateMixin on UiState, GenericSuperStateMixin {
  String subState;
}

class GenericSubProps = UiProps with GenericSuperPropsMixin, GenericSubPropsMixin;

class GenericSubState = UiState with GenericSuperStateMixin, GenericSubStateMixin;

class GenericSubComponent extends GenericSuperComponent<GenericSubPropsMixin, GenericSubStateMixin> {
  @override
  get defaultProps => newProps()..id = 'generic_sub';

  @override
  get initialState => newState()
    ..subState = '<generic sub state>'
    ..superState = '<generic super state>';

  @override
  render() {
    return Dom.div()('GenericSubProps', {
      'props.subProp': props.subProp,
      'props.superProps': props.superProp,
    }.toString(),
        'GenericSubState', {
      'props.subState': state.subState,
      'state.superState': state.superState,
    }.toString()
    );
  }
}
