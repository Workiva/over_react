// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators, invalid_use_of_visible_for_overriding_member
part of 'two_level_wrapper.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TwoLevelWrapperComponentFactory = registerComponent(
  () => _$TwoLevelWrapperComponent(),
  builderFactory: _$TwoLevelWrapper,
  componentClass: TwoLevelWrapperComponent,
  isWrapper: true,
  parentType: null,
);

abstract class _$TwoLevelWrapperPropsAccessorsMixin
    implements _$TwoLevelWrapperProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

const PropsMeta _$metaForTwoLevelWrapperProps = PropsMeta(
  fields: _$TwoLevelWrapperPropsAccessorsMixin.$props,
  keys: _$TwoLevelWrapperPropsAccessorsMixin.$propKeys,
);

class TwoLevelWrapperProps extends _$TwoLevelWrapperProps
    with _$TwoLevelWrapperPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTwoLevelWrapperProps;
}

_$$TwoLevelWrapperProps _$TwoLevelWrapper([Map? backingProps]) =>
    _$$TwoLevelWrapperProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$TwoLevelWrapperProps extends _$TwoLevelWrapperProps
    with _$TwoLevelWrapperPropsAccessorsMixin
    implements TwoLevelWrapperProps {
  _$$TwoLevelWrapperProps([Map? backingMap])
      : this.props = backingMap ?? JsBackedMap();

  /// The backing props map proxied by this class.
  @override
  final Map props;

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $TwoLevelWrapperComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TwoLevelWrapperProps.';

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$TwoLevelWrapperProps(
          accessMap, (map) => _$$TwoLevelWrapperProps(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$TwoLevelWrapperProps = getPropKey;

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$TwoLevelWrapperComponent extends TwoLevelWrapperComponent {
  @override
  _$$TwoLevelWrapperProps typedPropsFactory(Map? backingMap) =>
      _$$TwoLevelWrapperProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  @override
  String get displayName => 'TwoLevelWrapper';

  /// The default consumed props, taken from _$TwoLevelWrapperProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForTwoLevelWrapperProps
  ];
}
