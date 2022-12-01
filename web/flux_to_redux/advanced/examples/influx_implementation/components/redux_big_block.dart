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
import '../../../components/little_block.dart';

part 'redux_big_block.over_react.g.dart';

// When refactoring from a Flux component to a Redux component (with multiple stores):
// [1] Add props for the state values that are needed, and remove the store prop.
// [2] Add props for the actions that are needed (if you intend to use mapDispatchToProps).
// [3] Refactor calls to the `store` prop to the new props added in [1] and [2].
// [4] Make a `composeHocs` call, passing in a `List`.
// [5] Make a `connect` call for each store the component needs access to, with each call being an element in the `List`.
// [6] Tie `connect` to the correct context by using the `context` parameter.
// [7] Use `mapStateToProps` and `mapDispatchToProps` to point props to the correct state values.
// [8] Set the `pure` constructor on `connect` to be `false`.

// [4]
UiFactory<ReduxBigBlockProps> ReduxBigBlock = composeHocs([
  // [5]
  connect<RandomColorStore, ReduxBigBlockProps>(
    context: randomColorStoreContext, // [6]
    // [7]
    mapStateToProps: (state) => (ReduxBigBlock()
      ..backgroundColor = state.mainBackgroundColor
      ..blockOneBackgroundColor = state.blockOneBackgroundColor
    ),
    mapDispatchToProps: (dispatch) => (ReduxBigBlock()
      ..changeMainBackgroundColor = () {
        dispatch(UpdateBackgroundColorAction());
      }
      ..changeBlockOneBackgroundColor = () {
        dispatch(UpdateBlockOneBackgroundColorAction());
      }
      ..changeBlockTwoBackgroundColor = () {
        dispatch(UpdateBlockTwoBackgroundColorAction());
      }
      ..changeBlockThreeBackgroundColor = () {
        dispatch(UpdateBlockThreeBackgroundColorAction());
      }
    ),
    pure: false, // [8]
  ),
  // [5]
  connect<LowLevelStore, ReduxBigBlockProps>(
    context: lowLevelStoreContext, // [6]
    // [7]
    mapStateToProps: (state) => (ReduxBigBlock()..blockTwoBackgroundColor = state.backgroundColor),
    mapDispatchToProps: (dispatch) => (ReduxBigBlock()
      ..changeBlockTwoBackgroundColor = () {
        dispatch(UpdateBlockTwoBackgroundColorAction());
      }
    ),
    pure: false, // [8]
  ),
  // [5]
  connect<AnotherColorStore, ReduxBigBlockProps>(
    context: anotherColorStoreContext, // [6]
    // [7]
    mapStateToProps: (state) => (ReduxBigBlock()..blockThreeBackgroundColor = state.backgroundColor),
    mapDispatchToProps: (dispatch) => (ReduxBigBlock()
      ..changeBlockThreeBackgroundColor = () {
        dispatch(UpdateBlockThreeBackgroundColorAction());
      }
    ),
    pure: false, // [8]
  ),
])(castUiFactory(_$ReduxBigBlock)); // ignore: undefined_identifier

mixin ReduxBigBlockPropsMixin on UiProps {
  String backgroundColor; // [1]
  String blockTwoBackgroundColor; // [1]
  String blockThreeBackgroundColor; // [1]
  String blockOneBackgroundColor; // [1]

  void Function() changeMainBackgroundColor; // [2]
  void Function() changeBlockOneBackgroundColor; // [2]
  void Function() changeBlockTwoBackgroundColor; // [2]
  void Function() changeBlockThreeBackgroundColor; // [2]
}

class ReduxBigBlockProps = UiProps with ReduxBigBlockPropsMixin, ConnectPropsMixin;

class ReduxBigBlockComponent extends UiComponent2<ReduxBigBlockProps> {
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
        Dom.div()('This module uses a Redux pattern to change its background color.'),
        (Dom.div()
          ..style = {
            'display': 'flex',
            'flexDirection': 'column',
          }
        )(
          (Dom.button()
            ..onClick = (_) {
              props.changeMainBackgroundColor(); // [3]
            }
            ..style = {'padding': '10px', 'margin': '10px'}
          )('Change Main Background Color'),
          (Dom.button()
            ..onClick = (_) {
              props.changeBlockOneBackgroundColor(); // [3]
            }
            ..style = {'padding': '10px', 'margin': '10px'}
          )('Change Block 1 Background Color'),
          (Dom.button()
            ..onClick = (_) {
              props.changeBlockTwoBackgroundColor(); // [3]
            }
            ..style = {'padding': '10px', 'margin': '10px'}
          )('Change Block 2 Background Color'),
          (Dom.button()
            ..onClick = (_) {
              props.changeBlockThreeBackgroundColor(); // [3]
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
