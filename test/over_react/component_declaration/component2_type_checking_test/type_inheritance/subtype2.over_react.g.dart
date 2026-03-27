// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators, invalid_use_of_visible_for_overriding_member
part of 'subtype2.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TestSubtype2ComponentFactory = registerComponent2(
  () => _$TestSubtype2Component(),
  builderFactory: _$TestSubtype2,
  componentClass: TestSubtype2Component,
  isWrapper: false,
  parentType:
      $TestParent2ComponentFactory, /* from `subtypeOf: TestParent2Component` */
);

mixin _$TestSubtype2PropsAccessorsMixin implements _$TestSubtype2Props {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

const PropsMeta _$metaForTestSubtype2Props = PropsMeta(
  fields: _$TestSubtype2PropsAccessorsMixin.$props,
  keys: _$TestSubtype2PropsAccessorsMixin.$propKeys,
);

class TestSubtype2Props extends _$TestSubtype2Props
    with _$TestSubtype2PropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTestSubtype2Props;
}

_$$TestSubtype2Props _$TestSubtype2([Map? backingProps]) =>
    _$$TestSubtype2Props(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$TestSubtype2Props extends _$TestSubtype2Props
    with _$TestSubtype2PropsAccessorsMixin
    implements TestSubtype2Props {
  _$$TestSubtype2Props([Map? backingMap])
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
      super.componentFactory ?? $TestSubtype2ComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TestSubtype2Props.';

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$TestSubtype2Props(
          accessMap, (map) => _$$TestSubtype2Props(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$TestSubtype2Props = getPropKey;

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$TestSubtype2Component extends TestSubtype2Component {
  late _$$TestSubtype2Props _cachedTypedProps;

  @override
  _$$TestSubtype2Props get props => _cachedTypedProps;

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
  _$$TestSubtype2Props typedPropsFactoryJs(JsBackedMap? backingMap) =>
      _$$TestSubtype2Props(backingMap);

  @override
  _$$TestSubtype2Props typedPropsFactory(Map? backingMap) =>
      _$$TestSubtype2Props(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  @override
  String get displayName => 'TestSubtype2';

  /// The default consumed props, taken from _$TestSubtype2Props.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForTestSubtype2Props
  ];
}
