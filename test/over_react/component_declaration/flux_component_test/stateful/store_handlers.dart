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
UiFactory<TestStatefulStoreHandlersProps> TestStatefulStoreHandlers = _$TestStatefulStoreHandlers;

@Props()
class _$TestStatefulStoreHandlersProps extends FluxUiProps<TestActions, TestStore> implements TestStoreHandlersProps {}

@State()
class _$TestStatefulStoreHandlersState extends UiState {}

@Component()
class TestStatefulStoreHandlersComponent extends FluxUiStatefulComponent<TestStatefulStoreHandlersProps, TestStatefulStoreHandlersState> {
  int numberOfHandlerCalls = 0;

  @override
  render() => Dom.div()();

  @override
  getStoreHandlers() => {props.store: increment};

  increment(Store store) {
    numberOfHandlerCalls += 1;
  }
}

