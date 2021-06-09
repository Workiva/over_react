// @dart=2.7
// ^ Do not remove until migrated to null safety. More info at https://wiki.atl.workiva.net/pages/viewpage.action?pageId=189370832
// Copyright 2020 Workiva Inc.
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

import 'dart:html';

import 'package:over_react/components.dart' as v2;
import 'package:over_react/react_dom.dart' as react_dom;

import 'src/demos.dart';

void main() {
  react_dom.render(
    v2.ErrorBoundary()(buttonExamplesDemo()), querySelector('$demoMountNodeSelectorPrefix--button'));

  react_dom.render(
    v2.ErrorBoundary()(listGroupBasicDemo()), querySelector('$demoMountNodeSelectorPrefix--list-group'));

  react_dom.render(
    v2.ErrorBoundary()(progressBasicDemo()), querySelector('$demoMountNodeSelectorPrefix--progress'));

  react_dom.render(
    v2.ErrorBoundary()(tagBasicDemo()), querySelector('$demoMountNodeSelectorPrefix--tag'));

  react_dom.render(
    v2.ErrorBoundary()(checkboxToggleButtonDemo()), querySelector('$demoMountNodeSelectorPrefix--checkbox-toggle'));

  react_dom.render(
    v2.ErrorBoundary()(radioToggleButtonDemo()), querySelector('$demoMountNodeSelectorPrefix--radio-toggle'));

  react_dom.render(
    (v2.ErrorBoundary()
      ..onComponentDidCatch = (error, info) {
        print('Consumer props.onComponentDidCatch($error, $info)');
      }
    )(Faulty()()),
    querySelector('$demoMountNodeSelectorPrefix--faulty-component'),
  );

  react_dom.render(
    Faulty()(), querySelector('$demoMountNodeSelectorPrefix--faulty-component-without-error-boundary'));
}
