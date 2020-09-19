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

// ignore_for_file: uri_has_not_been_generated, unnecessary_statements, avoid_single_cascade_in_expression_statements, over_react_boilerplate_error
part 'rules_of_hooks.over_react.g.dart';

mixin FooProps on UiProps {
  bool condition;
  List items;
  String type;
  Function(dynamic) callback;
}

UiFactory<FooProps> Foo = uiFunction(
  (props) {
    // Good hook; used directly within function component
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
    // Bad hooks: inside short-circuiting expressions
    //

    useState(0).value ?? useState(1).value;
    useState(true).value || useState(false).value;
    useState(true).value && useState(false).value;

    dynamic variable;
    variable ??= useState(0);

    // only available w/ nnbd?
    // props?..callback(useState(0));
    // only available w/ nnbd
    // props.style?['foo']?.call(useState(0));
    // not supported, only valid with nnbd null-shorting
    //props?.callback.call(useState(0)); // ignore: can_be_null_after_null_aware
    props.callback?.call(useState(0));
    props?.callback(useState(0));
    props.callback?.call(useState(0)); // ignore: can_be_null_after_null_aware
    domProps()?.tabIndex = useState(0);
    [
      ...?(useState([]).value)
    ];

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
  $FooConfig, // ignore: undefined_identifier
);

mixin BarProps on UiProps {}

// Good hook; used directly within function component (uiForwardRef)
UiFactory<BarProps> Bar = uiForwardRef(
  (props, ref) {
    useState(0);
  },
  $BarConfig, // ignore: undefined_identifier
);

// Good hook: used directly within custom hook
void useSomething() {
  useEffect(() {});
}

// Good hook: after non-conditional return
// This is invalid, but we shouldn't warn for it because
// the analyzer already warns about dead code.
void useSomethingElse() {
  return;

  // ignore: dead_code
  useState(0);
}

// Bad hook: used in a function that's not a custom hook
void notACustomHook() {
  useEffect(() {});
}

// Bad hook: used in a class
class SomeClass {
  someMethod() {
    useEffect(() {});
  }
}

// Bad hooks: used outside of a function body
var value = useState(0);
class SomeClass2 {
  var value = useState(0);
}
