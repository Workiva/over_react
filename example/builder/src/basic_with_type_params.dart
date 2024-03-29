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

part 'basic_with_type_params.over_react.g.dart';

UiFactory<BasicPropsMixin> Basic = castUiFactory(_$Basic); // ignore: undefined_identifier

mixin BasicPropsMixin<T, U extends UiProps> on UiProps {
  List<T>? someGenericListProp;
  U? somePropsClass;
}

class BasicProps<T, U extends UiProps> = UiProps with BasicPropsMixin<T, U>;

class BasicComponent extends UiComponent2<BasicProps> {
  @override
  get defaultProps => newProps()..id = 'basic component';

  @override
  render() {
    return Dom.div()(
        Dom.div()('prop id: ${props.id}'),
    );
  }
}
