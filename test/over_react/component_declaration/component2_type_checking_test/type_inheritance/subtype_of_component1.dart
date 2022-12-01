// Copyright 2019 Workiva Inc.
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

import '../../component_type_checking_test/type_inheritance/parent.dart';

part 'subtype_of_component1.over_react.g.dart';

@Factory()
// ignore: undefined_identifier, invalid_assignment
UiFactory<TestSubtypeOfComponent1Props> TestSubtypeOfComponent1 = _$TestSubtypeOfComponent1;

@Props()
class _$TestSubtypeOfComponent1Props extends UiProps {}

@Component2(subtypeOf: TestParentComponent)
class TestSubtypeOfComponent1Component extends UiComponent2<TestSubtypeOfComponent1Props> {
  @override
  render() => Dom.div()();
}
