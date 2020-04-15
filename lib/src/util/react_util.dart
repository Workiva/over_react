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

import 'dart:collection';

import 'package:over_react/component_base.dart' as component_base show UiProps;
import 'package:over_react/over_react.dart';
import 'package:over_react/src/component_declaration/util.dart';
import 'package:react/react_client.dart';

/// A `MapView` helper that stubs in unimplemented pieces of [UiProps].
///
/// Useful when you need a `MapView` for a [PropsMixin] that implements [UiProps].
class UiPropsMapView extends MapView
    with
        ReactPropsMixin,
        UbiquitousDomPropsMixin,
        CssClassPropsMixin
    implements
        component_base.UiProps {
  /// Create a new instance backed by the specified map.
  UiPropsMapView(Map map) : super(map);

  /// The props to be manipulated via the getters/setters.
  /// In this case, it's the current MapView object.
  @override
  Map get props => this;

  bool get $isClassGenerated =>
      throw UnimplementedError('@PropsMixin instances do not implement \$isClassGenerated');

  String get propKeyNamespace =>
      throw UnimplementedError('@PropsMixin instances do not implement propKeyNamespace');

  // ----- component_base.UiProps ----- //

  @override
  void addProp(propKey, value, [bool shouldAdd = true]) =>
      throw UnimplementedError('@PropsMixin instances do not implement addProp');

  @override
  void addProps(Map propMap, [bool shouldAdd = true]) =>
      throw UnimplementedError('@PropsMixin instances do not implement addProps');

  @override
  void modifyProps(PropsModifier modifier, [bool shouldModify = true]) =>
      throw UnimplementedError('@PropsMixin instances do not implement modifyProps');

  @override
  void addTestId(String value, {String key = defaultTestIdKey}) =>
      throw UnimplementedError('@PropsMixin instances do not implement addTestId');

  @override
  String getTestId({String key = defaultTestIdKey}) =>
      throw UnimplementedError('@PropsMixin instances do not implement getTestId');

  @override
  String get testId => getTestId();

  @override
  Map get componentDefaultProps => throw UnimplementedError('@PropsMixin instances do not implement defaultProps');

  @override
  ReactElement build([dynamic children]) =>
      throw UnimplementedError('@PropsMixin instances do not implement build');

  @override
  ReactComponentFactoryProxy get componentFactory =>
      throw UnimplementedError('@PropsMixin instances do not implement componentFactory');

  @override
  set componentFactory(ReactComponentFactoryProxy v) => throw UnimplementedError('@PropsMixin instances do not implement componentFactory');

  @override
  ReactElement call([c1 = notSpecified, c2 = notSpecified, c3 = notSpecified, c4 = notSpecified, c5 = notSpecified, c6 = notSpecified, c7 = notSpecified, c8 = notSpecified, c9 = notSpecified, c10 = notSpecified, c11 = notSpecified, c12 = notSpecified, c13 = notSpecified, c14 = notSpecified, c15 = notSpecified, c16 = notSpecified, c17 = notSpecified, c18 = notSpecified, c19 = notSpecified, c20 = notSpecified, c21 = notSpecified, c22 = notSpecified, c23 = notSpecified, c24 = notSpecified, c25 = notSpecified, c26 = notSpecified, c27 = notSpecified, c28 = notSpecified, c29 = notSpecified, c30 = notSpecified, c31 = notSpecified, c32 = notSpecified, c33 = notSpecified, c34 = notSpecified, c35 = notSpecified, c36 = notSpecified, c37 = notSpecified, c38 = notSpecified, c39 = notSpecified, c40 = notSpecified]) => throw UnimplementedError('@PropsMixin instances do not implement call');
}
