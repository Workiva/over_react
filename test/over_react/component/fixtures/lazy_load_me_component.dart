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

import 'lazy_load_me_props.dart';

// ignore_for_file: uri_has_not_been_generated
part 'lazy_load_me_component.over_react.g.dart';

class LazyLoadMeProps = UiProps with LazyLoadMePropsMixin;

UiFactory<LazyLoadMeProps> LazyLoadMe = uiFunction(
  (props) {
    final count = useState(props.initialCount ?? 0);
    final delta = useState(1);

    var increment = useCallback((_) {
      count.setWithUpdater((prev) => prev + delta.value);
    }, [delta.value]);

    var incrementDelta = useCallback((_) {
      delta.setWithUpdater((prev) => prev + 1);
    }, []);

    return (Dom.div()..addUnconsumedDomProps(props, []))(
      Dom.div()('Delta is ${delta.value}'),
      Dom.div()('Count is ${count.value}'),
      (Dom.button()..onClick = increment)('Increment count'),
      (Dom.button()..onClick = incrementDelta)('Increment delta'),
    );
  },
  _$LazyLoadMeConfig, // ignore: undefined_identifier
);
