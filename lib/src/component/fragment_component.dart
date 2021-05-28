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

import 'package:over_react/src/component_declaration/builder_helpers.dart'
    as builder_helpers;
import 'package:react/react_client.dart';
import 'package:react/react_client/js_backed_map.dart';
import 'package:react/react.dart' as react;

class FragmentProps extends builder_helpers.UiProps {
  // Initialize to a JsBackedMap so that copying can be optimized
  // when converting props during ReactElement creation.
  FragmentProps([Map? props]) : this.props = props ?? JsBackedMap();

  @override
  ReactComponentFactoryProxy? componentFactory = react.Fragment;

  @override
  final Map props;

  @override
  String get propKeyNamespace => '';

  @override
  bool get $isClassGenerated => true;
}

/// Fragment component that allows the wrapping of children without the necessity of using
/// an element that adds an additional layer to the DOM (div, span, etc).
///
/// See: <https://reactjs.org/docs/fragments.html>
FragmentProps Fragment([Map? backingMap]) => FragmentProps(backingMap);
