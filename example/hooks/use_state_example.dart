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
part 'use_state_example.over_react.g.dart';

mixin UseStateExampleProps on UiProps {}

UiFactory<UseStateExampleProps> UseStateExample = uiFunction(
  (props) {
    final count = useState(1);
    final evenOdd = useState('even');

    useEffect(() {
      if (count.value % 2 == 0) {
        print('count changed to ' + count.value.toString());
        evenOdd.set('even');
      } else {
        print('count changed to ' + count.value.toString());
        evenOdd.set('odd');
      }
      return () {
        print('count is changing... do some cleanup if you need to');
      };

      /// This dependency prevents the effect from running every time [evenOdd.value] changes.
    }, [count.value]);

    return Fragment()(
      (Dom.button()..onClick = (_) => count.set(1))('Reset'),
      (Dom.button()
        ..onClick = (_) => count.setWithUpdater((prev) => prev + 1)
      )('+'),
      Dom.br()(),
      Dom.p()('${count.value} is ${evenOdd.value}'),
    );
  },
  $UseStateExampleConfig, // ignore: undefined_identifier
);
