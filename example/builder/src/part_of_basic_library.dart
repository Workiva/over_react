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

part of basic.library;

UiFactory<BasicPartOfLibProps> BasicPartOfLib = castUiFactory(_$BasicPartOfLib); // ignore: undefined_identifier

class BasicPartOfLibProps = UiProps with ExamplePropsMixin, BasicPartOfLibPropsMixin;
class BasicPartOfLibState = UiState with ExampleStateMixin, BasicPartOfLibStateMixin;

mixin BasicPartOfLibPropsMixin on UiProps, ExamplePropsMixin {
  String basicProp;
  String basic1;
  String basic2;
  String basic3;
  String basic4;
  String basic5;
}

mixin BasicPartOfLibStateMixin on UiState, ExampleStateMixin {
  String basicState;
}

class BasicPartOfLibComponent extends UiStatefulComponent2<BasicPartOfLibProps, BasicPartOfLibState> {
  @override
  get defaultProps => newProps()..id = 'BasicPartOfLib';

  @override
  get initialState => newState()..basicState = '<Basic state>'
      ..stateMixin1 = '<state mixin>';

  @override
  render() {
    return Dom.div()(
      'BasicPartOfLibComponentProps: ${props.basicProp}, ${props.propMixin1}',
      'BasicPartOfLibComponentState: ${state.basicState}, ${state.stateMixin1}',
      Dom.div()('propsMeta: ${propsMeta.keys}'),
      Dom.div()('propsMeta for just ExamplePropsMixinClass: ${propsMeta.forMixin(ExamplePropsMixin).keys}'),
    );
  }
}
