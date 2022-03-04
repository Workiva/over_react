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

part 'generic_inheritance_super.over_react.g.dart';

UiFactory<GenericSuperProps> GenericSuper = castUiFactory(_$GenericSuper); // ignore: undefined_identifier

class GenericSuperProps = UiProps with GenericSuperPropsMixin;

mixin GenericSuperPropsMixin on UiProps {
  String otherSuperProp;
  String superProp;
  String superProp1;
}

mixin GenericSuperStateMixin on UiState {
  String superState;
}

class GenericSuperComponent<T extends GenericSuperPropsMixin, V extends GenericSuperStateMixin> extends UiStatefulComponent2<T, V> {
  @override
  get defaultProps => newProps()..id = 'generic_super';

  @override
  get initialState => newState()..superState = '<generic super state>';

  @override
  render() {
    return Dom.div()('GenericSuperProps', {
      'props.superProp': props.superProp,
    }.toString(),
      'GenericSuperState', {
      'state.superState': state.superState,
    }.toString()
    );
  }
}
