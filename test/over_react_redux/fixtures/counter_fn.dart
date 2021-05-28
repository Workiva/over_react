// Copyright 2021 Workiva Inc.
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
import 'package:over_react/over_react_redux.dart';

import '../hooks/utils.dart';
import 'redux_actions.dart';
import 'store.dart';

// ignore_for_file: uri_has_not_been_generated
part 'counter_fn.over_react.g.dart';

mixin CounterFnProps on UiProps {
  bool Function(int? nextCount, int? prevCount)? countEqualityFn;
}

UiFactory<CounterFnProps> CounterFn = uiFunction(
  (props) {
    final currentCount =
        useSelector<CounterState, int>((state) => state.count, props.countEqualityFn);

    return (Dom.div()
      ..addUnconsumedDomProps(props, const [])
      ..addTestId('counter-component')
    )(
      (Dom.div()..addTestId('count'))('Count: $currentCount'),
      props.children,
    );
  },
  _$CounterFnConfig, // ignore: undefined_identifier
);

mixin ModelCounterFnPropsMixin on UiProps {
  bool Function(DartModelCounter? nextCount, DartModelCounter? prevCount)? modelCountEqualityFn;
}

class ModelCounterFnProps = UiProps with CounterFnProps, ModelCounterFnPropsMixin;

UiFactory<ModelCounterFnProps> ModelCounterFn = uiFunction(
  (props) {
    final currentModelCount =
        useSelector<CounterState, DartModelCounter>((state) => state.modelCount, props.modelCountEqualityFn);

    final dispatch = useDispatch();

    final Iterable<PropsMeta> consumedProps = props.staticMeta.allExceptForMixins({ModelCounterFnPropsMixin});

    return (CounterFn()
      ..addUnconsumedDomProps(props, consumedProps)
      ..addTestId('model-counter-component')
    )(
      (Dom.div()..addTestId('count-from-model'))('Model Count: ${currentModelCount.count}'),
      Dom.div()(
        'Mutate Model Count:',
        (Dom.button()
          ..addTestId('button-model-increment')
          ..onClick = (_) {
            dispatch(IncrementModelCountAction());
          }
        )('+'),
        (Dom.button()
          ..addTestId('button-model-decrement')
          ..onClick = (_) {
            dispatch(DecrementModelCountAction());
          }
        )('-'),
      ),
    );
  },
  _$ModelCounterFnConfig, // ignore: undefined_identifier
);

final useBigCountSelector = createSelectorHook<BigCounterState>(bigCounterContext);

mixin CustomContextCounterFnPropsMixin on UiProps {
  bool Function(int nextBigCount, int prevBigCount)? bigCountEqualityFn;
}

class CustomContextCounterFnProps = UiProps with CounterFnProps, CustomContextCounterFnPropsMixin;

UiFactory<CustomContextCounterFnProps> CustomContextCounterFn = uiFunction(
  (props) {
    final bigCount = useBigCountSelector((state) => state.bigCount, props.bigCountEqualityFn);

    final Iterable<PropsMeta> consumedProps = props.staticMeta.allExceptForMixins({CustomContextCounterFnPropsMixin});

    return (CounterFn()
      ..addUnconsumedDomProps(props, consumedProps)
      ..addTestId('custom-context-counter-component')
    )(
      (Dom.div()..addTestId('big-count'))('Big Count: $bigCount'),
      props.children,
    );
  },
  _$CustomContextCounterFnConfig, // ignore: undefined_identifier
);
