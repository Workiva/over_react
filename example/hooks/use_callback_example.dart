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
part 'use_callback_example.over_react.g.dart';

mixin UseCallbackExampleProps on UiProps {}

UiFactory<UseCallbackExampleProps> UseCallbackExample = uiFunction(
  (props) {
    final count = useState(0);
    final delta = useState(1);

    var increment = useCallback((_) {
      count.setWithUpdater((prev) => prev + delta.value);
    }, [delta.value]);

    var incrementDelta = useCallback((_) {
      delta.setWithUpdater((prev) => prev + 1);
    }, []);

    return Fragment()(
      Dom.div()('Delta is ${delta.value}'),
      Dom.div()('Count is ${count.value}'),
      (Dom.button()..onClick = increment)('Increment count'),
      (Dom.button()..onClick = incrementDelta)('Increment delta'),
    );
  },
  _$UseCallbackExampleConfig, // ignore: undefined_identifier
);
