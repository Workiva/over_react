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

part 'dummy_component2.over_react.g.dart';

@Factory()
// ignore: undefined_identifier
UiFactory<_Dummy2Props> _Dummy2 = _$_Dummy2;

@Props()
class _$_Dummy2Props extends UiProps {}

@Component2()
class _Dummy2Component extends UiComponent2<_Dummy2Props> {
  @override
  render() {
    return null;
  }
}

// UiComponent2Bridge and it's jsifyPropTypes implementation require a UiComponent2,
// and cannot simply be a react.Component2 class.
//
// This is to publicly expose the generated component type for use with `registerAbstractComponent2`.
class DummyComponent2 extends _$_Dummy2Component {}
