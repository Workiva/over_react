// Copyright 2016 Workiva Inc.
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

library test_react_element_typing;

import 'package:react/react_client.dart';

import './test_component_declaration.dart';

/// Verify that treating the invocation of the builder as an unparameterized [ReactElement]
/// does not result in the following analyzer warning:
///
///     Unsound implicit cast from ReactElement<dynamic> to ReactElement<Component>
ReactElement _reactElementTypingTest() {
  ReactElement element = Foo()();

  return element;
}

main() {
  _reactElementTypingTest();
}
