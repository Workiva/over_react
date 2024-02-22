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

part 'nullability.over_react.g.dart';


UiFactory<NullabilityProps> Nullability = castUiFactory(_$Nullability); // ignore: undefined_identifier

mixin NullabilityPropsMixin on UiProps {
  dynamic dynamicProp;
  String nullable;
   String nonNullable;
}

class NullabilityProps = UiProps with NullabilityPropsMixin;

class NullabilityComponent extends UiComponent2<NullabilityProps> {
  @override
  render() {
    return Dom.div()('Non-nullable component', Dom.br()(), prettyPrintMap({
      'props.dynamicProp': props.dynamicProp,
      'props.nullable': props.nullable,
      'props.nonNullable': props.nonNullable,
    }));
  }
}

renderNullability() => (Nullability()
  ..nonNullable = 'nonNullable'
)();

