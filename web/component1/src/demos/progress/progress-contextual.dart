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

ReactElement progressContextualDemo() => Dom.div()(
  (Progress()
    ..value = 25.0
    ..skin = ProgressSkin.SUCCESS
  )(),
  (Progress()
    ..value = 50.0
    ..skin = ProgressSkin.INFO
  )(),
  (Progress()
    ..value = 75.0
    ..skin = ProgressSkin.WARNING
  )(),
  (Progress()
    ..value = 100.0
    ..skin = ProgressSkin.DANGER
  )()
);
