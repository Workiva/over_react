// Copyright 2023 Workiva Inc.
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

part 'third_party_file.over_react.g.dart';

// Because you cannot use types from lazy loaded components until after you have imported them, this is the "workaround".
// I, keal jones, am not a fan.
@Props(keyNamespace: '')
mixin CounterPropsMixin on UiProps {
  num? initialCount;
}

UiFactory<CounterPropsMixin> CounterPropsMapView = castUiFactory(_$CounterPropsMapView);
