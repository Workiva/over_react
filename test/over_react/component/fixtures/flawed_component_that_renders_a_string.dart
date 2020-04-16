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

part 'flawed_component_that_renders_a_string.over_react.g.dart';

@Factory()
// ignore: undefined_identifier
UiFactory<FlawedWithStringChildProps> FlawedWithStringChild = _$FlawedWithStringChild;

@Props()
class _$FlawedWithStringChildProps extends UiProps {}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class FlawedWithStringChildProps extends _$FlawedWithStringChildProps with _$FlawedWithStringChildPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = _$metaForFlawedWithStringChildProps;
}

@Component2()
class FlawedWithStringChildComponent extends UiComponent2<FlawedWithStringChildProps> {
  @override
  void componentDidMount() {
    throw FlawedWithStringChildComponentException();
  }

  @override
  render() {
    return 'just a string, yo';
  }
}

class FlawedWithStringChildComponentException implements Exception {
  @override
  String toString() =>
      'FlawedWithStringChildComponentException: I was thrown from inside FlawedWithStringChildComponent.componentDidMount!';
}
