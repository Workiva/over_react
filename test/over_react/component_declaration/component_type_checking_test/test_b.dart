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

library test_component.test_b;

import 'package:over_react/over_react.dart';

// ignore: uri_has_not_been_generated
part 'test_b.over_react.g.dart';

@Factory()
// ignore: undefined_identifier
UiFactory<TestBProps> TestB = $TestB;

@Props()
class _$TestBProps extends UiProps {}

@Component()
class TestBComponent extends UiComponent<TestBProps> {
  @override
  render() => Dom.div()();
}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class TestBProps extends _$TestBProps with _$TestBPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = $metaForTestBProps;
}
