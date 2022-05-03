// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
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
  displayName: 'FluxCounter',
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

_$$FluxCounterProps _$FluxCounter([Map backingProps]) =>
    _$$FluxCounterProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$FluxCounterProps extends _$FluxCounterProps
    with _$FluxCounterPropsAccessorsMixin
    implements FluxCounterProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$FluxCounterProps(Map backingMap) : this.props = backingMap ?? ({});

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
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$FluxCounterComponent extends FluxCounterComponent {
  _$$FluxCounterProps _cachedTypedProps;

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
  _$$FluxCounterProps typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$FluxCounterProps(backingMap);

  @override
  _$$FluxCounterProps typedPropsFactory(Map backingMap) =>
      _$$FluxCounterProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$FluxCounterProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForFluxCounterProps
  ];
}
