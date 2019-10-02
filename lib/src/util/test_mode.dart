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

library over_react.test_mode;

import 'package:over_react/src/component_declaration/component_base.dart'
    as component_base;

/// Enables test mode.
///
/// This allows `testId`s, set via [component_base.UiProps.addTestId], to be rendered.
void enableTestMode() {
  component_base.UiProps.testMode = true;
}

/// Disables test mode.
///
/// This prevents `testId`s, set via [component_base.UiProps.addTestId], from being rendered.
void disableTestMode() {
  component_base.UiProps.testMode = false;
}
