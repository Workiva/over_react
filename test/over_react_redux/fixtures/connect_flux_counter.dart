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

import 'connect_flux_store.dart';

part 'connect_flux_counter.over_react.g.dart';

@Factory()
UiFactory<ConnectFluxCounterProps> ConnectFluxCounter = _$ConnectFluxCounter;

@Props()
class _$ConnectFluxCounterProps extends UiProps {
  int currentCount;

  Map<String, dynamic> wrapperStyles;

  List<String> mutatedList;

  void Function() increment;

  void Function() decrement;

  void Function() mutateStoreDirectly;
}

@Component2()
class ConnectFluxCounterComponent
    extends UiComponent2<ConnectFluxCounterProps> {
  @override
  render() {
    return (Dom.div()
      ..modifyProps(addUnconsumedProps)
      ..style = props.wrapperStyles
    )(
      Dom.div()('Count: ${props.currentCount}'),
      (Dom.button()
        ..addTestId('button-increment')
        ..onClick = (_) {
          if (props.mutateStoreDirectly != null) {
            props.mutateStoreDirectly();
          } else if (props.increment != null) {
            props.increment();
          } else {
            fluxActions.incrementAction();
          }
        }
      )('+'),
      (Dom.button()
        ..addTestId('button-decrement')
        ..onClick = (_) {
          props.decrement();
        }
      )('-'),
      props.children,
    );
  }
}
