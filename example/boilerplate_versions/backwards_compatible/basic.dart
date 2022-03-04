// Copyright 2021 Workiva Inc.
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

// ignore_for_file: deprecated_member_use_from_same_package

import 'package:over_react/over_react.dart';

part 'basic.over_react.g.dart';

@Factory()
// ignore: undefined_identifier, invalid_assignment
UiFactory<BasicProps> Basic = _$Basic;

// ignore: undefined_class, mixin_of_non_class
class BasicProps extends _$BasicProps with _$BasicPropsAccessorsMixin {
  // ignore: undefined_identifier, const_initialized_with_non_constant_value, invalid_assignment
  static const PropsMeta meta = _$metaForBasicProps;
}

@Props()
//// ignore: mixin_of_non_class,undefined_class
class _$BasicProps extends UiProps {
  @Deprecated('This is deprecated')
  @requiredProp
  String basicProp;

  String basic1;
  String basic2;
  String basic3;
  String basic4;
  String basic5;
}

@Component()
class BasicComponent extends UiComponent<BasicProps> {
  @override
  Map getDefaultProps() => newProps()
    ..id = 'basic component'
    ..basicProp = 'defaultBasicProps';

  @override
  render() {
    return Dom.div()(
      Dom.div()('prop id: ${props.id}'),
      Dom.div()('default prop testing: ${props.basicProp}'),
      Dom.div()('default prop testing: ${props.basic1}'),
      Dom.div()(null, props.basic4, 'children: ${props.children}'),
    );
  }
}
