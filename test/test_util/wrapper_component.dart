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

library test_util.wrapper_component;

import 'package:over_react/over_react.dart';

/// A helper component for use in tests where a component needs to be
/// rendered inside a wrapper, but a composite component must be used
/// for compatability with `getByTestId()`.
@Factory()
UiFactory<UiProps> Wrapper;

@Props()
class WrapperProps extends UiProps {}

@Component()
class WrapperComponent extends UiComponent<WrapperProps> {
  @override
  render() => (Dom.div()..addAll(props))(props.children);
}
