// @dart=2.11
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

import '../store.dart';
import '../../../components/little_block.dart';

part 'big_block.over_react.g.dart';

UiFactory<BigBlockProps> BigBlock = castUiFactory(_$BigBlock); // ignore: undefined_identifier

@Props()
mixin BigBlockPropsMixin on UiProps {
   LowLevelStore lowLevelStore;

   AnotherColorStore secondStore;
}

class BigBlockProps = UiProps
    with FluxUiPropsMixin<RandomColorActions, RandomColorStore>, BigBlockPropsMixin;

class BigBlockComponent extends FluxUiComponent2<BigBlockProps> {
  @override
  redrawOn() => [
        props.store,
        props.lowLevelStore,
        props.secondStore,
      ];

  @override
  render() {
    return (Fragment()(
      (Dom.div()
        ..style = {
          'padding': '50px',
          'backgroundColor': props.store.state.mainBackgroundColor,
          'color': 'white',
          'display': 'flex',
          'alignItems': 'center',
          'justifyContent': 'space-evenly'
        }
      )(
        Dom.div()('This module uses a flux pattern to change its background color.'),
        (Dom.div()
          ..style = {
            'display': 'flex',
            'flexDirection': 'column',
          }
        )(
          (Dom.button()
            ..onClick = (_) {
              props.actions.changeMainBackgroundColor(props.store.blockOneBackgroundColor);
            }
            ..style = {'padding': '10px', 'margin': '10px'}
          )('Change Main Background Color'),
          (Dom.button()
            ..onClick = (_) {
              props.actions.changeBlockOneBackgroundColor(props.store.mainBackgroundColor);
            }
            ..style = {'padding': '10px', 'margin': '10px'}
          )('Change Block 1 Background Color'),
          (Dom.button()
            ..onClick = (_) {
              props.actions.changeBlockTwoBackgroundColor(props.store.mainBackgroundColor);
            }
            ..style = {'padding': '10px', 'margin': '10px'}
          )('Change Block 2 Background Color'),
          (Dom.button()
            ..onClick = (_) {
              props.actions.changeBlockThreeBackgroundColor(props.secondStore.backgroundColor);
            }
            ..style = {'padding': '10px', 'margin': '10px'}
          )('Change Block 3 Background Color'),
        ),
        (Dom.div()..style = {'display': 'flex', 'flexDirection': 'column'})(
          (LittleBlock()
            ..blockTitle = 'Block 1'
            ..backgroundColor = props.store.state.blockOneBackgroundColor
            ..colorString = props.store.state.blockOneBackgroundColor
          )(),
          (LittleBlock()
            ..blockTitle = 'Block 2'
            ..backgroundColor = props.lowLevelStore.state.backgroundColor
            ..colorString = props.lowLevelStore.state.backgroundColor
          )(),
          (LittleBlock()
            ..blockTitle = 'Block 3'
            ..backgroundColor = props.secondStore.state.backgroundColor
            ..colorString = props.secondStore.state.backgroundColor
          )(),
        ),
      ),
    ));
  }
}
