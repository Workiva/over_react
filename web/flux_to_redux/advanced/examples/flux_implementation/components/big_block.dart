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

UiFactory<BigBlockProps> BigBlock = _$BigBlock;

mixin BigBlockPropsMixin on UiProps {
  AnotherColorStore store2;
}

class BigBlockProps = UiProps
    with FluxUiPropsMixin<RandomColorActions, RandomColorStore>, BigBlockPropsMixin;

class BigBlockComponent extends FluxUiComponent2<BigBlockProps> {
  @override
  redrawOn() => [
        props.store,
        props.store.midLevelStore,
        props.store.midLevelStore.lowLevelStore,
        props.store2,
      ];

  @override
  render() {
    return (Fragment()(
      (Dom.div()
        ..style = {
          'padding': '50px',
          'backgroundColor': props.store.backgroundColor,
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
              props.actions.changeMainBackgroundColor();
            }
            ..style = {'padding': '10px', 'margin': '10px'}
          )('Change Main Background Color'),
          (Dom.button()
            ..onClick = (_) {
              props.actions.changeBlockOneBackgroundColor();
            }
            ..style = {'padding': '10px', 'margin': '10px'}
          )('Change Block 1 Background Color'),
          (Dom.button()
            ..onClick = (_) {
              props.actions.changeBlockTwoBackgroundColor();
            }
            ..style = {'padding': '10px', 'margin': '10px'}
          )('Change Block 2 Background Color'),
          (Dom.button()
            ..onClick = (_) {
              props.actions.changeBlockThreeBackgroundColor();
            }
            ..style = {'padding': '10px', 'margin': '10px'}
          )('Change Block 3 Background Color'),
        ),
        (Dom.div()..style = {'display': 'flex', 'flexDirection': 'column'})(
          (LittleBlock()
            ..blockTitle = 'Block 1'
            ..backgroundColor = this.props.store.midLevelStore.backgroundColor
            ..colorString = this.props.store.midLevelStore.backgroundColor
          )(),
          (LittleBlock()
            ..blockTitle = 'Block 2'
            ..backgroundColor = this.props.store.midLevelStore.lowLevelStore.backgroundColor
            ..colorString = this.props.store.midLevelStore.lowLevelStore.backgroundColor
          )(),
          (LittleBlock()
            ..blockTitle = 'Block 3'
            ..backgroundColor = this.props.store2.backgroundColor
            ..colorString = this.props.store2.backgroundColor
          )(),
        ),
      ),
    ));
  }
}
