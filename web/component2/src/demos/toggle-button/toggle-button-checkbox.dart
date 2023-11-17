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

import 'package:over_react/over_react.dart';

import '../../demo_components.dart';

ReactElement checkboxToggleButtonDemo() =>
  (ToggleButtonGroup()
    ..toggleType = ToggleBehaviorType.CHECKBOX
  )(
    (ToggleButton()
      ..value = '1'
    )('Checkbox 1'),
    (ToggleButton()
      ..value = '2'
      ..defaultChecked = true
    )('Checkbox 2'),
    (ToggleButton()
      ..value = '3'
    )('Checkbox 3')
  );
