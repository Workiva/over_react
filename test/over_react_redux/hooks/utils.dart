
import 'package:over_react_test/over_react_test.dart';
import 'package:test/test.dart';

void expectCountValue(TestJacket jacket, int expectedValue) {
  expect(queryByTestId(jacket.mountNode, 'count').text, 'Count: $expectedValue');
}

Future<Null> clickIncrementButton(TestJacket jacket) async {
  final incrementButton = queryByTestId(queryByTestId(jacket.mountNode, 'counter-component'), 'button-increment');
  incrementButton.click();
  await pumpEventQueue();
}

Future<Null> clickSiblingConnectedIncrementButton(TestJacket jacket) async {
  // Use a sibling connected component's increment button for tests
  // that shouldn't rely on `useDispatch` to ensure the subscription to context is wired up correctly
  final incrementButton = queryByTestId(queryByTestId(jacket.mountNode, 'sibling-counter'), 'button-increment');
  incrementButton.click();
  await pumpEventQueue();
}

void expectModelCountValue(TestJacket jacket, int expectedValue) {
  expect(queryByTestId(jacket.mountNode, 'count-from-model').text, 'Model Count: $expectedValue');
}

Future<Null> clickSiblingConnectedModelCountIncrementButton(TestJacket jacket) async {
  // Use a sibling connected component's increment button for tests
  // that shouldn't rely on `useDispatch` to ensure the subscription to context is wired up correctly
  final incrementButton = queryByTestId(queryByTestId(jacket.mountNode, 'sibling-counter'), 'button-model-increment');
  incrementButton.click();
  await pumpEventQueue();
}

void expectBigCountValue(TestJacket jacket, int expectedValue) {
  expect(queryByTestId(jacket.mountNode, 'big-count').text, 'Big Count: $expectedValue');
}

Future<Null> clickBigIncrementButton(TestJacket jacket) async {
  final incrementButton = queryByTestId(queryByTestId(jacket.mountNode, 'custom-context-counter-component'), 'button-big-increment');
  incrementButton.click();
  await pumpEventQueue();
}

Future<Null> clickSiblingConnectedBigCountIncrementButton(TestJacket jacket) async {
  // Use a sibling connected component's increment button for tests
  // that shouldn't rely on `useDispatch` to ensure the subscription to context is wired up correctly
  final incrementButton = queryByTestId(queryByTestId(jacket.mountNode, 'big-sibling-counter'), 'button-increment');
  incrementButton.click();
  await pumpEventQueue();
}

void expectStoreCountValue(TestJacket jacket, int expectedValue) {
  expect(queryByTestId(jacket.mountNode, 'count-from-store').text, 'Store Count: $expectedValue');
}

void expectStoreBigCountValue(TestJacket jacket, int expectedValue) {
  expect(queryByTestId(jacket.mountNode, 'big-count-from-store').text, 'Big Store Count: $expectedValue');
}
