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

import 'package:over_react/react_dom.dart' as react_dom;
import 'package:over_react/over_react.dart';

import '../../demos.dart';

main() {
  setClientConfiguration();

  react_dom.render(listGroupBasicDemo(),
      querySelector('$demoMountNodeSelectorPrefix--list-group-basic'));

  react_dom.render(listGroupTagsDemo(),
      querySelector('$demoMountNodeSelectorPrefix--list-group-tags'));

  react_dom.render(listGroupAnchorsAndButtonsDemo(),
      querySelector('$demoMountNodeSelectorPrefix--list-group-anchors-and-buttons'));

  react_dom.render(listGroupContextualSkinDemo(),
      querySelector('$demoMountNodeSelectorPrefix--list-group-contextual'));

  react_dom.render(listGroupHeaderDemo(),
      querySelector('$demoMountNodeSelectorPrefix--list-group-header'));
}
