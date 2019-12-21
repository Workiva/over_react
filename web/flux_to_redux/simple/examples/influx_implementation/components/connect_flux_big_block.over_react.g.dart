// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'connect_flux_big_block.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $ConnectFluxBigBlockComponentFactory = registerComponent2(
  () => _$ConnectFluxBigBlockComponent(),
  builderFactory: ConnectFluxBigBlock,
  componentClass: ConnectFluxBigBlockComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'ConnectFluxBigBlock',
);

abstract class _$ConnectFluxBigBlockPropsAccessorsMixin implements _$ConnectFluxBigBlockProps {
  @override
  Map get props;

  /// <!-- Generated from [_$ConnectFluxBigBlockProps.backgroundColor] -->
  @override
  String get backgroundColor =>
      props[_$key__backgroundColor___$ConnectFluxBigBlockProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$ConnectFluxBigBlockProps.backgroundColor] -->
  @override
  set backgroundColor(String value) => props[_$key__backgroundColor___$ConnectFluxBigBlockProps] = value;

  /// <!-- Generated from [_$ConnectFluxBigBlockProps.changeBackgroundColor] -->
  @override
  Function get changeBackgroundColor =>
      props[_$key__changeBackgroundColor___$ConnectFluxBigBlockProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$ConnectFluxBigBlockProps.changeBackgroundColor] -->
  @override
  set changeBackgroundColor(Function value) => props[_$key__changeBackgroundColor___$ConnectFluxBigBlockProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__backgroundColor___$ConnectFluxBigBlockProps =
      PropDescriptor(_$key__backgroundColor___$ConnectFluxBigBlockProps);
  static const PropDescriptor _$prop__changeBackgroundColor___$ConnectFluxBigBlockProps =
      PropDescriptor(_$key__changeBackgroundColor___$ConnectFluxBigBlockProps);
  static const String _$key__backgroundColor___$ConnectFluxBigBlockProps = 'ConnectFluxBigBlockProps.backgroundColor';
  static const String _$key__changeBackgroundColor___$ConnectFluxBigBlockProps =
      'ConnectFluxBigBlockProps.changeBackgroundColor';

  static const List<PropDescriptor> $props = [
    _$prop__backgroundColor___$ConnectFluxBigBlockProps,
    _$prop__changeBackgroundColor___$ConnectFluxBigBlockProps
  ];
  static const List<String> $propKeys = [
    _$key__backgroundColor___$ConnectFluxBigBlockProps,
    _$key__changeBackgroundColor___$ConnectFluxBigBlockProps
  ];
}

const PropsMeta _$metaForConnectFluxBigBlockProps = PropsMeta(
  fields: _$ConnectFluxBigBlockPropsAccessorsMixin.$props,
  keys: _$ConnectFluxBigBlockPropsAccessorsMixin.$propKeys,
);

class ConnectFluxBigBlockProps extends _$ConnectFluxBigBlockProps with _$ConnectFluxBigBlockPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForConnectFluxBigBlockProps;
}

_$$ConnectFluxBigBlockProps _$ConnectFluxBigBlock([Map backingProps]) =>
    backingProps == null ? _$$ConnectFluxBigBlockProps$JsMap(JsBackedMap()) : _$$ConnectFluxBigBlockProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$ConnectFluxBigBlockProps extends _$ConnectFluxBigBlockProps
    with _$ConnectFluxBigBlockPropsAccessorsMixin
    implements ConnectFluxBigBlockProps {
  _$$ConnectFluxBigBlockProps._();

  factory _$$ConnectFluxBigBlockProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ConnectFluxBigBlockProps$JsMap(backingMap);
    } else {
      return _$$ConnectFluxBigBlockProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory => super.componentFactory ?? $ConnectFluxBigBlockComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'ConnectFluxBigBlockProps.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$ConnectFluxBigBlockProps$PlainMap extends _$$ConnectFluxBigBlockProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ConnectFluxBigBlockProps$PlainMap(Map backingMap)
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
class _$$ConnectFluxBigBlockProps$JsMap extends _$$ConnectFluxBigBlockProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ConnectFluxBigBlockProps$JsMap(JsBackedMap backingMap)
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
class _$ConnectFluxBigBlockComponent extends ConnectFluxBigBlockComponent {
  _$$ConnectFluxBigBlockProps$JsMap _cachedTypedProps;

  @override
  _$$ConnectFluxBigBlockProps$JsMap get props => _cachedTypedProps;

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
  _$$ConnectFluxBigBlockProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$ConnectFluxBigBlockProps$JsMap(backingMap);

  @override
  _$$ConnectFluxBigBlockProps typedPropsFactory(Map backingMap) => _$$ConnectFluxBigBlockProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$ConnectFluxBigBlockProps.
  /// Used in `ConsumedProps` if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [_$metaForConnectFluxBigBlockProps];
}
