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
import 'package:over_react/src/util/hoc.dart';

import '../store.dart';
import '../../../components/little_block.dart';

part 'connect_flux_big_block.over_react.g.dart';

// When refactoring from a Flux component to a connectFlux component (with multiple stores):
// [1] Add props for the state values that are needed, and remove the store prop.
// [2] Add props for the actions that are needed.
// [3] Refactor calls to the `store` prop to the new props added in [1] and [2].
// [4] Make a `composeHocs` call, passing in a `List`.
// [5] Make a `connectFlux` call for each store the component needs access to, with each call being an element in the `List`.
// [6] Tie `connectFlux` to the correct context by using the `context` parameter.
// [7] Use `mapStateToProps` and `mapActionsToProps` to point props to the correct state values.

// [4]
UiFactory<ConnectFluxBigBlockProps> ConnectFluxBigBlock = composeHocs([
  // [5]
  connectFlux<RandomColorStore, RandomColorActions, ConnectFluxBigBlockProps>(
    context: randomColorStoreContext, // [6]
    // [7]
    mapStateToProps: (state) => (ConnectFluxBigBlock()
      ..backgroundColor = state.mainBackgroundColor
      ..blockOneBackgroundColor = state.blockOneBackgroundColor
    ),
    mapActionsToProps: (actions) => (ConnectFluxBigBlock()
      ..changeMainBackgroundColor = actions!.changeMainBackgroundColor as void Function()?
      ..changeBlockOneBackgroundColor = actions.changeBlockOneBackgroundColor as void Function()?
    ),
  ),
  // [5]
  connectFlux<LowLevelStore, RandomColorActions, ConnectFluxBigBlockProps>(
    context: lowLevelStoreContext, // [6]
    // [7]
    mapStateToProps: (state) => (ConnectFluxBigBlock()..blockTwoBackgroundColor = state.backgroundColor),
    mapActionsToProps: (actions) =>
        (ConnectFluxBigBlock()..changeBlockTwoBackgroundColor = actions!.changeBlockTwoBackgroundColor as void Function()?),
  ),
  // [5]
  connectFlux<AnotherColorStore, RandomColorActions, ConnectFluxBigBlockProps>(
    context: anotherColorStoreContext, // [6]
    // [7]
    mapStateToProps: (state) => (ConnectFluxBigBlock()..blockThreeBackgroundColor = state.backgroundColor),
    mapActionsToProps: (actions) =>
        (ConnectFluxBigBlock()..changeBlockThreeBackgroundColor = actions!.changeBlockThreeBackgroundColor as void Function()?),
  ),
])(castUiFactory(_$ConnectFluxBigBlock)); // ignore: undefined_identifier

mixin ConnectFluxBigBlockPropsMixin on UiProps {
  String? backgroundColor; // [1]
  String? blockTwoBackgroundColor; // [1]
  String? blockThreeBackgroundColor; // [1]
  String? blockOneBackgroundColor; // [1]

  void Function()? changeMainBackgroundColor; // [2]
  void Function()? changeBlockOneBackgroundColor; // [2]
  void Function()? changeBlockTwoBackgroundColor; // [2]
  void Function()? changeBlockThreeBackgroundColor; // [2]
}

class ConnectFluxBigBlockProps = UiProps with ConnectFluxBigBlockPropsMixin, ConnectPropsMixin;

class ConnectFluxBigBlockComponent extends UiComponent2<ConnectFluxBigBlockProps> {
  @override
  render() {
    return (Fragment()(
      (Dom.div()
        ..style = {
          'padding': '50px',
          'backgroundColor': props.backgroundColor,
          'color': 'white',
          'display': 'flex',
          'alignItems': 'center',
          'justifyContent': 'space-evenly'
        }
      )(
        Dom.div()('This module uses a ConnectedFlux pattern to change its background color.'),
        (Dom.div()
          ..style = {
            'display': 'flex',
            'flexDirection': 'column',
          }
        )(
          (Dom.button()
            ..onClick = (_) {
              props.changeMainBackgroundColor!(); // [3]
            }
            ..style = {'padding': '10px', 'margin': '10px'}
          )('Change Main Background Color'),
          (Dom.button()
            ..onClick = (_) {
              props.changeBlockOneBackgroundColor!(); // [3]
            }
            ..style = {'padding': '10px', 'margin': '10px'}
          )('Change Block 1 Background Color'),
          (Dom.button()
            ..onClick = (_) {
              props.changeBlockTwoBackgroundColor!(); // [3]
            }
            ..style = {'padding': '10px', 'margin': '10px'}
          )('Change Block 2 Background Color'),
          (Dom.button()
            ..onClick = (_) {
              props.changeBlockThreeBackgroundColor!(); // [3]
            }
            ..style = {'padding': '10px', 'margin': '10px'}
          )('Change Block 3 Background Color'),
        ),
        (Dom.div()..style = {'display': 'flex', 'flexDirection': 'column'})(
          (LittleBlock()
            ..blockTitle = 'Block 1'
            ..backgroundColor = props.blockOneBackgroundColor // [3]
            ..colorString = props.blockOneBackgroundColor // [3]
          )(),
          (LittleBlock()
            ..blockTitle = 'Block 2'
            ..backgroundColor = props.blockTwoBackgroundColor // [3]
            ..colorString = props.blockTwoBackgroundColor // [3]
          )(),
          (LittleBlock()
            ..blockTitle = 'Block 3'
            ..backgroundColor = props.blockThreeBackgroundColor // [3]
            ..colorString = props.blockThreeBackgroundColor // [3]
          )(),
        ),
      ),
    ));
  }
}
