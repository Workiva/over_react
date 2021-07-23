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

import 'package:over_react/over_react.dart';

part 'flawed_component.over_react.g.dart';

@Factory()
// ignore: undefined_identifier, invalid_assignment
UiFactory<FlawedProps> Flawed = _$Flawed;

@Props()
class _$FlawedProps extends UiProps {
  String? buttonTestIdPrefix;
}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class FlawedProps extends _$FlawedProps with _$FlawedPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value, invalid_assignment
  static const PropsMeta meta = _$metaForFlawedProps;
}

@State()
class _$FlawedState extends UiState {
  int? errorCount;
  int? differentTypeOfErrorCount;
}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class FlawedState extends _$FlawedState with _$FlawedStateAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const StateMeta meta = _$metaForFlawedState;
}

@Component2()
class FlawedComponent extends UiStatefulComponent2<FlawedProps, FlawedState> {
  @override
  get defaultProps => (newProps()..buttonTestIdPrefix = 'flawedComponent_');

  @override
  get initialState => (newState()
    ..errorCount = 0
    ..differentTypeOfErrorCount = 0);

  @override
  getSnapshotBeforeUpdate(Map prevProps, Map prevState) {
    final FlawedState tPrevState = typedStateFactory(prevState);
    if (state.errorCount! > tPrevState.errorCount!) {
      throw FlawedComponentException();
    }

    if (state.differentTypeOfErrorCount! > tPrevState.differentTypeOfErrorCount!) {
      throw FlawedComponentException2();
    }
  }

  @override
  render() {
    return Dom.div()(
      (Dom.button()
        ..addTestId('${props.buttonTestIdPrefix}flawedButton')
        ..onClick = (_) {
          setState(newState()..errorCount = state.errorCount! + 1);
        }
      )(
        'oh hai',
      ),
      (Dom.button()
        ..addTestId(
            '${props.buttonTestIdPrefix}flawedButtonThatThrowsADifferentError')
        ..onClick = (_) {
          setState(newState()..differentTypeOfErrorCount = state.differentTypeOfErrorCount! + 1);
        }
      )(
        'oh hai',
      ),
      props.children,
    );
  }
}

class FlawedComponentException implements Exception {
  @override
  String toString() => 'FlawedComponentException: I was thrown from inside FlawedComponent.componentWillUpdate!';
}

class FlawedComponentException2 implements Exception {
  @override
  String toString() => 'FlawedComponentException2: I was thrown from inside FlawedComponent.componentWillUpdate!';
}
