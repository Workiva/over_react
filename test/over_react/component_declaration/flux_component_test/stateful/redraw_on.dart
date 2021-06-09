// @dart=2.7
// ^ Do not remove until migrated to null safety. More info at https://wiki.atl.workiva.net/pages/viewpage.action?pageId=189370832
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
part of over_react.component_declaration.flux_component_test;

@Factory()
// ignore: undefined_identifier, invalid_assignment
UiFactory<TestStatefulRedrawOnProps> TestStatefulRedrawOn = _$TestStatefulRedrawOn;

@Props()
class _$TestStatefulRedrawOnProps extends FluxUiProps<TestActions, TestStores> implements TestRedrawOnProps {}

@State()
class _$TestStatefulRedrawOnState extends UiState {}

@Component()
class TestStatefulRedrawOnComponent extends FluxUiStatefulComponent<TestStatefulRedrawOnProps, TestStatefulRedrawOnState> {
  int numberOfRedraws = 0;

  @override
  render() => Dom.div()();

  @override
  redrawOn() => [props.store.store1, props.store.store2];

  @override
  void setState(_, [Function() callback]) {
    numberOfRedraws++;
    if (callback != null) callback();
  }
}

