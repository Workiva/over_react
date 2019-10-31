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

// ignore_for_file: avoid_as
part of prop_tyepdef_test_fixtures;

@Factory()
UiFactory<TestConsumingCustomRendererComponentProps> TestConsumingCustomRendererComponent =
    _$TestConsumingCustomRendererComponent;

@Props()
class _$TestConsumingCustomRendererComponentProps extends UiProps {
  String propKeyValueToTest;
  String stateKeyValueToTest;
}

@Component2()
class TestConsumingCustomRendererComponentComponent extends UiComponent2<TestConsumingCustomRendererComponentProps> {
  @override
  render() {
    return (TestCustomRendererComponent()
      ..somePropKey = props.propKeyValueToTest
      ..someInitialStateKeyValue = props.stateKeyValueToTest
      ..customRenderer = (props, state, component) {
        return (Dom.div()..addTestId('customRendererContainer'))(
          'props.somePropKey: ${(props as TestCustomRendererComponentProps).somePropKey} \n'
          'props.someStateKey: ${(state as TestCustomRendererComponentState).someStateKey}'
        );
      }
      ..parameterizedCustomRenderer = (props, state, component) {
        return (Dom.div()..addTestId('parameterizedCustomRendererContainer'))(
          'props.somePropKey: ${props.somePropKey} \n'
          'props.someStateKey: ${state.someStateKey}'
        );
      }
    )();
  }
}
