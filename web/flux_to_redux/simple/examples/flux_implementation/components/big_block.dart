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

part 'big_block.over_react.g.dart';

UiFactory<BigBlockProps> BigBlock = castUiFactory(_$BigBlock); // ignore: undefined_identifier

class BigBlockProps = UiProps with FluxUiPropsMixin<RandomColorActions, RandomColorStore>;

class BigBlockComponent extends FluxUiComponent2<BigBlockProps> {
  @override
  render() {
    return (Fragment()(
      (Dom.div()..style = {'padding': '50px', 'backgroundColor': props.store.backgroundColor, 'color': 'white'})(
        'This module uses a flux pattern to change its background color.',
        (Dom.button()
          ..onClick = (_) {
            props.actions.changeBackgroundColor();
          }
          ..style = {'padding': '10px', 'margin': '10px'}
        )('Change Background Color'),
      ),
    ));
  }
}
