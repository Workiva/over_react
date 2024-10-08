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

import 'package:meta/meta.dart';
import 'package:over_react/over_react.dart';
import 'package:over_react/src/component_declaration/util.dart';

const _getPropKey = getPropKey;

/// A `MapView` helper that stubs in unimplemented pieces of [UiProps].
///
/// Useful when you need a `MapView` for a `PropsMixin` that implements [UiProps].
///
/// DEPRECATED: Use new boilerplate mixin pattern instead (see the New Boilerplate Migration
/// Guide for more information).
@Deprecated('This pattern is deprecated in favor of the mixin props mixin pattern. See the New Boilerplate Migration guide for more information.')
abstract class UiPropsMapView extends UiProps {
  /// Create a new instance backed by the specified map.
  UiPropsMapView(this.props);

  /// The backing props map proxied by this class.
  @override
  final Map props;

  /// Returns a new instance of the current class backed by the given [props].
  ///
  /// This exists to implement [$getPropKey], and must be overridden by consumers.
  ///
  /// Example override:
  /// ```dart
  /// class OverlayPropsMixinMapView extends UiPropsMapView
  ///     with
  ///         OverlayPropsMixin,
  ///         // ignore: mixin_of_non_class, undefined_class
  ///         $OverlayPropsMixin {
  ///   OverlayPropsMixinMapView(Map map) : super(map);
  ///
  ///   @override
  ///   OverlayPropsMixinMapView selfFactory(Map map) => OverlayPropsMixinMapView(this);
  /// }
  /// ```
  @visibleForOverriding
  UiProps selfFactory(Map props);

  // ----- builder_helpers.UiProps ----- //

  @override
  bool get $isClassGenerated => true;

  @override
  PropsMetaCollection get staticMeta => throw UnimplementedError('@PropsMixin instances do not implement instance meta');

  @override
  String get propKeyNamespace =>
      throw UnimplementedError('@PropsMixin instances do not implement propKeyNamespace');

  @override
  String $getPropKey(void Function(Map m) accessMap) => _getPropKey(accessMap, selfFactory);

  // ----- component_base.UiProps ----- //

  @override
  void addProp(propKey, value, [bool shouldAdd = true]) =>
      throw UnimplementedError('@PropsMixin instances do not implement addProp');

  @override
  void addProps(Map? propMap, [bool shouldAdd = true]) =>
      throw UnimplementedError('@PropsMixin instances do not implement addProps');

  @override
  void modifyProps(PropsModifier? modifier, [bool shouldModify = true]) =>
      throw UnimplementedError('@PropsMixin instances do not implement modifyProps');

  @override
  void addUnconsumedProps(Map props, Iterable<PropsMeta> consumedProps) =>
      throw UnimplementedError('@PropsMixin instances do not implement addUnconsumedProps');

  @override
  void addUnconsumedDomProps(Map props, Iterable<PropsMeta> consumedProps) =>
      throw UnimplementedError('@PropsMixin instances do not implement addUnconsumedDomProps');

  @override
  void addTestId(String? value, {String key = defaultTestIdKey}) =>
      throw UnimplementedError('@PropsMixin instances do not implement addTestId');

  @override
  String getTestId({String key = defaultTestIdKey}) =>
      throw UnimplementedError('@PropsMixin instances do not implement getTestId');

  @override
  String get testId => getTestId();

  @override
  Map get componentDefaultProps => throw UnimplementedError('@PropsMixin instances do not implement defaultProps');

  @override
  ReactElement build([ReactNode children]) =>
      throw UnimplementedError('@PropsMixin instances do not implement build');

  @override
  ReactComponentFactoryProxy get componentFactory =>
      throw UnimplementedError('@PropsMixin instances do not implement componentFactory');

  @override
  set componentFactory(ReactComponentFactoryProxy? v) => throw UnimplementedError('@PropsMixin instances do not implement componentFactory');

  @override
  ReactElement call([c1 = notSpecified, c2 = notSpecified, c3 = notSpecified, c4 = notSpecified, c5 = notSpecified, c6 = notSpecified, c7 = notSpecified, c8 = notSpecified, c9 = notSpecified, c10 = notSpecified, c11 = notSpecified, c12 = notSpecified, c13 = notSpecified, c14 = notSpecified, c15 = notSpecified, c16 = notSpecified, c17 = notSpecified, c18 = notSpecified, c19 = notSpecified, c20 = notSpecified, c21 = notSpecified, c22 = notSpecified, c23 = notSpecified, c24 = notSpecified, c25 = notSpecified, c26 = notSpecified, c27 = notSpecified, c28 = notSpecified, c29 = notSpecified, c30 = notSpecified, c31 = notSpecified, c32 = notSpecified, c33 = notSpecified, c34 = notSpecified, c35 = notSpecified, c36 = notSpecified, c37 = notSpecified, c38 = notSpecified, c39 = notSpecified, c40 = notSpecified]) => throw UnimplementedError('@PropsMixin instances do not implement call');

  @override
  // ignore: must_call_super
  void validateRequiredProps() => throw UnimplementedError('@PropsMixin instances do not implement validateRequiredProps');

  @override
  void disableRequiredPropValidation() =>
      throw UnimplementedError('@PropsMixin instances do not implement disableRequiredPropValidation');

  @override
  Set<String> get requiredPropNamesToSkipValidation => throw UnimplementedError('@PropsMixin instances do not implement requiredPropNamesToSkipValidation');
}
