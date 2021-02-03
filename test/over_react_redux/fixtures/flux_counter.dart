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

// ignore_for_file: deprecated_member_use_from_same_package
import 'package:over_react/over_react.dart';

import 'connect_flux_store.dart';

part 'flux_counter.over_react.g.dart';

@Factory()
// ignore: undefined_identifier, invalid_assignment
UiFactory<FluxCounterProps> FluxCounter = _$FluxCounter;

@Props()
class _$FluxCounterProps
    extends FluxUiProps<FluxActions, TestConnectableFluxStore> {}

@Component2()
class FluxCounterComponent extends FluxUiComponent2<FluxCounterProps> {
  @override
  render() {
    return (Dom.div()..modifyProps(addUnconsumedProps))(
      Dom.div()('Count: ${props.store.count}'),
      (Dom.button()
        ..addTestId('button-increment')
        ..onClick = (_) {
          props.actions.incrementAction();
        }
      )('+'),
      (Dom.button()
        ..addTestId('button-decrement')
        ..onClick = (_) {
          props.actions.decrementAction();
        }
      )('-'),
      props.children,
    );
  }
}
