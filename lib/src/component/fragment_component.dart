// @dart=2.11
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


import 'package:over_react/src/util/js_component.dart';
import 'package:over_react/src/util/prop_key_util.dart';
import 'package:react/react.dart' as react;
import 'package:react/react_client/js_backed_map.dart';

import '../component_declaration/builder_helpers.dart';
import '../component_declaration/function_component.dart';

part 'fragment_component.over_react.g.dart';

@Props(keyNamespace: '')
class FragmentProps extends UiProps {}

/// Fragment component that allows the wrapping of children without the necessity of using
/// an element that adds an additional layer to the DOM (div, span, etc).
///
/// See: <https://reactjs.org/docs/fragments.html>
final UiFactory<FragmentProps> Fragment = uiJsComponent(react.Fragment, _$FragmentConfig);
