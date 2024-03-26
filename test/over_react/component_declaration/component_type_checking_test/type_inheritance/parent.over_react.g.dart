// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators, invalid_use_of_visible_for_overriding_member
part of 'parent.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TestParentComponentFactory = registerComponent(
  () => _$TestParentComponent(),
  builderFactory: _$TestParent,
  componentClass: TestParentComponent,
  isWrapper: false,
  parentType: null,
);

abstract class _$TestParentPropsAccessorsMixin implements _$TestParentProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

const PropsMeta _$metaForTestParentProps = PropsMeta(
  fields: _$TestParentPropsAccessorsMixin.$props,
  keys: _$TestParentPropsAccessorsMixin.$propKeys,
);

class TestParentProps extends _$TestParentProps
    with _$TestParentPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTestParentProps;
}

_$$TestParentProps _$TestParent([Map? backingProps]) =>
    _$$TestParentProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$TestParentProps extends _$TestParentProps
    with _$TestParentPropsAccessorsMixin
    implements TestParentProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TestParentProps(Map? backingMap) : this._props = {} {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $TestParentComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TestParentProps.';

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$TestParentProps(
          accessMap, (map) => _$$TestParentProps(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$TestParentProps = getPropKey;

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$TestParentComponent extends TestParentComponent {
  @override
  _$$TestParentProps typedPropsFactory(Map? backingMap) =>
      _$$TestParentProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  @override
  String get displayName => 'TestParent';

  /// The default consumed props, taken from _$TestParentProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForTestParentProps
  ];
}
