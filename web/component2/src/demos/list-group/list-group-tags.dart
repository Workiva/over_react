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

ReactElement? listGroupTagsDemo() =>
  ListGroup()(
    ListGroupItem()(
      (Tag()
        ..className = 'float-xs-right'
        ..isPill = true
      )(14),
      'Cras justo odio'
    ),
    ListGroupItem()(
      (Tag()
        ..className = 'float-xs-right'
        ..isPill = true
      )(2),
      'Dapibus ac facilisis in'
    ),
    ListGroupItem()(
      (Tag()
        ..className = 'float-xs-right'
        ..isPill = true
      )(1),
      'Morbi leo risus'
    )
  );
