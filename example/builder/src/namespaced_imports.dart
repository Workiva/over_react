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
import 'props_mixin.dart' as pm;
import 'state_mixin.dart' as sm;

part 'namespaced_imports.over_react.g.dart';

UiFactory<BasicProps> Basic = castUiFactory(_$Basic); // ignore: undefined_identifier

mixin BasicPropsMixin on UiProps, pm.ExamplePropsMixin {
  String basicProp;
  String basic1;
  String basic2;
  String basic3;
  String basic4;
  String basic5;
}

mixin BasicStateMixin on UiState, sm.ExampleStateMixin {
  String basicState;
}

class BasicProps = UiProps with pm.ExamplePropsMixin, BasicPropsMixin;
class BasicState = UiState with sm.ExampleStateMixin, BasicStateMixin;

class BasicComponent extends UiStatefulComponent2<BasicProps, BasicState> {
  @override
  get defaultProps => newProps()..id = 'basic component'
      ..basicProp = 'defaultBasicProps'
      ..propMixin1 = '<props mixin>';

  @override
  get initialState => newState()..basicState = '<basic state>'
      ..stateMixin1 = '<state mixin>';

  @override
  render() {
    return Dom.div()(
        Dom.div()('props for mixin in basic.dart: ${props.propMixin1}'),
        Dom.div()('default prop testing: ${props.basicProp}'),
        Dom.div()('default state testing:  ${state.basicState}'),
        Dom.div()('state mixin in basic.dart: ${state.stateMixin1}'),
    );
  }
}
