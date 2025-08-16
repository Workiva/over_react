// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators, invalid_use_of_visible_for_overriding_member
part of 'one_level_wrapper2.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $OneLevelWrapper2ComponentFactory = registerComponent2(
  () => _$OneLevelWrapper2Component(),
  builderFactory: _$OneLevelWrapper2,
  componentClass: OneLevelWrapper2Component,
  isWrapper: true,
  parentType: null,
);

abstract class _$OneLevelWrapper2PropsAccessorsMixin
    implements _$OneLevelWrapper2Props {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

const PropsMeta _$metaForOneLevelWrapper2Props = PropsMeta(
  fields: _$OneLevelWrapper2PropsAccessorsMixin.$props,
  keys: _$OneLevelWrapper2PropsAccessorsMixin.$propKeys,
);

class OneLevelWrapper2Props extends _$OneLevelWrapper2Props
    with _$OneLevelWrapper2PropsAccessorsMixin {
  static const PropsMeta meta = _$metaForOneLevelWrapper2Props;
}

_$$OneLevelWrapper2Props _$OneLevelWrapper2([Map? backingProps]) =>
    _$$OneLevelWrapper2Props(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$OneLevelWrapper2Props extends _$OneLevelWrapper2Props
    with _$OneLevelWrapper2PropsAccessorsMixin
    implements OneLevelWrapper2Props {
  _$$OneLevelWrapper2Props([Map? backingMap])
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
      super.componentFactory ?? $OneLevelWrapper2ComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'OneLevelWrapper2Props.';

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$OneLevelWrapper2Props(
          accessMap, (map) => _$$OneLevelWrapper2Props(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$OneLevelWrapper2Props = getPropKey;

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$OneLevelWrapper2Component extends OneLevelWrapper2Component {
  late _$$OneLevelWrapper2Props _cachedTypedProps;

  @override
  _$$OneLevelWrapper2Props get props => _cachedTypedProps;

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
  _$$OneLevelWrapper2Props typedPropsFactoryJs(JsBackedMap? backingMap) =>
      _$$OneLevelWrapper2Props(backingMap);

  @override
  _$$OneLevelWrapper2Props typedPropsFactory(Map? backingMap) =>
      _$$OneLevelWrapper2Props(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  @override
  String get displayName => 'OneLevelWrapper2';

  /// The default consumed props, taken from _$OneLevelWrapper2Props.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForOneLevelWrapper2Props
  ];
}
