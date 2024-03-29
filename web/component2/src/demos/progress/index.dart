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

import '../../demos.dart';

main() {
  react_dom.render(progressBasicDemo(),
      querySelector('$demoMountNodeSelectorPrefix--progress-basic')!);

  react_dom.render(progressContextualDemo(),
      querySelector('$demoMountNodeSelectorPrefix--progress-contextual')!);

  react_dom.render(progressStripedDemo(),
      querySelector('$demoMountNodeSelectorPrefix--progress-striped')!);

  react_dom.render(progressAnimatedStripesDemo(),
      querySelector('$demoMountNodeSelectorPrefix--progress-animated-stripes')!);
}
