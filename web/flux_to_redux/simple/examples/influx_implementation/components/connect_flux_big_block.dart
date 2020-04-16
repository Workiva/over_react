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
import 'package:over_react/over_react_flux.dart';
import 'package:over_react/over_react_redux.dart';

import '../store.dart';

part 'connect_flux_big_block.over_react.g.dart';

// When refactoring from a Flux component to a connectFlux component:
// [1] Add props for the state values that are needed, and remove the store prop.
// [2] Add props for the actions that are needed (if you intend to use mapActionsToProps).
// [3] Refactor calls to the `store` prop to the new props added in [1] and [2].
// [4] Wrap the existing factory in a `connectFlux` call.
// [5] Use `mapStateToProps` and `mapActionsToProps` to point props to the correct state values.

// [4]
UiFactory<ConnectFluxBigBlockProps> ConnectFluxBigBlock =
    connectFlux<FluxStore, RandomColorActions, ConnectFluxBigBlockProps>(
  // [5]
  mapStateToProps: (state) => (ConnectFluxBigBlock()..backgroundColor = state?.backgroundColor),
  mapActionsToProps: (actions) =>
      (ConnectFluxBigBlock()..changeBackgroundColor = actions.changeBackgroundColor),
)(_$ConnectFluxBigBlock); // ignore: undefined_identifier

mixin ConnectFluxBigBlockPropsMixin on UiProps {
  String backgroundColor; // [1]

  void Function() changeBackgroundColor; // [2]
}

class ConnectFluxBigBlockProps = UiProps with ConnectFluxBigBlockPropsMixin, ConnectPropsMixin;

class ConnectFluxBigBlockComponent extends UiComponent2<ConnectFluxBigBlockProps> {
  @override
  render() {
    return (Dom.div()..style = {
      'padding': '50px',
      'backgroundColor': props.backgroundColor, // [3]
      'color': 'white'
    })(
      'This module uses a connect flux pattern to change its background color.',
      (Dom.button()
        ..onClick = (_) {
          props.changeBackgroundColor(); // [3]
        }
        ..style = {'padding': '10px', 'margin': '10px'}
      )('Change Background Color'),
    );
  }
}
