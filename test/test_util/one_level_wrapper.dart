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

// ignore_for_file: deprecated_member_use_from_same_package

library test_util.one_level_wrapper;

import 'package:over_react/over_react.dart';

part 'one_level_wrapper.over_react.g.dart';

@Factory()
// ignore: undefined_identifier, invalid_assignment
UiFactory<OneLevelWrapperProps> OneLevelWrapper = _$OneLevelWrapper;

@Props()
class _$OneLevelWrapperProps extends UiProps {}

@Component(isWrapper: true)
class OneLevelWrapperComponent extends UiComponent<OneLevelWrapperProps> {
  @override
  render() => Dom.div()(props.children!.single);
}
