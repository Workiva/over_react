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

import 'package:over_react/src/component_declaration/component_base.dart'
    as component_base;
import 'package:over_react/src/component_declaration/builder_helpers.dart'
    as builder_helpers;
import 'package:react/react_client.dart';
import 'package:react/react_client/js_backed_map.dart';
import 'package:react/react.dart' as react;

import '../../over_react.dart';

class StrictModeProps extends component_base.UiProps
    with builder_helpers.GeneratedClass
    implements builder_helpers.UiProps {
  // Initialize to a JsBackedMap so that copying can be optimized
  // when converting props during ReactElement creation.
  StrictModeProps([Map props]) : this.props = props ?? JsBackedMap();

  @override
  ReactComponentFactoryProxy componentFactory = react.StrictMode;

  @override
  PropsMetaCollection get staticMeta => throw UnimplementedError('StrictModeProps instances do not implement instance meta');

  @override
  final Map props;

  @override
  String get propKeyNamespace => '';
}

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
StrictModeProps StrictMode([Map backingMap]) => StrictModeProps(backingMap);
