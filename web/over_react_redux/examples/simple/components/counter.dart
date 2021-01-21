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

/// Connected Redux Component
///
/// As shown in the example below, the same component can be connected to Redux in
/// such a way that it behaves differently.
UiFactory<CounterProps> Counter = connect<CounterState, CounterProps>(
    mapStateToProps: (state) => (_Counter()..currentCount = state.smallCount)
)(_Counter);

UiFactory<CounterProps> BigCounter = connect<CounterState, CounterProps>(
  mapStateToProps: (state) => (_Counter()..currentCount = state.bigCount),
  mapDispatchToProps: (dispatch) => (
      _Counter()
        ..increment = () { dispatch(BigIncrementAction()); }
        ..decrement = () { dispatch(BigDecrementAction()); }
  ),
)(_Counter);

UiFactory<CounterProps> _Counter = castUiFactory(_$_Counter);

mixin CounterPropsMixin on UiProps {
  int currentCount;

  Map<String, dynamic> wrapperStyles;

  void Function() increment;

  void Function() decrement;
}

class CounterProps = UiProps with CounterPropsMixin, ConnectPropsMixin;

class CounterComponent extends UiComponent2<CounterProps> {
  @override
  render() {
    return (Dom.div()..style = props.wrapperStyles)(
        Dom.div()('Count: ${props.currentCount}'),
        (Dom.button()..onClick = (_) {

          // Note that if the component is rendered as a BigCounter that
          // this will be set via mapDispatchToProps, otherwise it will be null.
          if (props.increment != null) {
            props.increment();
          } else if (props.dispatch != null) {
            props.dispatch(SmallIncrementAction());
          }
        })('+'),
        (Dom.button()..onClick = (_) {
          if (props.decrement != null) {
            props.decrement();
          } else if (props.dispatch != null) {
            props.dispatch(SmallDecrementAction());
          }
        })('-'),
        props.children
    );
  }
}
