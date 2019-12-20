// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'connect_flux_random_color.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $ConnectFluxRandomColorComponentFactory = registerComponent2(
  () => _$ConnectFluxRandomColorComponent(),
  builderFactory: ConnectFluxRandomColor,
  componentClass: ConnectFluxRandomColorComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'ConnectFluxRandomColor',
);

abstract class _$ConnectFluxRandomColorPropsAccessorsMixin
    implements _$ConnectFluxRandomColorProps {
  @override
  Map get props;

  /// <!-- Generated from [_$ConnectFluxRandomColorProps.backgroundColor] -->
  @override
  String get backgroundColor =>
      props[_$key__backgroundColor___$ConnectFluxRandomColorProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$ConnectFluxRandomColorProps.backgroundColor] -->
  @override
  set backgroundColor(String value) =>
      props[_$key__backgroundColor___$ConnectFluxRandomColorProps] = value;

  /// <!-- Generated from [_$ConnectFluxRandomColorProps.changeBackgroundColor] -->
  @override
  Function get changeBackgroundColor =>
      props[_$key__changeBackgroundColor___$ConnectFluxRandomColorProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$ConnectFluxRandomColorProps.changeBackgroundColor] -->
  @override
  set changeBackgroundColor(Function value) =>
      props[_$key__changeBackgroundColor___$ConnectFluxRandomColorProps] =
          value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor
      _$prop__backgroundColor___$ConnectFluxRandomColorProps =
      PropDescriptor(_$key__backgroundColor___$ConnectFluxRandomColorProps);
  static const PropDescriptor
      _$prop__changeBackgroundColor___$ConnectFluxRandomColorProps =
      PropDescriptor(
          _$key__changeBackgroundColor___$ConnectFluxRandomColorProps);
  static const String _$key__backgroundColor___$ConnectFluxRandomColorProps =
      'ConnectFluxRandomColorProps.backgroundColor';
  static const String
      _$key__changeBackgroundColor___$ConnectFluxRandomColorProps =
      'ConnectFluxRandomColorProps.changeBackgroundColor';

  static const List<PropDescriptor> $props = [
    _$prop__backgroundColor___$ConnectFluxRandomColorProps,
    _$prop__changeBackgroundColor___$ConnectFluxRandomColorProps
  ];
  static const List<String> $propKeys = [
    _$key__backgroundColor___$ConnectFluxRandomColorProps,
    _$key__changeBackgroundColor___$ConnectFluxRandomColorProps
  ];
}

const PropsMeta _$metaForConnectFluxRandomColorProps = PropsMeta(
  fields: _$ConnectFluxRandomColorPropsAccessorsMixin.$props,
  keys: _$ConnectFluxRandomColorPropsAccessorsMixin.$propKeys,
);

class ConnectFluxRandomColorProps extends _$ConnectFluxRandomColorProps
    with _$ConnectFluxRandomColorPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForConnectFluxRandomColorProps;
}

_$$ConnectFluxRandomColorProps _$ConnectFluxRandomColor([Map backingProps]) =>
    backingProps == null
        ? _$$ConnectFluxRandomColorProps$JsMap(JsBackedMap())
        : _$$ConnectFluxRandomColorProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$ConnectFluxRandomColorProps
    extends _$ConnectFluxRandomColorProps
    with _$ConnectFluxRandomColorPropsAccessorsMixin
    implements ConnectFluxRandomColorProps {
  _$$ConnectFluxRandomColorProps._();

  factory _$$ConnectFluxRandomColorProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ConnectFluxRandomColorProps$JsMap(backingMap);
    } else {
      return _$$ConnectFluxRandomColorProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $ConnectFluxRandomColorComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'ConnectFluxRandomColorProps.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$ConnectFluxRandomColorProps$PlainMap
    extends _$$ConnectFluxRandomColorProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ConnectFluxRandomColorProps$PlainMap(Map backingMap)
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
class _$$ConnectFluxRandomColorProps$JsMap
    extends _$$ConnectFluxRandomColorProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ConnectFluxRandomColorProps$JsMap(JsBackedMap backingMap)
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
class _$ConnectFluxRandomColorComponent
    extends ConnectFluxRandomColorComponent {
  _$$ConnectFluxRandomColorProps$JsMap _cachedTypedProps;

  @override
  _$$ConnectFluxRandomColorProps$JsMap get props => _cachedTypedProps;

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
  _$$ConnectFluxRandomColorProps$JsMap typedPropsFactoryJs(
          JsBackedMap backingMap) =>
      _$$ConnectFluxRandomColorProps$JsMap(backingMap);

  @override
  _$$ConnectFluxRandomColorProps typedPropsFactory(Map backingMap) =>
      _$$ConnectFluxRandomColorProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$ConnectFluxRandomColorProps.
  /// Used in `ConsumedProps` if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForConnectFluxRandomColorProps
  ];
}
