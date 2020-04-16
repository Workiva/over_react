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
UiFactory<TestStatefulHandlerLifecycleProps> TestStatefulHandlerLifecycle = _$TestStatefulHandlerLifecycle;

@Props()
class _$TestStatefulHandlerLifecycleProps extends FluxUiProps<TestActions, TestStore> implements TestHandlerLifecycleProps {}

@State()
class _$TestStatefulHandlerLifecycleState extends UiState {}

@Component()
class TestStatefulHandlerLifecycleComponent extends FluxUiStatefulComponent<TestStatefulHandlerLifecycleProps, TestStatefulHandlerLifecycleState> {
  List<List<dynamic>> lifecycleCalls = [];

  @override
  void handleRedrawOn(Store store) {
    lifecycleCalls.add(['handleRedrawOn', store]);
    super.handleRedrawOn(store);
  }

  @override
  void listenToStoreForRedraw(Store store) {
    lifecycleCalls.add(['listenToStoreForRedraw', store]);
    super.listenToStoreForRedraw(store);
  }

  @override
  render() => Dom.div()();
}

