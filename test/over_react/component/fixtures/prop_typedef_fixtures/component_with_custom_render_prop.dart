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

@Factory()
UiFactory<TestCustomRendererComponentProps> TestCustomRendererComponent =
    _$TestCustomRendererComponent;

@Props()
class _$TestCustomRendererComponentProps extends UiProps {
  CustomRenderFunction customRenderer;
  CustomRenderFunction<
      TestCustomRendererComponentProps,
      TestCustomRendererComponentState,
      TestCustomRendererComponentComponent> parameterizedCustomRenderer;
  String somePropKey;
  String someInitialStateKeyValue;
}

@State()
class _$TestCustomRendererComponentState extends UiState {
  String someStateKey;
}

@Component()
class TestCustomRendererComponentComponent extends UiStatefulComponent<
    TestCustomRendererComponentProps, TestCustomRendererComponentState> {
  @override
  Map getInitialState() =>
      (newState()..someStateKey = props.someInitialStateKeyValue);

  @override
  render() {
    return Dom.div()(
      props.customRenderer(props, state, this),
      props.parameterizedCustomRenderer(props, state, this),
    );
  }
}
