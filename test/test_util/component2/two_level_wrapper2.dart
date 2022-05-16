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

import 'package:over_react/over_react.dart';

part 'two_level_wrapper2.over_react.g.dart';

@Factory()
// ignore: undefined_identifier, invalid_assignment
UiFactory<TwoLevelWrapper2Props> TwoLevelWrapper2 = _$TwoLevelWrapper2;

@Props()
class _$TwoLevelWrapper2Props extends UiProps {}

@Component2(isWrapper: true)
class TwoLevelWrapper2Component extends UiComponent2<TwoLevelWrapper2Props> {
  @override
  render() => Dom.div()(props.children.single);
}

