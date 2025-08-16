// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators, invalid_use_of_visible_for_overriding_member
part of 'flux_counter.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $FluxCounterComponentFactory = registerComponent2(
  () => _$FluxCounterComponent(),
  builderFactory: _$FluxCounter,
  componentClass: FluxCounterComponent,
  isWrapper: false,
  parentType: null,
);

abstract class _$FluxCounterPropsAccessorsMixin implements _$FluxCounterProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

const PropsMeta _$metaForFluxCounterProps = PropsMeta(
  fields: _$FluxCounterPropsAccessorsMixin.$props,
  keys: _$FluxCounterPropsAccessorsMixin.$propKeys,
);

class FluxCounterProps extends _$FluxCounterProps
    with _$FluxCounterPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForFluxCounterProps;
}

_$$FluxCounterProps _$FluxCounter([Map? backingProps]) =>
    _$$FluxCounterProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$FluxCounterProps extends _$FluxCounterProps
    with _$FluxCounterPropsAccessorsMixin
    implements FluxCounterProps {
  _$$FluxCounterProps([Map? backingMap])
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
      super.componentFactory ?? $FluxCounterComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'FluxCounterProps.';

  @override
  String $getPropKey(void Function(Map m) accessMap) =>
      _$getPropKey$_$$FluxCounterProps(
          accessMap, (map) => _$$FluxCounterProps(map));
}

/// An alias for [getPropKey] so it can be referenced within the props class impl
/// without being shadowed by the `getPropKey` instance extension member.
const _$getPropKey$_$$FluxCounterProps = getPropKey;

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$FluxCounterComponent extends FluxCounterComponent {
  late _$$FluxCounterProps _cachedTypedProps;

  @override
  _$$FluxCounterProps get props => _cachedTypedProps;

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
  _$$FluxCounterProps typedPropsFactoryJs(JsBackedMap? backingMap) =>
      _$$FluxCounterProps(backingMap);

  @override
  _$$FluxCounterProps typedPropsFactory(Map? backingMap) =>
      _$$FluxCounterProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  @override
  String get displayName => 'FluxCounter';

  /// The default consumed props, taken from _$FluxCounterProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForFluxCounterProps
  ];
}
