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

// ignore_for_file: uri_has_not_been_generated
part 'rules_of_hooks.over_react.g.dart';

mixin FooProps on UiProps {
  bool condition;
  List items;
  String type;
}

UiFactory<FooProps> Foo = uiFunction(
  (props) {
    // Good hooks
    useState(0);

    //
    // Bad hooks: inside conditions
    //

    if (props.condition) {
      useState(0);
    } else {
      useState(0);
    }

    props.condition ? useState(0) : useState(1);

    switch (props.type) {
      case 'something':
        useState(0);
        break;
    }

    //
    // Bad hooks: inside loops
    //

    for (var item in props.items) {
      useState(0);
    }

    while (props.condition) {
      useState(0);
    }

    do {
      useState(0);
    } while (props.condition);

    print([
      for (var item in props.items) useState(0),
    ]);

    //
    // Bad hooks: inside functions
    //

    onMouseDown() {
      useState(0);
    }

    ({}).putIfAbsent('', () => useEffect(() {}));

    //
    // Bad hook: after conditional return
    //

    if (props.condition) return 'foo';
    useState(0);

    return 'content';
  },
  $FooPropsConfig, // ignore: undefined_identifier
);
