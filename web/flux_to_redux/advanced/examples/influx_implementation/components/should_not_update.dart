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

part 'should_not_update.over_react.g.dart';

UiFactory<ShouldNotUpdateProps> ShouldNotUpdate = composeHocs([
  connect<RandomColorStore, ShouldNotUpdateProps>(
    context: randomColorStoreContext,
    mapStateToProps: (_) => {},
    pure: false,
  ),
  connect<LowLevelStore, ShouldNotUpdateProps>(
    context: lowLevelStoreContext,
    mapStateToProps: (_) => {},
    pure: false,
  ),
  connect<AnotherColorStore, ShouldNotUpdateProps>(
    context: anotherColorStoreContext,
    mapStateToProps: (_) => {},
    pure: false,
  )
])(castUiFactory(_$ShouldNotUpdate)); // ignore: undefined_identifier

mixin ShouldNotUpdateProps on UiProps {}

class ShouldNotUpdateComponent extends UiComponent2<ShouldNotUpdateProps> {
  @override
  render() {
    return ((Dom.div()..style = {'padding': '50px', 'backgroundColor': 'gray', 'color': 'white'})(
      'In a full Redux implementation, this component would not redraw on '
      'unrelated store updates (such as when the background color changes).'
      'However, with an Influx implementation it will.',
    ));
  }
}
