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

import 'package:over_react/js_component.dart';
import 'package:over_react/src/component_declaration/function_component.dart';
import 'package:react/react.dart' as react;
import 'package:react/react_client/js_backed_map.dart';

import '../component_declaration/builder_helpers.dart';

part 'strictmode_component.over_react.g.dart';

@Props(keyNamespace: '')
class StrictModeProps extends UiProps {}

/// A tool for highlighting potential problems in an application.
///
/// > Note:
/// > Strict mode checks are run in development mode only; they do not impact the production build.
///
/// Like [react.Fragment], [StrictMode] does not render any visible UI.
/// It activates additional checks and warnings for its descendants.
/// [StrictMode] currently helps with:
/// - Identifying components with unsafe lifecycles
/// - Warning about legacy string ref API usage
/// - Warning about deprecated findDOMNode usage
/// - Detecting unexpected side effects
/// - Detecting legacy context API
///
/// Example Usage:
/// ```
///   render() {
///     return Dom.div()(
///       Header()(),
///       StrictMode()(
///         Dom.div()(
///           ComponentOne()(),
///           ComponentTwo()(),
///         ),
///       ),
///       Footer()(),
///     );
///   }
/// ```
/// In the above example, strict mode checks will not be run against the Header and Footer components.
/// However, ComponentOne and ComponentTwo, as well as all of their descendants, will have the checks.
///
/// StrictMode logs all warnings to the browser console.
///
/// See: <https://reactjs.org/docs/strict-mode.html>
UiFactory<StrictModeProps> StrictMode = uiJsComponent(react.StrictMode, _$StrictModeConfig);
