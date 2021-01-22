// Copyright 2021 Workiva Inc.
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

import 'package:over_react/over_react.dart';
import 'package:over_react_test/over_react_test.dart';
import 'package:test/test.dart';

final bigCounterContext = createContext();

void expectCountValue(TestJacket jacket, int expectedValue, {String reason}) {
  expect(queryByTestId(jacket.mountNode, 'count').text, 'Count: $expectedValue', reason: reason);
}

Future<Null> clickSiblingConnectedIncrementButton(TestJacket jacket) async {
  // Use a sibling connected component's increment button for tests
  // that shouldn't rely on `useDispatch` to ensure the subscription to context is wired up correctly
  final incrementButton = queryByTestId(queryByTestId(jacket.mountNode, 'sibling-counter'), 'button-increment');
  incrementButton.click();
  await pumpEventQueue();
}

Future<Null> clickSiblingConnectedModelCountIncrementButton(TestJacket jacket) async {
  // Use a sibling connected component's increment button for tests
  // that shouldn't rely on `useDispatch` to ensure the subscription to context is wired up correctly
  final incrementButton = queryByTestId(queryByTestId(jacket.mountNode, 'sibling-counter'), 'button-model-increment');
  incrementButton.click();
  await pumpEventQueue();
}

void expectBigCountValue(TestJacket jacket, int expectedValue, {String reason}) {
  expect(queryByTestId(jacket.mountNode, 'big-count').text, 'Big Count: $expectedValue', reason: reason);
}

Future<Null> clickSiblingConnectedBigCountIncrementButton(TestJacket jacket) async {
  // Use a sibling connected component's increment button for tests
  // that shouldn't rely on `useDispatch` to ensure the subscription to context is wired up correctly
  final incrementButton = queryByTestId(queryByTestId(jacket.mountNode, 'big-sibling-counter'), 'button-increment');
  incrementButton.click();
  await pumpEventQueue();
}
