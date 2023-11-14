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

ReactElement tagBasicDemo() => Fragment()(
  Dom.h1()('Example heading ', Tag()('New')),
  Dom.h2()('Example heading ', Tag()('New')),
  Dom.h3()('Example heading ', Tag()('New')),
  Dom.h4()('Example heading ', Tag()('New')),
  Dom.h5()('Example heading ', Tag()('New')),
  Dom.h6()('Example heading ', Tag()('New'))
);
