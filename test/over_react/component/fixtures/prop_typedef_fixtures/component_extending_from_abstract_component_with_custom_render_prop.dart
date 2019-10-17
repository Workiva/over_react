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
UiFactory<TestCustomRendererFromAbstractComponentProps> TestCustomRendererFromAbstractComponent =
    _$TestCustomRendererFromAbstractComponent;

@Props()
class _$TestCustomRendererFromAbstractComponentProps extends TestAbstractCustomRendererComponentProps {
  String someInitialStateKeyValue;
}

@State()
class _$TestCustomRendererFromAbstractComponentState extends TestAbstractCustomRendererComponentState {}

@Component()
class TestCustomRendererFromAbstractComponentComponent
    extends TestAbstractCustomRendererComponentComponent<TestCustomRendererFromAbstractComponentProps,
                                                         TestCustomRendererFromAbstractComponentState> {
  @override
  Map getInitialState() => (newState()..someStateKey = props.someInitialStateKeyValue);

  @override
  render() {
    return Dom.div()(
      props.customRenderer(props, state, this),
      props.parameterizedCustomRenderer(props, state, this),
    );
  }
}
