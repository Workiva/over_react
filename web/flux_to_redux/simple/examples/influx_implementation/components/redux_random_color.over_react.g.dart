// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'redux_random_color.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $ReduxRandomColorComponentFactory = registerComponent2(
  () => _$ReduxRandomColorComponent(),
  builderFactory: ReduxRandomColor,
  componentClass: ReduxRandomColorComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'ReduxRandomColor',
);

abstract class _$ReduxRandomColorPropsAccessorsMixin
    implements _$ReduxRandomColorProps {
  @override
  Map get props;

  /// <!-- Generated from [_$ReduxRandomColorProps.backgroundColor] -->
  @override
  String get backgroundColor =>
      props[_$key__backgroundColor___$ReduxRandomColorProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$ReduxRandomColorProps.backgroundColor] -->
  @override
  set backgroundColor(String value) =>
      props[_$key__backgroundColor___$ReduxRandomColorProps] = value;

  /// <!-- Generated from [_$ReduxRandomColorProps.changeBackgroundColor] -->
  @override
  Function get changeBackgroundColor =>
      props[_$key__changeBackgroundColor___$ReduxRandomColorProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$ReduxRandomColorProps.changeBackgroundColor] -->
  @override
  set changeBackgroundColor(Function value) =>
      props[_$key__changeBackgroundColor___$ReduxRandomColorProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__backgroundColor___$ReduxRandomColorProps =
      PropDescriptor(_$key__backgroundColor___$ReduxRandomColorProps);
  static const PropDescriptor
      _$prop__changeBackgroundColor___$ReduxRandomColorProps =
      PropDescriptor(_$key__changeBackgroundColor___$ReduxRandomColorProps);
  static const String _$key__backgroundColor___$ReduxRandomColorProps =
      'ReduxRandomColorProps.backgroundColor';
  static const String _$key__changeBackgroundColor___$ReduxRandomColorProps =
      'ReduxRandomColorProps.changeBackgroundColor';

  static const List<PropDescriptor> $props = [
    _$prop__backgroundColor___$ReduxRandomColorProps,
    _$prop__changeBackgroundColor___$ReduxRandomColorProps
  ];
  static const List<String> $propKeys = [
    _$key__backgroundColor___$ReduxRandomColorProps,
    _$key__changeBackgroundColor___$ReduxRandomColorProps
  ];
}

const PropsMeta _$metaForReduxRandomColorProps = PropsMeta(
  fields: _$ReduxRandomColorPropsAccessorsMixin.$props,
  keys: _$ReduxRandomColorPropsAccessorsMixin.$propKeys,
);

class ReduxRandomColorProps extends _$ReduxRandomColorProps
    with _$ReduxRandomColorPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForReduxRandomColorProps;
}

_$$ReduxRandomColorProps _$ReduxRandomColor([Map backingProps]) =>
    backingProps == null
        ? _$$ReduxRandomColorProps$JsMap(JsBackedMap())
        : _$$ReduxRandomColorProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$ReduxRandomColorProps extends _$ReduxRandomColorProps
    with _$ReduxRandomColorPropsAccessorsMixin
    implements ReduxRandomColorProps {
  _$$ReduxRandomColorProps._();

  factory _$$ReduxRandomColorProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ReduxRandomColorProps$JsMap(backingMap);
    } else {
      return _$$ReduxRandomColorProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $ReduxRandomColorComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'ReduxRandomColorProps.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$ReduxRandomColorProps$PlainMap extends _$$ReduxRandomColorProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ReduxRandomColorProps$PlainMap(Map backingMap)
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
class _$$ReduxRandomColorProps$JsMap extends _$$ReduxRandomColorProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ReduxRandomColorProps$JsMap(JsBackedMap backingMap)
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
class _$ReduxRandomColorComponent extends ReduxRandomColorComponent {
  _$$ReduxRandomColorProps$JsMap _cachedTypedProps;

  @override
  _$$ReduxRandomColorProps$JsMap get props => _cachedTypedProps;

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
  _$$ReduxRandomColorProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$ReduxRandomColorProps$JsMap(backingMap);

  @override
  _$$ReduxRandomColorProps typedPropsFactory(Map backingMap) =>
      _$$ReduxRandomColorProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$ReduxRandomColorProps.
  /// Used in `ConsumedProps` if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForReduxRandomColorProps
  ];
}
