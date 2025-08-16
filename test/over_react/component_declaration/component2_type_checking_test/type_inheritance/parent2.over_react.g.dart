// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators, invalid_use_of_visible_for_overriding_member
part of 'parent2.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TestParent2ComponentFactory = registerComponent2(
  () => _$TestParent2Component(),
  builderFactory: _$TestParent2,
  componentClass: TestParent2Component,
  isWrapper: false,
  parentType: null,
);

abstract class _$TestParent2PropsAccessorsMixin implements _$TestParent2Props {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

const PropsMeta _$metaForTestParent2Props = PropsMeta(
  fields: _$TestParent2PropsAccessorsMixin.$props,
  keys: _$TestParent2PropsAccessorsMixin.$propKeys,
);

class TestParent2Props extends _$TestParent2Props
    with _$TestParent2PropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTestParent2Props;
}

_$$TestParent2Props _$TestParent2([Map? backingProps]) =>
    _$$TestParent2Props(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$TestParent2Props extends _$TestParent2Props
    with _$TestParent2PropsAccessorsMixin
    implements TestParent2Props {
  _$$TestParent2Props([Map? backingMap])
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
      super.componentFactory ?? $TestParent2ComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TestParent2Props.';

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$TestParent2Props(
          accessMap, (map) => _$$TestParent2Props(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$TestParent2Props = getPropKey;

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$TestParent2Component extends TestParent2Component {
  late _$$TestParent2Props _cachedTypedProps;

  @override
  _$$TestParent2Props get props => _cachedTypedProps;

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
  _$$TestParent2Props typedPropsFactoryJs(JsBackedMap? backingMap) =>
      _$$TestParent2Props(backingMap);

  @override
  _$$TestParent2Props typedPropsFactory(Map? backingMap) =>
      _$$TestParent2Props(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  @override
  String get displayName => 'TestParent2';

  /// The default consumed props, taken from _$TestParent2Props.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForTestParent2Props
  ];
}
