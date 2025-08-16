// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators, invalid_use_of_visible_for_overriding_member
part of 'flawed_component_on_mount.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $FlawedOnMountComponentFactory = registerComponent2(
  () => _$FlawedOnMountComponent(),
  builderFactory: _$FlawedOnMount,
  componentClass: FlawedOnMountComponent,
  isWrapper: false,
  parentType: null,
);

abstract class _$FlawedOnMountPropsAccessorsMixin
    implements _$FlawedOnMountProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

const PropsMeta _$metaForFlawedOnMountProps = PropsMeta(
  fields: _$FlawedOnMountPropsAccessorsMixin.$props,
  keys: _$FlawedOnMountPropsAccessorsMixin.$propKeys,
);

_$$FlawedOnMountProps _$FlawedOnMount([Map? backingProps]) =>
    _$$FlawedOnMountProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$FlawedOnMountProps extends _$FlawedOnMountProps
    with _$FlawedOnMountPropsAccessorsMixin
    implements FlawedOnMountProps {
  _$$FlawedOnMountProps([Map? backingMap])
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
      super.componentFactory ?? $FlawedOnMountComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'FlawedOnMountProps.';

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$FlawedOnMountProps(
          accessMap, (map) => _$$FlawedOnMountProps(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$FlawedOnMountProps = getPropKey;

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$FlawedOnMountComponent extends FlawedOnMountComponent {
  late _$$FlawedOnMountProps _cachedTypedProps;

  @override
  _$$FlawedOnMountProps get props => _cachedTypedProps;

  @override
  set props(Map value) {
    assert(
        getBackingMap(value) is JsBackedMap,
        'Component2.props should never be set directly in '
        'production. If this is required for testing, the '
        'component should be rendered within the test. If '
        'that does not have the necessary result, the last '
        'resort is to use typedPropsFactoryJs.');
    super.props = value;
    _cachedTypedProps =
        typedPropsFactoryJs(getBackingMap(value) as JsBackedMap);
  }

  @override
  _$$FlawedOnMountProps typedPropsFactoryJs(JsBackedMap? backingMap) =>
      _$$FlawedOnMountProps(backingMap);

  @override
  _$$FlawedOnMountProps typedPropsFactory(Map? backingMap) =>
      _$$FlawedOnMountProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  @override
  String get displayName => 'FlawedOnMount';

  /// The default consumed props, taken from _$FlawedOnMountProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForFlawedOnMountProps
  ];
}
