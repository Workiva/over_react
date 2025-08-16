// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators, invalid_use_of_visible_for_overriding_member
part of 'subsubtype_of_component1.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TestSubsubtypeOfComponent1ComponentFactory = registerComponent2(
  () => _$TestSubsubtypeOfComponent1Component(),
  builderFactory: _$TestSubsubtypeOfComponent1,
  componentClass: TestSubsubtypeOfComponent1Component,
  isWrapper: false,
  parentType:
      $TestSubtypeOfComponent1ComponentFactory, /* from `subtypeOf: TestSubtypeOfComponent1Component` */
);

abstract class _$TestSubsubtypeOfComponent1PropsAccessorsMixin
    implements _$TestSubsubtypeOfComponent1Props {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

const PropsMeta _$metaForTestSubsubtypeOfComponent1Props = PropsMeta(
  fields: _$TestSubsubtypeOfComponent1PropsAccessorsMixin.$props,
  keys: _$TestSubsubtypeOfComponent1PropsAccessorsMixin.$propKeys,
);

class TestSubsubtypeOfComponent1Props extends _$TestSubsubtypeOfComponent1Props
    with _$TestSubsubtypeOfComponent1PropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTestSubsubtypeOfComponent1Props;
}

_$$TestSubsubtypeOfComponent1Props _$TestSubsubtypeOfComponent1(
        [Map? backingProps]) =>
    _$$TestSubsubtypeOfComponent1Props(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$TestSubsubtypeOfComponent1Props
    extends _$TestSubsubtypeOfComponent1Props
    with _$TestSubsubtypeOfComponent1PropsAccessorsMixin
    implements TestSubsubtypeOfComponent1Props {
  _$$TestSubsubtypeOfComponent1Props([Map? backingMap])
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
      super.componentFactory ?? $TestSubsubtypeOfComponent1ComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TestSubsubtypeOfComponent1Props.';

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$TestSubsubtypeOfComponent1Props(
          accessMap, (map) => _$$TestSubsubtypeOfComponent1Props(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$TestSubsubtypeOfComponent1Props = getPropKey;

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$TestSubsubtypeOfComponent1Component
    extends TestSubsubtypeOfComponent1Component {
  late _$$TestSubsubtypeOfComponent1Props _cachedTypedProps;

  @override
  _$$TestSubsubtypeOfComponent1Props get props => _cachedTypedProps;

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
  _$$TestSubsubtypeOfComponent1Props typedPropsFactoryJs(
          JsBackedMap? backingMap) =>
      _$$TestSubsubtypeOfComponent1Props(backingMap);

  @override
  _$$TestSubsubtypeOfComponent1Props typedPropsFactory(Map? backingMap) =>
      _$$TestSubsubtypeOfComponent1Props(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  @override
  String get displayName => 'TestSubsubtypeOfComponent1';

  /// The default consumed props, taken from _$TestSubsubtypeOfComponent1Props.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForTestSubsubtypeOfComponent1Props
  ];
}
