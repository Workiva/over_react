// Copyright 2019 Workiva Inc.
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

part of prop_tyepdef_test_fixtures;

UiFactory<TestCustomRendererFromAbstractComponentProps> TestCustomRendererFromAbstractComponent =
    _$TestCustomRendererFromAbstractComponent;

mixin TestCustomRendererFromAbstractComponentPropsMixin on UiProps {
  String someInitialStateKeyValue;
}

// FIXME:
//   1. Ensure that all mixins used by TestAbstractCustomRendererComponentProps are also mixed into this class.
//   2. Fix any analyzer warnings on this class about missing mixins.
class TestCustomRendererFromAbstractComponentProps = UiProps
    with
        TestAbstractCustomRendererComponentProps,
        TestCustomRendererFromAbstractComponentPropsMixin;

// FIXME:
//   1. Ensure that all mixins used by TestAbstractCustomRendererComponentState are also mixed into this class.
//   2. Fix any analyzer warnings on this class about missing mixins.
class TestCustomRendererFromAbstractComponentState = UiState
    with TestAbstractCustomRendererComponentState;

class TestCustomRendererFromAbstractComponentComponent
    extends TestAbstractCustomRendererComponentComponent<
        TestCustomRendererFromAbstractComponentProps,
        TestCustomRendererFromAbstractComponentState> {
  @override
  get initialState => (newState()..someStateKey = props.someInitialStateKeyValue);

  @override
  render() {
    return Dom.div()(
      props.customRenderer(props, state, this),
      props.parameterizedCustomRenderer(props, state, this),
    );
  }
}
