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

library test_component2.type_inheritance.subsubtype;

import 'package:over_react/over_react.dart';
import './subtype.dart';

part 'subsubtype.over_react.g.dart';

@Factory()
UiFactory<TestSubsubtype2Props> TestSubsubtype2 = _$TestSubsubtype2;

@Props()
class _$TestSubsubtype2Props extends UiProps {}

@Component2(subtypeOf: TestSubtype2Component)
class TestSubsubtype2Component extends UiComponent2<TestSubsubtype2Props> {
  @override
  render() => Dom.div()();
}

