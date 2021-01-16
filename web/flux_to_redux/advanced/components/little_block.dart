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

part 'little_block.over_react.g.dart';

UiFactory<LittleBlockProps> LittleBlock = castUiFactory(_$LittleBlock);

mixin LittleBlockProps on UiProps {
  String backgroundColor;

  String colorString;

  String blockTitle;
}

class LittleBlockComponent extends UiComponent2<LittleBlockProps> {
  @override
  render() {
    return ((Dom.div()
      ..style = {
        'padding': '50px',
        'backgroundColor': props.backgroundColor,
        'color': 'white',
        'display': 'flex',
        'flexDirection': 'column',
        'justifyContent': 'space-evently'
      }
    )(
      Dom.div()(props.blockTitle),
      Dom.div()('The color is ${props.colorString}'),
    ));
  }
}
