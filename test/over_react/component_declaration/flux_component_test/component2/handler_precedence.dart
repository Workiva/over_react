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
part of over_react.component_declaration.component2.flux_component_test;

@Factory()
// ignore: undefined_identifier, invalid_assignment
UiFactory<TestHandlerPrecedenceProps> TestHandlerPrecedence = _$TestHandlerPrecedence;

@Props()
class _$TestHandlerPrecedenceProps extends FluxUiProps<TestActions, TestStores> {}

@Component2()
class TestHandlerPrecedenceComponent extends FluxUiComponent2<TestHandlerPrecedenceProps> {
  int numberOfRedraws = 0;
  int numberOfHandlerCalls = 0;

  @override
  render() => Dom.div()();

  @override
  redrawOn() => [props.store.store1, props.store.store2];

  @override
  getStoreHandlers() => {props.store.store1: increment};

  increment(Store store) {
    numberOfHandlerCalls += 1;
  }

  @override
  void setState(Map? _, [Function()? callback]) {
    numberOfRedraws++;
    if (callback != null) callback();
  }
}

