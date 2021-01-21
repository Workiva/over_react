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

import 'prop_validation.dart';
import 'button.dart';

part 'prop_validation_wrap.over_react.g.dart';

UiFactory<PropTypesWrapProps> PropTypesWrap = castUiFactory(_$PropTypesWrap);

mixin PropTypesWrapProps on UiProps {}

mixin PropTypesWrapState on UiState {
  List twoObjects;
}

class PropTypesWrapComponent extends UiStatefulComponent2<PropTypesWrapProps, PropTypesWrapState> {
  @override
   get initialState => (newState()..twoObjects = [1,2]
);

  @override
  render() {

    return Fragment()(
      (PropTypesTest()..twoObjects = this.state.twoObjects)(),
      (Button()..onClick = (_){
          this.setState(newState()..twoObjects = []);
        }
      )('Click me to pass in an invalid prop'),
    );
  }
}
