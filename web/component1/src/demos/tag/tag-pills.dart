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

// ignore_for_file: file_names
import 'package:over_react/over_react.dart';

import '../../demo_components.dart';

ReactElement tagPillsDemo() => Dom.div()(
  (Tag()
    ..isPill = true
    ..skin = TagSkin.DEFAULT
  )('Default'),
  (Tag()
    ..isPill = true
    ..skin = TagSkin.PRIMARY
  )('Primary'),
  (Tag()
    ..isPill = true
    ..skin = TagSkin.SUCCESS
  )('Success'),
  (Tag()
    ..isPill = true
    ..skin = TagSkin.INFO
  )('Info'),
  (Tag()
    ..isPill = true
    ..skin = TagSkin.WARNING
  )('Warning'),
  (Tag()
    ..isPill = true
    ..skin = TagSkin.DANGER
  )('Danger')
);
