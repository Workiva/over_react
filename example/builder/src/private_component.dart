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

part 'private_component.over_react.g.dart';

UiFactory<_PrivateProps> _Private = castUiFactory(_$_Private); // ignore: undefined_identifier, unused_element

mixin _PrivateProps on UiProps {
  bool? prop1;
}

mixin _PrivateState on UiState {
  bool? state1;
}

// ignore: unused_element
class _PrivateComponent extends UiStatefulComponent2<_PrivateProps, _PrivateState> {
  @override
  get defaultProps => newProps()..prop1 = true;

  @override
  get initialState => newState()..state1 = true;

  @override
  render() {
    return Dom.div()('PrivateComponent', {
      'props.prop1': props.prop1,
      'props.state1': state.state1,
    }.toString());
  }
}
