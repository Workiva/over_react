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
part 'use_memo_example.over_react.g.dart';

int fibonacci(int n) {
  if (n <= 1) {
    return 1;
  }
  return fibonacci(n - 1) + fibonacci(n - 2);
}

mixin UseMemoExampleProps on UiProps {}

UiFactory<UseMemoExampleProps> UseMemoExample = uiFunction(
  (props) {
    final count = useState(0);

    final fib = useMemo(
      () => fibonacci(count.value),

      /// This dependency prevents [fib] from being re-calculated every time the component re-renders.
      [count.value],
    );

    return Fragment()(
      Dom.div()('Fibonacci of ${count.value} is $fib'),
      (Dom.button()
        ..onClick = (_) => count.setWithUpdater((prev) => prev + 1)
      )('+'),
    );
  },
  _$UseMemoExampleConfig, // ignore: undefined_identifier
);
