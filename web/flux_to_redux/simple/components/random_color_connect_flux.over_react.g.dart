// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'random_color_connect_flux.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $RandomColorConnectFluxComponentFactory = registerComponent2(
  () => _$RandomColorConnectFluxComponent(),
  builderFactory: RandomColorConnectFlux,
  componentClass: RandomColorConnectFluxComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'RandomColorConnectFlux',
);

abstract class _$RandomColorConnectFluxPropsAccessorsMixin
    implements _$RandomColorConnectFluxProps {
  @override
  Map get props;

  /// <!-- Generated from [_$RandomColorConnectFluxProps.backgroundColor] -->
  @override
  String get backgroundColor =>
      props[_$key__backgroundColor___$RandomColorConnectFluxProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$RandomColorConnectFluxProps.backgroundColor] -->
  @override
  set backgroundColor(String value) =>
      props[_$key__backgroundColor___$RandomColorConnectFluxProps] = value;

  /// <!-- Generated from [_$RandomColorConnectFluxProps.changeBackgroundColor] -->
  @override
  Function get changeBackgroundColor =>
      props[_$key__changeBackgroundColor___$RandomColorConnectFluxProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$RandomColorConnectFluxProps.changeBackgroundColor] -->
  @override
  set changeBackgroundColor(Function value) =>
      props[_$key__changeBackgroundColor___$RandomColorConnectFluxProps] =
          value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor
      _$prop__backgroundColor___$RandomColorConnectFluxProps =
      PropDescriptor(_$key__backgroundColor___$RandomColorConnectFluxProps);
  static const PropDescriptor
      _$prop__changeBackgroundColor___$RandomColorConnectFluxProps =
      PropDescriptor(
          _$key__changeBackgroundColor___$RandomColorConnectFluxProps);
  static const String _$key__backgroundColor___$RandomColorConnectFluxProps =
      'RandomColorConnectFluxProps.backgroundColor';
  static const String
      _$key__changeBackgroundColor___$RandomColorConnectFluxProps =
      'RandomColorConnectFluxProps.changeBackgroundColor';

  static const List<PropDescriptor> $props = [
    _$prop__backgroundColor___$RandomColorConnectFluxProps,
    _$prop__changeBackgroundColor___$RandomColorConnectFluxProps
  ];
  static const List<String> $propKeys = [
    _$key__backgroundColor___$RandomColorConnectFluxProps,
    _$key__changeBackgroundColor___$RandomColorConnectFluxProps
  ];
}

const PropsMeta _$metaForRandomColorConnectFluxProps = PropsMeta(
  fields: _$RandomColorConnectFluxPropsAccessorsMixin.$props,
  keys: _$RandomColorConnectFluxPropsAccessorsMixin.$propKeys,
);

class RandomColorConnectFluxProps extends _$RandomColorConnectFluxProps
    with _$RandomColorConnectFluxPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForRandomColorConnectFluxProps;
}

_$$RandomColorConnectFluxProps _$RandomColorConnectFlux([Map backingProps]) =>
    backingProps == null
        ? _$$RandomColorConnectFluxProps$JsMap(JsBackedMap())
        : _$$RandomColorConnectFluxProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$RandomColorConnectFluxProps
    extends _$RandomColorConnectFluxProps
    with _$RandomColorConnectFluxPropsAccessorsMixin
    implements RandomColorConnectFluxProps {
  _$$RandomColorConnectFluxProps._();

  factory _$$RandomColorConnectFluxProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$RandomColorConnectFluxProps$JsMap(backingMap);
    } else {
      return _$$RandomColorConnectFluxProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $RandomColorConnectFluxComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'RandomColorConnectFluxProps.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$RandomColorConnectFluxProps$PlainMap
    extends _$$RandomColorConnectFluxProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$RandomColorConnectFluxProps$PlainMap(Map backingMap)
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
class _$$RandomColorConnectFluxProps$JsMap
    extends _$$RandomColorConnectFluxProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$RandomColorConnectFluxProps$JsMap(JsBackedMap backingMap)
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
class _$RandomColorConnectFluxComponent
    extends RandomColorConnectFluxComponent {
  _$$RandomColorConnectFluxProps$JsMap _cachedTypedProps;

  @override
  _$$RandomColorConnectFluxProps$JsMap get props => _cachedTypedProps;

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
  _$$RandomColorConnectFluxProps$JsMap typedPropsFactoryJs(
          JsBackedMap backingMap) =>
      _$$RandomColorConnectFluxProps$JsMap(backingMap);

  @override
  _$$RandomColorConnectFluxProps typedPropsFactory(Map backingMap) =>
      _$$RandomColorConnectFluxProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$RandomColorConnectFluxProps.
  /// Used in `ConsumedProps` if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForRandomColorConnectFluxProps
  ];
}
