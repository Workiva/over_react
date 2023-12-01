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

import 'redux_actions.dart';

part 'counter.over_react.g.dart';

@Factory()
// ignore: undefined_identifier, invalid_assignment
UiFactory<CounterProps> Counter = _$Counter;

@Props()
class _$CounterProps extends UiProps with ConnectPropsMixin {
  int? currentCount;

  Map<String, dynamic>? wrapperStyles;

  void Function()? increment;

  void Function()? decrement;
}

@Component2()
class CounterComponent extends UiComponent2<CounterProps> {
  @override
  render() {
    return (Dom.div()
      ..modifyProps(addUnconsumedDomProps)
      ..style = props.wrapperStyles
      ..addTestId('counter-component')
    )(
      Dom.div()('Count: ${props.currentCount}'),
      (Dom.button()
        ..addTestId('button-increment')
        ..onClick = (_) {
          if (props.increment != null) {
            props.increment!();
          } else if (props.dispatch != null) {
            props.dispatch!(IncrementAction());
          }
        }
      )('+'),
      (Dom.button()
        ..addTestId('button-decrement')
        ..onClick = (_) {
          if (props.decrement != null) {
            props.decrement!();
          } else if (props.dispatch != null) {
            props.dispatch!(DecrementAction());
          }
        }
      )('-'),
      (Dom.button()
        ..addTestId('button-model-increment')
        ..onClick = (_) {
          if (props.dispatch != null) {
            props.dispatch!(IncrementModelCountAction());
          }
        }
      )('+'),
      (Dom.button()
        ..addTestId('button-model-decrement')
        ..onClick = (_) {
          if (props.dispatch != null) {
            props.dispatch!(DecrementModelCountAction());
          }
        }
      )('-'),
      props.children,
    );
  }
}
