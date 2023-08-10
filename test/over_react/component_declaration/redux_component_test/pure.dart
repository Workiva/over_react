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

// ignore_for_file: deprecated_member_use_from_same_package
part of over_react.component_declaration.redux_component_test;

@Factory()
// ignore: undefined_identifier, invalid_assignment
UiFactory<TestPureProps> TestPure = _$TestPure;

@Props()
class _$TestPureProps extends BuiltReduxUiProps<BaseState, BaseStateBuilder, BaseActions> {}

@Component()
class TestPureComponent extends BuiltReduxUiComponent<BaseState, BaseStateBuilder, BaseActions, TestPureProps, BaseState> {
  int numberOfRedraws = 0;

  @override
  void componentDidUpdate(Map prevProps, Map prevState) {
    numberOfRedraws++;
  }

  @override
  bool get isPure => true;

  @override
  BaseState connect(BaseState state) => state;

  @override
  render() => Dom.div()();
}
