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
import 'package:over_react/over_react_redux.dart';
import '../store.dart';

part 'counter.over_react.g.dart';

UiFactory<CounterProps> Counter = connect<CounterState, CounterProps>(
    mapStateToProps: (state) => (_Counter()..currentCount = state.count)
)(_Counter);

UiFactory<CounterProps> CounterWithDifferentContext = connect<CounterState, CounterProps>(
  mapStateToProps: (state) => (_Counter()..currentCount = state.count),
  context: bigCounterContext,
)(_Counter);

UiFactory<CounterProps> _Counter = castUiFactory(_$_Counter); // ignore: undefined_identifier

mixin CounterPropsMixin on UiProps {
  int? currentCount;

  Map<String, dynamic>? wrapperStyles;

  void Function()? increment;

  void Function()? decrement;
}

class CounterProps = UiProps with CounterPropsMixin, ConnectPropsMixin;

class CounterComponent extends UiComponent2<CounterProps> {
  @override
  render() {
    return (Dom.div()..style = props.wrapperStyles)(
        Dom.div()('Count: ${props.currentCount}'),
        (Dom.button()..onClick = (_) {
          if (props.increment != null) {
            props.increment!();
          } else  {
            props.dispatch(IncrementAction());
          }
        })('+'),
        (Dom.button()..onClick = (_) {
          if (props.decrement != null) {
            props.decrement!();
          } else  {
            props.dispatch(DecrementAction());
          }
        })('-'),
        props.children
    );
  }
}
