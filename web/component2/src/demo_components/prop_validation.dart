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

part 'prop_validation.over_react.g.dart';

UiFactory<PropTypesTestProps> PropTypesTest = castUiFactory(_$PropTypesTest); // ignore: undefined_identifier

mixin PropTypesTestProps on UiProps {
  int? count;
  List? twoObjects;
  int? defaultCount;
  bool? content;

  bool? hideHeader;
  dynamic header;

  List? initiallyExpandedKeys;
  dynamic targetKey;

  bool? hideLabel;
  String? label;
}

class PropTypesTestComponent extends UiComponent2<PropTypesTestProps> {
  @override
  render() =>
      Fragment()(Dom.code()('props.twoObjects'), ' currently has ${props.twoObjects!.length} objects passed to it.');

  // One variation of what the API could look like.
  //
  // This is closer to what it looks like in JS, but might be confusing syntax.
  @override
  get propTypes => {
        keyForProp((p) => p.twoObjects): (props, info) {
          final length = props.twoObjects?.length;
          if (length != 2) {
            return PropError.value(length, info.propName, 'must have a length of 2');
          }
          return null;
        },
      };
}
