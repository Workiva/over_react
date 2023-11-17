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

ReactElement tagContextualDemo() => Dom.div()(
  (Tag()..skin = TagSkin.DEFAULT)('Default'),
  (Tag()..skin = TagSkin.PRIMARY)('Primary'),
  (Tag()..skin = TagSkin.SUCCESS)('Success'),
  (Tag()..skin = TagSkin.INFO)('Info'),
  (Tag()..skin = TagSkin.WARNING)('Warning'),
  (Tag()..skin = TagSkin.DANGER)('Danger')
);
