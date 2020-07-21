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

part 'basic.over_react.g.dart';

UiFactory<BasicProps> Basic = _$Basic; // ignore: undefined_identifier

mixin BasicProps on UiProps {
  @Deprecated('This is deprecated')
  @requiredProp
  String basicProp;

  String basic1;
  String basic2;
  String basic3;
  String basic4;
  String basic5;
}

class BasicComponent extends UiComponent2<BasicProps> {
  @override
  get defaultProps => newProps()..id = 'basic component'
      ..basicProp = 'defaultBasicProps'; // ignore: deprecated_member_use_from_same_package

  @override
  render() {
    return Dom.div()(
        Dom.div()('prop id: ${props.id}'),
        Dom.div()('default prop testing: ${props.basicProp}'), // ignore: deprecated_member_use_from_same_package
        Dom.div()('default prop testing: ${props.basic1}'),
        Dom.div()(null, props.basic4, 'children: ${props.children}' ),
    );
  }
}


