import 'dart:collection';

import 'package:over_react/over_react.dart';
import 'package:over_react/component_base.dart' as component_base show UiProps;
import 'package:react/react_client.dart';

/// A `MapView` helper that stubs in unimplemented pieces of [UiProps].
///
/// Useful when you need a `MapView` for a [PropsMixin] that implements [UiProps].
class UiPropsMapView extends MapView with ReactPropsMixin, UbiquitousDomPropsMixin, CssClassPropsMixin
    implements component_base.UiProps {
  /// Create a new instance backed by the specified map.
  UiPropsMapView(Map map) : super(map);

  /// The props to be manipulated via the getters/setters.
  /// In this case, it's the current MapView object.
  @override
  Map get props => this;

  bool get $isClassGenerated =>
      throw new UnimplementedError('@PropsMixin instances do not implement \$isClassGenerated');

  String get propKeyNamespace => throw new UnimplementedError('@PropsMixin instances do not implement propKeyNamespace');

  // ----- component_base.UiProps ----- //

  @override
  void addProp(propKey, value, [bool shouldAdd = true]) =>
      throw new UnimplementedError('@PropsMixin instances do not implement addProp');

  @override
  void addProps(Map propMap, [bool shouldAdd = true]) =>
      throw new UnimplementedError('@PropsMixin instances do not implement addProps');

  @override
  void modifyProps(PropsModifier modifier, [bool shouldModify = true]) =>
      throw new UnimplementedError('@PropsMixin instances do not implement modifyProps');

  @override
  void addTestId(String value, {String key: defaultTestIdKey}) =>
      throw new UnimplementedError('@PropsMixin instances do not implement addTestId');

  @override
  String getTestId({String key: defaultTestIdKey}) =>
      throw new UnimplementedError('@PropsMixin instances do not implement getTestId');

  @override
  String get testId => getTestId();

  @override
  ReactElement build([dynamic children]) =>
      throw new UnimplementedError('@PropsMixin instances do not implement build');

  @override
  ReactComponentFactoryProxy get componentFactory =>
      throw new UnimplementedError('@PropsMixin instances do not implement componentFactory');

  @override
  ReactElement call([children, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, c17, c18, c19, c20, c21, c22, c23, c24, c25, c26, c27, c28, c29, c30, c31, c32, c33, c34, c35, c36, c37, c38, c39, c40]) => throw new UnimplementedError('@PropsMixin instances do not implement call');
}
