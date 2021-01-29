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

library test_component2.type_inheritance.extendedtype;

import 'package:over_react/over_react.dart';
import './abstract2.dart';

part 'extendedtype2.over_react.g.dart';

@Factory()
// ignore: undefined_identifier, invalid_assignment
UiFactory<TestExtendtype2Props> TestExtendtype2 = _$TestExtendtype2;

@Props()
class _$TestExtendtype2Props extends TestAbstract2Props {}

@Component2(subtypeOf: TestAbstract2Component)
class TestExtendtype2Component extends TestAbstract2Component<TestExtendtype2Props> {
  @override
  render() => Dom.div()();
}
