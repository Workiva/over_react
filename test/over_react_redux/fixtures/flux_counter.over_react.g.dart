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
  builderFactory: FluxCounter,
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

_$$FluxCounterProps _$FluxCounter([Map backingProps]) => backingProps == null
    ? _$$FluxCounterProps$JsMap(JsBackedMap())
    : _$$FluxCounterProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$FluxCounterProps extends _$FluxCounterProps
    with _$FluxCounterPropsAccessorsMixin
    implements FluxCounterProps {
  _$$FluxCounterProps._();

  factory _$$FluxCounterProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$FluxCounterProps$JsMap(backingMap);
    } else {
      return _$$FluxCounterProps$PlainMap(backingMap);
    }
  }

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

// Concrete props implementation that can be backed by any [Map].
class _$$FluxCounterProps$PlainMap extends _$$FluxCounterProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$FluxCounterProps$PlainMap(Map backingMap)
      : this._props = {},
        super._() {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;
}

// Concrete props implementation that can only be backed by [JsMap],
// allowing dart2js to compile more optimal code for key-value pair reads/writes.
class _$$FluxCounterProps$JsMap extends _$$FluxCounterProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$FluxCounterProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$FluxCounterComponent extends FluxCounterComponent {
  _$$FluxCounterProps$JsMap _cachedTypedProps;

  @override
  _$$FluxCounterProps$JsMap get props => _cachedTypedProps;

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
    _cachedTypedProps = typedPropsFactoryJs(getBackingMap(value));
  }

  @override
  _$$FluxCounterProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$FluxCounterProps$JsMap(backingMap);

  @override
  _$$FluxCounterProps typedPropsFactory(Map backingMap) =>
      _$$FluxCounterProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$FluxCounterProps.
  /// Used in `ConsumedProps` if [consumedProps] is not overridden.
  @override
  List<ConsumedProps> get $defaultConsumedProps =>
      const [_$metaForFluxCounterProps];
}
