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

import '../context.dart';

part 'my_context_component.over_react.g.dart';

UiFactory<MyContextComponentProps> MyContext =
    castUiFactory(_$MyContext); // ignore: undefined_identifier

mixin MyContextComponentProps on UiProps {}

class MyContextComponentComponent extends UiComponent2<MyContextComponentProps> {
  @override
  get contextType => someContext.reactDartContext;

  @override
  render() {
    return Dom.div()('${this.context}');
  }
}
